import SwiftUI

struct TaskView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isComplete: Bool
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    let task: Task
    
    init(task: Task) {
        self.task = task
        _isComplete = State(initialValue: task.isComplete)
    }
    
    var body: some View {
        HStack {
            Button(action: {
                isComplete.toggle()
                task.isComplete = isComplete
                do {
                    try modelContext.save()
               } catch {
                   print("Error saving context: $$error)")
               }
            }, label: {
                Image(systemName: isComplete ? "circle.inset.filled" : "circle").tint(isDarkmodeOn ? Color.white : Color.black)
            })
            VStack(alignment: .leading){
                Text(task.name).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text(task.taskDescription ?? "")
                    .font(.footnote).foregroundStyle(.gray).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            Text(task.endDate.formattedDate()).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        .preferredColorScheme(isDarkmodeOn ? .dark : .light)
    }
}

#Preview {
    TaskView(task: Task(name: "Go to gym", taskDescription: "Workout day", endDate: Date(), isComplete: false))
}
