import SwiftUI

struct CalendarView: View {
    @StateObject var viewModel = WorkoutViewModel()
    @State private var selectedDate = Date()
    @State private var showingAddWorkout = false

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()

                WorkoutListView(sessions: filteredSessions, onDelete: deleteSession)
            }
            .navigationTitle("Workout Log")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddWorkout = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkoutView(viewModel: viewModel, date: selectedDate)
            }
            .onAppear {
                viewModel.loadSessions()
            }
        }
    }

    var filteredSessions: [WorkoutSession] {
        viewModel.sessions.filter {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }
    }

    func deleteSession(at offsets: IndexSet) {
        let toDelete = filteredSessions
        for index in offsets {
            if let actualIndex = viewModel.sessions.firstIndex(where: { $0.id == toDelete[index].id }) {
                viewModel.sessions.remove(at: actualIndex)
            }
        }
        viewModel.saveSessions()
    }
}
