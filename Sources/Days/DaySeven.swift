import Foundation

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

struct DaySeven: Solver {
    let day = 7

    let weights: [Character: Int] = [
        "A": 13,
        "K": 12,
        "Q": 11,
        "J": 10,
        "T": 9,
        "9": 8,
        "8": 7,
        "7": 6,
        "6": 5,
        "5": 4,
        "4": 3,
        "3": 2,
        "2": 1,
    ]

    struct Hand {
        let cards: String
        let bid: Int
        let score: Int
    }

    enum CompareResult {
        case left
        case right
    }

    func lineToHand(line: String, useJokers: Bool = false) -> Hand {
        let parts = line.split(separator: " ")
        let cards = parts[0]
        let bid = Int(parts[1])!
        var occurences = cards.reduce(into: [Character: Int]()) {
            $0[$1, default: 0] += 1
        }

        if useJokers {
            let jokerCount = occurences["J"]
            if let jokerCount = jokerCount {
                if let mostChar = (occurences
                    .filter { $0.key != "J" }
                    .max { a, b in a.value < b.value }
                )?.key {
                    occurences[mostChar, default: 0] += jokerCount
                    occurences["J"] = nil
                }
            }
        }

        let totalScore = occurences.values.reduce(0) { score, occurences in
            score + Int(pow(3.0, Double(occurences)))
        }

        return Hand(cards: String(cards), bid: bid, score: totalScore)
    }

    func sortHands(hands: [Hand], useJokers: Bool = false) -> [Hand] {
        return hands.sorted { left, right in
            let result = compareHands(left: left, right: right, useJokers: useJokers)
            switch result {
            case .left: return false
            case .right: return true
            }
        }
    }

    func oneVone(left: Hand, right: Hand, useJokers: Bool) -> CompareResult {
        for i in 0 ..< left.cards.count {
            let leftChar = left.cards[i]
            let rightChar = right.cards[i]

            let leftWeight = useJokers && leftChar == "J" ? 0 : weights[leftChar]!
            let rightWeight = useJokers && rightChar == "J" ? 0 : weights[rightChar]!

            if leftWeight > rightWeight {
                return .left
            }

            if rightWeight > leftWeight {
                return .right
            }
        }
        return .right
    }

    func compareHands(left: Hand, right: Hand, useJokers: Bool) -> CompareResult {
        if left.score > right.score {
            return .left
        }

        if right.score > left.score {
            return .right
        }

        return oneVone(left: left, right: right, useJokers: useJokers)
    }

    func a(lines: [String]) -> Int {
        let hands = sortHands(hands: lines.map { lineToHand(line: $0) })
        let totalScore = (0 ..< hands.count).reduce(0) { acc, handNo in
            let rank = handNo + 1
            let score = hands[handNo].bid * rank
            return acc + score
        }
        return totalScore
    }

    func b(lines: [String]) -> Int {
        let hands =
            sortHands(hands: lines.map { lineToHand(line: $0, useJokers: true) }, useJokers: true)
        let totalScore = (0 ..< hands.count).reduce(0) { acc, handNo in
            let rank = handNo + 1
            let score = hands[handNo].bid * rank
            return acc + score
        }
        return totalScore
    }
}
