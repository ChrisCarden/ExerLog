import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: WorkoutViewModel
    var date: Date

    //@State private var date = Date()
    @State private var entries: [WorkoutEntry] = []

    @State private var exerciseName = ""
    @State private var weight: String = ""
    @State private var sets: String = ""
    @State private var reps: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise")) {
                    TextField("Name", text: $exerciseName)
                    TextField("Weight (lbs)", text: $weight)
                        .keyboardType(.decimalPad)
                    TextField("Sets", text: $sets)
                        .keyboardType(.numberPad)
                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)
                    Button("Add Exercise") {
                        if let w = Double(weight), let s = Int(sets), let r = Int(reps), !exerciseName.isEmpty {
                            let newEntry = WorkoutEntry(exerciseName: exerciseName, weight: w, sets: s, reps: r)
                            entries.append(newEntry)
                            exerciseName = ""
                            weight = ""
                            sets = ""
                            reps = ""
                        }
                    }
                }

                if !entries.isEmpty {
                    Section(header: Text("Exercises Added")) {
                        ForEach(entries) { entry in
                            Text("\(entry.exerciseName): \(entry.weight, specifier: "%.1f") x \(entry.sets) x \(entry.reps)")
                        }
                    }
                }
            }
            .navigationTitle("New Workout")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newSession = WorkoutSession(date: date, entries: entries)
                        viewModel.addSession(newSession)
                        dismiss()
                    }
                    .disabled(entries.isEmpty)
                }
            }
        }
        Button("Save") {
            let newSession = WorkoutSession(date: date, entries: entries)
            viewModel.addSession(newSession)
            dismiss()
        }
    }
}
