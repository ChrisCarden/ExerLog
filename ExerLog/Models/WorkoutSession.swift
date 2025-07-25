import Foundation

struct WorkoutSession: Identifiable, Codable {
    let id: UUID
    var date: Date
    var entries: [WorkoutEntry]

    init(id: UUID = UUID(), date: Date = Date(), entries: [WorkoutEntry]) {
        self.id = id
        self.date = date
        self.entries = entries
    }
}
