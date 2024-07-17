import SwiftUI
import SwiftData

struct AddTaskForm: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    @State private var taskName = ""
    @State private var taskDescription = ""
    @State private var endDate = Date()
    @State private var priority = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("main settings") {
                    TextField("task name", text: $taskName)
                    DatePicker("Notify date", selection: $endDate, displayedComponents: .date)
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
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Save")
                    })
                }
            }
        }
    }
}

#Preview {
    AddTaskForm()
}
