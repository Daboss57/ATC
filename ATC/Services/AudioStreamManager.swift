import Foundation
import AVFoundation
import Combine

class AudioStreamManager: NSObject, ObservableObject {
    @Published var isPlaying = false
    @Published var currentStation: Station?
    @Published var errorMessage: String?
    @Published var bufferProgress: Double = 0.0
    
    private var player: AVPlayer?
    private var timeObserver: Any?
    private var statusObserver: NSKeyValueObservation?
    
    override init() {
        super.init()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            errorMessage = "Failed to setup audio session: \(error.localizedDescription)"
        }
    }
    
    func play(station: Station) {
        stop()
        
        guard let url = URL(string: station.streamURL) else {
            errorMessage = "Invalid stream URL"
            return
        }
        
        currentStation = station
        errorMessage = nil
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        // Observe player status
        statusObserver = playerItem.observe(\.status, options: [.new]) { [weak self] item, _ in
            DispatchQueue.main.async {
                switch item.status {
                case .readyToPlay:
                    self?.player?.play()
                    self?.isPlaying = true
                case .failed:
                    self?.errorMessage = "Failed to load stream: \(item.error?.localizedDescription ?? "Unknown error")"
                    self?.isPlaying = false
                case .unknown:
                    break
                @unknown default:
                    break
                }
            }
        }
        
        // Observe buffer progress
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] _ in
            guard let item = self?.player?.currentItem else { return }
            
            if let timeRange = item.loadedTimeRanges.first?.timeRangeValue {
                let bufferedTime = CMTimeGetSeconds(CMTimeAdd(timeRange.start, timeRange.duration))
                let duration = CMTimeGetSeconds(item.duration)
                
                if duration.isFinite && duration > 0 {
                    self?.bufferProgress = bufferedTime / duration
                }
            }
        }
        
        // Handle interruptions
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleInterruption),
            name: AVAudioSession.interruptionNotification,
            object: nil
        )
    }
    
    func stop() {
        player?.pause()
        player = nil
        isPlaying = false
        currentStation = nil
        bufferProgress = 0.0
        
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }
        
        statusObserver?.invalidate()
        statusObserver = nil
    }
    
    func togglePlayPause() {
        guard let player = player else { return }
        
        if isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    @objc private func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }
        
        switch type {
        case .began:
            player?.pause()
            isPlaying = false
        case .ended:
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
            if options.contains(.shouldResume) {
                player?.play()
                isPlaying = true
            }
        @unknown default:
            break
        }
    }
    
    deinit {
        stop()
        NotificationCenter.default.removeObserver(self)
    }
}
