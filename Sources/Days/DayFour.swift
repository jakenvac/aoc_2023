import Foundation

struct DayFour: Solver {
    let day = 4

    func a(lines: [String]) -> Int {
        let headerRegex = #/^Card \d:/#
        let pointsPerGame = lines.map { line in
            let card = line.replacing(headerRegex, with: "")
            let halves = card.split(separator: "|")
            let winning = halves[0].split(separator: " ").filter { $0 != " " }
            let drawn = halves[1].split(separator: " ").filter { $0 != " " }

            let winningCount = Set(winning).intersection(Set(drawn)).count
            let score = winningCount > 0 ? pow(Double(2), Double(winningCount - 1)) : 0

            return Int(score)
        }
        return pointsPerGame.reduce(0, +)
    }

    struct Card {
        let winning: Int
        var copies: Int = 1
    }

    func b(lines: [String]) -> Int {
        let headerRegex = #/^Card \d:/#
        var cards = lines.map { line in
            let card = line.replacing(headerRegex, with: "")
            let halves = card.split(separator: "|")
            let winning = halves[0].split(separator: " ").filter { $0 != " " }
            let drawn = halves[1].split(separator: " ").filter { $0 != " " }

            let winningCount = Set(winning).intersection(Set(drawn)).count

            return Card(winning: winningCount)
        }

        for cardIdx in 0 ..< cards.count {
            let card = cards[cardIdx]
            for w in 0 ..< card.winning {
                cards[cardIdx + w + 1].copies += card.copies
            }
        }

        let totalcards = cards.reduce(0) { $0 + $1.copies }
        return totalcards
    }
}
