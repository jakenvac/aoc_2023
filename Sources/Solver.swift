protocol Solver {
    init()

    var day: Int { get }

    func a(input: String) -> String
    func b(input: String) -> String
}

extension Solver {
    func solve(part: DayPart, input: String) -> String {
        return switch part {
        case .a: a(input: input)
        case .b: b(input: input)
        }
    }
}
