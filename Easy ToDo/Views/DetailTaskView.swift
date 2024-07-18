import SwiftUI
import SwiftData

struct DetailTaskView: View {
    @Bindable var task: Task
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailTaskView(task: Task(name: "Water Plants", endDate: Date(), isComplete: false))
}
