import SwiftUI

struct WorkoutListView: View {
    var sessions: [WorkoutSession]
    var onDelete: ((IndexSet) -> Void)?

    var body: some View {
        List {
            ForEach(sessions) { session in
                VStack(alignment: .leading) {
                    ForEach(session.entries) { entry in
                        Text("\(entry.exerciseName): \(entry.weight, specifier: "%.1f") lbs x \(entry.sets) x \(entry.reps)")
                    }
                }
            }
            .onDelete(perform: onDelete)
        }
    }
}
