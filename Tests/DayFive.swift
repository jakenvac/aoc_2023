@testable import aoc_2023
import Nimble
import Quick

class DayFiveSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override class func spec() {
        describe("DayFive") {
            let day = DayFive()

            let input = """
            seeds: 79 14 55 13

            seed-to-soil map:
            50 98 2
            52 50 48

            soil-to-fertilizer map:
            0 15 37
            37 52 2
            39 0 15

            fertilizer-to-water map:
            49 53 8
            0 11 42
            42 0 7
            57 7 4

            water-to-light map:
            88 18 7
            18 25 70

            light-to-temperature map:
            45 77 23
            81 45 19
            68 64 13

            temperature-to-humidity map:
            0 69 1
            1 0 69

            humidity-to-location map:
            60 56 37
            56 93 4
            """.split(separator: "\n").map { String($0) }

            it("Should have a day of 5") {
                expect(day.day).to(equal(5))
            }

            it("Should solve part A") {
                let expected = 35
                let output = day.a(lines: input)
                expect(output).to(equal(expected))
            }

            it("Should solve part B") {
                let input = """
                """.split(separator: "\n").map { String($0) }
                let expected = 46
                let output = day.b(lines: input)
                expect(output).to(equal(expected))
            }
        }
    }
}
