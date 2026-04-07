import SwiftUI

struct ContentView: View {
    @StateObject private var audioManager = AudioStreamManager()
    @State private var stations = Station.sampleStations
    @State private var selectedStation: Station?
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Station List
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(stations) { station in
                                StationCardView(
                                    station: station,
                                    isPlaying: audioManager.currentStation?.id == station.id && audioManager.isPlaying,
                                    onTap: {
                                        selectedStation = station
                                        audioManager.play(station: station)
                                    }
                                )
                            }
                        }
                        .padding()
                    }
                    
                    // Now Playing Bar
                    if let current = audioManager.currentStation {
                        NowPlayingBarView(
                            station: current,
                            isPlaying: audioManager.isPlaying,
                            onPlayPause: {
                                audioManager.togglePlayPause()
                            },
                            onStop: {
                                audioManager.stop()
                            }
                        )
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            .navigationTitle("ATC Live")
            .navigationBarTitleDisplayMode(.large)
            .alert("Error", isPresented: .constant(audioManager.errorMessage != nil)) {
                Button("OK") {
                    audioManager.errorMessage = nil
                }
            } message: {
                Text(audioManager.errorMessage ?? "")
            }
        }
    }
}

struct StationCardView: View {
    let station: Station
    let isPlaying: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    Circle()
                        .fill(isPlaying ? Color.green : Color.white.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: isPlaying ? "waveform" : "tower.broadcast")
                        .font(.system(size: 28))
                        .foregroundColor(isPlaying ? .white : .white.opacity(0.9))
                }
                
                // Station Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(station.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    HStack {
                        Text(station.code)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("•")
                            .foregroundColor(.white.opacity(0.6))
                        
                        Text(station.frequency)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Text(station.location)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
                
                // Play indicator
                if isPlaying {
                    AudioVisualizerView()
                        .frame(width: 30, height: 30)
                } else {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isPlaying ? Color.green.opacity(0.3) : Color.white.opacity(0.15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isPlaying ? Color.green.opacity(0.5) : Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct NowPlayingBarView: View {
    let station: Station
    let isPlaying: Bool
    let onPlayPause: () -> Void
    let onStop: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            HStack(spacing: 16) {
                // Station Info
                VStack(alignment: .leading, spacing: 2) {
                    Text(station.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(station.code) • \(station.frequency)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                // Controls
                HStack(spacing: 20) {
                    Button(action: onPlayPause) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    
                    Button(action: onStop) {
                        Image(systemName: "stop.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
            .padding()
            .background(Color.black.opacity(0.3))
            .background(.ultraThinMaterial)
        }
    }
}

struct AudioVisualizerView: View {
    @State private var animationValues: [CGFloat] = [0.3, 0.5, 0.8, 0.4, 0.6]
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<5) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 3)
                    .scaleEffect(y: animationValues[index], anchor: .bottom)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(Double(index) * 0.1),
                        value: animationValues[index]
                    )
            }
        }
        .onAppear {
            animateVisualization()
        }
    }
    
    private func animateVisualization() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            withAnimation {
                animationValues = (0..<5).map { _ in CGFloat.random(in: 0.3...1.0) }
            }
        }
    }
}

#Preview {
    ContentView()
}
