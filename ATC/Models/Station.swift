import Foundation

struct Station: Identifiable, Codable {
    let id: UUID
    let name: String
    let code: String
    let frequency: String
    let streamURL: String
    let location: String
    let description: String
    
    init(id: UUID = UUID(), name: String, code: String, frequency: String, streamURL: String, location: String, description: String = "") {
        self.id = id
        self.name = name
        self.code = code
        self.frequency = frequency
        self.streamURL = streamURL
        self.location = location
        self.description = description
    }
}

extension Station {
    static let sampleStations = [
        Station(
            name: "JFK Tower",
            code: "KJFK",
            frequency: "119.1",
            streamURL: "https://s1-bos.liveatc.net/kjfk_twr",
            location: "New York, NY",
            description: "John F. Kennedy International Airport Tower"
        ),
        Station(
            name: "LAX Tower",
            code: "KLAX",
            frequency: "133.9",
            streamURL: "https://s1-fmt2.liveatc.net/klax_twr",
            location: "Los Angeles, CA",
            description: "Los Angeles International Airport Tower"
        ),
        Station(
            name: "ORD Tower",
            code: "KORD",
            frequency: "120.75",
            streamURL: "https://s1-fmt2.liveatc.net/kord_twr",
            location: "Chicago, IL",
            description: "Chicago O'Hare International Airport Tower"
        ),
        Station(
            name: "ATL Tower",
            code: "KATL",
            frequency: "119.5",
            streamURL: "https://s1-fmt2.liveatc.net/katl_twr",
            location: "Atlanta, GA",
            description: "Hartsfield-Jackson Atlanta International Airport Tower"
        ),
        Station(
            name: "SFO Tower",
            code: "KSFO",
            frequency: "120.5",
            streamURL: "https://s1-fmt2.liveatc.net/ksfo_twr",
            location: "San Francisco, CA",
            description: "San Francisco International Airport Tower"
        )
    ]
}
