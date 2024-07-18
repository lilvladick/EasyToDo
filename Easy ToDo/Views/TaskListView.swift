import SwiftUI
import SwiftData

struct TaskListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [Task]
    @State private var searchText = ""
    @State private var showSettings = false
    @State private var showTaskAddings = false
    @State private var sortType = "By date"
    
    let sortOptions = ["Sort by name","Sort by status","Sort by date"]
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    NavigationLink(destination: DetailTaskView(task: task)) {
                        TaskView(task: task)
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Your tasks")
            .searchable(text: $searchText) 
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showTaskAddings.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showTaskAddings) {
                        AddTaskForm()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }, label: {
                        Image(systemName: "gearshape")
                    }).fullScreenCover(isPresented: $showSettings, content: {
                        SettingsView()
                    })
                }
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("penis", selection: $sortType) {
                            ForEach(sortOptions, id: \.self) {
                                Text($0)
                            }
                        }.labelsHidden()
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
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
        Task(name: "Go to gym",taskDescription: "domino", endDate: Date(), isComplete: false)
    ]
    
    tasks.forEach { modelContext.insert($0) }
    
    return TaskListView().modelContainer(container)
}
