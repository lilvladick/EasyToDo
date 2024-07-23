import Foundation

enum SortOrder: String, CaseIterable, Identifiable {
    case name, endDate, isComplete

    var id: String { rawValue }

    var sortDescriptor: (Task, Task) -> Bool {
        switch self {
        case .name:
            return { 
                if $0.isComplete != $1.isComplete {
                    return !$0.isComplete && $1.isComplete
                }
                return $0.name < $1.name
            }
        case .endDate:
            return {
                if $0.isComplete != $1.isComplete {
                    return !$0.isComplete && $1.isComplete
                }
                return $0.endDate < $1.endDate
            }
        case .isComplete:
            return {
                let lhs = $0.isComplete ? 1 : 0
                let rhs = $1.isComplete ? 1 : 0
                return rhs < lhs
            }
        }
    }
}
