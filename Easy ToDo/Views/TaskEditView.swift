import SwiftUI
import SwiftData

struct TaskEditView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    
    @State var task: Task
    
    @State private var taskName: String
    @State private var taskDescription: String
    @State private var endDate: Date
    @State private var priority = false
    @State private var isComplete: Bool
    
    private var notificationManager = NotificationManager()
    
    init(task: Task) {
        _task = State(initialValue: task)
        _taskName = State(initialValue: task.name)
        _taskDescription = State(initialValue: task.taskDescription ?? "")
        _endDate = State(initialValue: task.endDate)
        _isComplete = State(initialValue: task.isComplete)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Main settings") {
                    TextField("Task name", text: $taskName)
                    DatePicker("Notify date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                }
                Section("Priority") {
                    Toggle("Set priority to high", isOn: $priority)
                }
                Section("Description") {
                    TextEditor(text: $taskDescription)
                        .frame(height: 150)
                        .onReceive(taskDescription.publisher.collect()) {
                            self.taskDescription = String($0.prefix(150))
                        }
                }
            }
            .navigationTitle("Editing '\(task.name)'")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        updateTask()
                        dismiss()
                    }) {
                        Text("Update")
                    }
                }
            }
            .preferredColorScheme(isDarkmodeOn ? .dark : .light)
        }
    }
    
    private func updateTask() {
        task.name = taskName
        task.taskDescription = taskDescription
        task.endDate = endDate
        task.isComplete = isComplete
        
        notificationManager.scheduleNotification(for: task)
        
        try? modelContext.save()
    }
}

#Preview {
    TaskEditView(task: Task(name: "Go to gym", taskDescription: "domino", endDate: Date(), isComplete: false))
}
