import Foundation

struct WorkoutEntry: Identifiable, Codable {
    let id: UUID
    var exerciseName: String
    var weight: Double
    var sets: Int
    var reps: Int

    init(id: UUID = UUID(), exerciseName: String, weight: Double, sets: Int, reps: Int) {
        self.id = id
        self.exerciseName = exerciseName
        self.weight = weight
        self.sets = sets
        self.reps = reps
    }
}
