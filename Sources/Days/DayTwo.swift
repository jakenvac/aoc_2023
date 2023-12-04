import RegexBuilder

struct DayTwo: Solver {
    let day = 2

    func a(lines: [String]) -> Int {
        let setRegex = #/(\d+) ([a-z]+)/#
        let gameRegex = #/^Game (\d+):/#

        let mapped: [Int] = lines.compactMap { line in
            guard let game = try? gameRegex.prefixMatch(in: line) else {
                return nil
            }
            let gameNo = Int(game.1)!

            let sets = line.matches(of: setRegex)
            for set in sets {
                let count = Int(set.1)!
                let color = set.2

                let isInvalid = switch (color, count) {
                case let ("red", r) where r > 12: true
                case let ("green", g) where g > 13: true
                case let ("blue", b) where b > 14: true
                default: false
                }

                if isInvalid {
                    return 0
                }
            }

            return gameNo
        }

        return mapped.reduce(0, +)
    }

    func b(lines: [String]) -> Int {
        let setRegex = #/(\d+) ([a-z]+)/#

        let mapped: [Int] = lines.compactMap { line in
            var minR = 0
            var minG = 0
            var minB = 0

            let sets = line.matches(of: setRegex)
            for set in sets {
                let count = Int(set.1)!
                let color = set.2

                switch color {
                case "red": minR = max(minR, count)
                case "green": minG = max(minG, count)
                case"blue": minB = max(minB, count)
                default: break
                }
            }

            return minR * minG * minB
        }

        return mapped.reduce(0, +)
    }
}
