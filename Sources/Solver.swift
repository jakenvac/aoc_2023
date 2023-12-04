protocol Solver {
    init()

    var day: Int { get }

    func a(lines: [String]) -> Int
    func b(lines: [String]) -> Int
}

extension Solver {
    func solve(part: DayPart, lines: [String]) -> Int {
        return switch part {
        case .a: a(lines: lines)
        case .b: b(lines: lines)
        }
    }
}
