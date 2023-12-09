import ArgumentParser

var days: [Int: Solver.Type] = [:]
// woop woop 1 based indexing
days[1] = DayOne.self
days[2] = DayTwo.self
days[3] = DayThree.self
days[4] = DayFour.self
days[5] = DayFive.self
days[6] = DaySix.self
days[7] = DaySeven.self
days[8] = DayEight.self

struct AOCError: Error {
    var message: String
}

enum DayPart: String, CaseIterable, ExpressibleByArgument {
    case a, b
}

struct AOC: ParsableCommand {
    @Argument(help: "The day to process")
    var day: Int

    @Argument(help: "The part of the day to process")
    var part: DayPart

    func run() throws {
        guard let input = loader(day: day) else {
            throw AOCError(message: "No input found for day \(day).")
        }

        guard let solver = days[day] else {
            throw AOCError(message: "No solution found for day \(day).")
        }

        let lines = input.split(separator: "\n").map { String($0) }

        let result = solver.init().solve(part: part, lines: lines)
        print(result)
    }
}

AOC.main()
