import Foundation
import Combine

class WorkoutViewModel: ObservableObject {
    @Published var sessions: [WorkoutSession] = []

    func addSession(_ session: WorkoutSession) {
        sessions.append(session)
        saveSessions()
    }

    func saveSessions() {
        if let encoded = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(encoded, forKey: "workoutSessions")
        }
    }

    func loadSessions() {
        if let data = UserDefaults.standard.data(forKey: "workoutSessions"),
           let decoded = try? JSONDecoder().decode([WorkoutSession].self, from: data) {
            sessions = decoded
        }
    }
}
