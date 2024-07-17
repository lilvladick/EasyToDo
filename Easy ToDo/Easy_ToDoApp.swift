import SwiftUI
import SwiftData

@main
struct Easy_ToDoApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Task.self)
        } catch {
            fatalError("Initialize error: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            
        }
        .modelContainer(container)
    }
}
