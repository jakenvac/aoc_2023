import Foundation

struct DayNine: Solver {
    let day = 9

    func finiteDifferenceNext(sequence s: [Int]) -> Int {
        let diffs = (1 ..< s.count).map { s[$0] - s[$0 - 1] }
        if diffs.allSatisfy({ $0 == diffs[0] }) { return s.last! + diffs[0] }
        return finiteDifferenceNext(sequence: diffs) + s.last!
    }

    func finiteDifferencePrev(sequence s: [Int]) -> Int {
        let diffs = (1 ..< s.count).map { s[$0] - s[$0 - 1] }
        if diffs.allSatisfy({ $0 == diffs[0] }) { return s.first! - diffs[0] }
        return s.first! - finiteDifferencePrev(sequence: diffs)
    }

    func a(lines: [String]) -> Int {
        let numbers = lines.map { $0.split(separator: " ").map { Int($0)! } }
        let nexts = numbers.map { finiteDifferenceNext(sequence: $0) }
        let total = nexts.reduce(0, +)
        return total
    }

    func b(lines: [String]) -> Int {
        let numbers = lines.map { $0.split(separator: " ").map { Int($0)! } }
        let nexts = numbers.map { finiteDifferencePrev(sequence: $0) }
        let total = nexts.reduce(0, +)
        return total
    }
}
