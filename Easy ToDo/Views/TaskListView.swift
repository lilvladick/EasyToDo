import SwiftUI
import SwiftData

struct TaskListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [Task]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    //navlink на дедали и редакт
                    TaskView(task: task)
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Your tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "gearshape")
                    })
                    
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "arrow.up.arrow.down")
                    })
                    
                }
            }
        }
    }
    
    func deleteTask(at offset: IndexSet) {
        for index in offset {
            let task = tasks[index]
            modelContext.delete(task)
        }
        
        do {
            try modelContext.save()
        } catch {
            let nsError = error as NSError
            print("Error deleting task: \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Task.self)
    let modelContext = container.mainContext
    let tasks = [
        Task(name: "Go to gym", endDate: Date(), isComplete: false)
    ]
    
    tasks.forEach { modelContext.insert($0) }
    
    return TaskListView().modelContainer(container)
}
