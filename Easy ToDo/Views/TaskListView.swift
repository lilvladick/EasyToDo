import SwiftUI
import SwiftData

struct TaskListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [Task]
    @State private var searchText = ""
    @State private var showSettings = false
    @State private var showTaskAddings = false
    @State private var sortOrder: SortOrder = .endDate
    
    var filterTasks: [Task] {
        guard !searchText.isEmpty else { return tasks }
        
        return tasks.filter({$0.name.localizedCaseInsensitiveContains(searchText)})
    }

    var body: some View {
        NavigationStack() {
            List {
                ForEach(filterTasks.sorted(by: sortOrder.sortDescriptor)) { task in
                    TaskView(task: task)
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {
                                //edit func
                            }, label: {
                                Text("Edit")
                                Image(systemName: "pencil")
                            })
                        }))
                }.onDelete(perform: deleteTask)
            }
            .navigationTitle("Your tasks")
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .searchable(text: $searchText)
            .overlay {
                if filterTasks.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                }
            }
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
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name").tag(SortOrder.name)
                            Text("Date").tag(SortOrder.endDate)
                            Text("Completed").tag(SortOrder.isComplete)
                        }.labelsHidden()
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                }
            }
        }.animation(.default, value: sortOrder)
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
        Task(name: "Go to gym", taskDescription: "domino", endDate: Date(), isComplete: false)
    ]
    
    tasks.forEach { modelContext.insert($0) }
    
    return TaskListView().modelContainer(container)
}
