import Foundation
import SwiftData

@Model
final class Task {
    let id = UUID()
    var name: String
    var taskDescription: String?
    var endDate: Date
    var isComplete: Bool
    
    init(name: String, taskDescription: String? = nil, endDate: Date, isComplete: Bool) {
        self.name = name
        self.taskDescription = taskDescription ?? ""
        self.endDate = endDate
        self.isComplete = isComplete
    }
}
