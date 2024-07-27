import SwiftUI
import SwiftData
import WidgetKit

struct AddTaskForm: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @State private var taskName = ""
    @State private var taskDescription = ""
    @State private var endDate = Date()
    @State private var priority = false
    @State private var isComplete = false
    private var notificationManager = NotificationManager()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("main settings") {
                    TextField("task name", text: $taskName)
                    DatePicker("Notify date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                }
                Section("priority ") {
                    Toggle("Set priority to high", isOn: $priority)
                }
                Section("Description") {
                    TextEditor(text: $taskDescription).frame(height: 150)
                        .onReceive(taskDescription.publisher.collect()) {
                            self.taskDescription = String($0.prefix(150))
                        }
                }
            }
            .navigationTitle("Create new task")
            .onAppear {
                notificationManager.requestAuthorization()
                WidgetCenter.shared.reloadTimelines(ofKind: "EasyToDo_widget")
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        saveTask()
                    }, label: {
                        Text("Save")
                    })
                }
            }
        }
        .preferredColorScheme(isDarkmodeOn ? .dark : .light)
    }
    
    private func saveTask() {
        let newTask = Task(
            name: taskName, 
            taskDescription: taskDescription,
            endDate: endDate,
            isComplete: isComplete
        )
        
        modelContext.insert(newTask)
        
        notificationManager.scheduleNotification(for: newTask)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    AddTaskForm()
}
