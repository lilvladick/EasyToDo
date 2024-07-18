import SwiftUI

struct TaskView: View {
    @State private var isComplete = false
    let task: Task
    
    var body: some View {
        HStack {
            Button(action: {
                isComplete.toggle()
            }, label: {
                Image(systemName: isComplete ? "checkmark.circle" : "circle").tint(.black)
            })
            VStack(alignment: .leading){
                Text(task.name).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text(task.taskDescription ?? "")
                    .font(.footnote).foregroundStyle(.gray).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            Text(task.endDate.formattedDate()).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    TaskView(task: Task(name: "Go to gym", taskDescription: "Workout day", endDate: Date(), isComplete: false))
}
