import Foundation

struct DaySix: Solver {
    let day = 6

    func parseLineIntoParts(line: String) -> [Int] {
        let prefix = #/.+: +/#
        return line.replacing(prefix, with: "").split(separator: #/ +/#).map { Int($0)! }
    }

    func parseLineIntoNumber(line: String) -> Int {
        let prefix = #/.+: +/#
        return Int(line.replacing(prefix, with: "").replacing(#/ +/#, with: ""))!
    }

    func a(lines: [String]) -> Int {
        let times = parseLineIntoParts(line: lines[0])
        let distances = parseLineIntoParts(line: lines[1])

        let races = (0 ..< times.count)

        let allWins = races.map { r in
            let time = times[r]
            let targetDistance = distances[r]

            let possibleWins = (0 ..< time).reduce(0) { wins, timeHeld in
                let timeToRace = time - timeHeld
                let distanceTraveled = timeToRace * timeHeld
                return distanceTraveled > targetDistance ? wins + 1 : wins
            }

            return possibleWins
        }

        return allWins.reduce(1, *)
    }

    func b(lines: [String]) -> Int {
        let time = parseLineIntoNumber(line: lines[0])
        let targetDistance = parseLineIntoNumber(line: lines[1])
        let possibleWins = (0 ..< time).reduce(0) { wins, timeHeld in
            let timeToRace = time - timeHeld
            let distanceTraveled = timeToRace * timeHeld
            return distanceTraveled > targetDistance ? wins + 1 : wins
        }
        return possibleWins
    }
}
