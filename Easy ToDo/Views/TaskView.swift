import SwiftUI

struct TaskView: View {
    let task: Task
    
    var body: some View {
        HStack {
            Button(action: {
                print("circle")
            }, label: {
                Image(systemName: "circle")
            })
            VStack {
                Text(task.name)
                Text(task.taskDescription ?? "")
            }
            Spacer()
            Text(task.endDate.formattedDate())
        }
    }
}

#Preview {
    TaskView(task: Task(name: "Go to gym", taskDescription: "Workout day", endDate: Date(), isComplete: false))
}
