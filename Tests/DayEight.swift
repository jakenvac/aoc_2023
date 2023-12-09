@testable import aoc_2023
import Nimble
import Quick

class DayEightSpec: QuickSpec {
    override class func spec() {
        describe("DayEight") {
            let day = DayEight()

            it("Should have a day of 8") {
                expect(day.day).to(equal(8))
            }

            it("Should solve part A") {
                let input = """
                LLR

                AAA = (BBB, BBB)
                BBB = (AAA, ZZZ)
                ZZZ = (ZZZ, ZZZ)
                """.split(separator: "\n").map { String($0) }

                let expected = 6
                let output = day.a(lines: input)
                expect(output).to(equal(expected))
            }

            it("Should solve part B") {
                let input = """
                 LR

                11A = (11B, XXX)
                11B = (XXX, 11Z)
                11Z = (11B, XXX)
                22A = (22B, XXX)
                22B = (22C, 22C)
                22C = (22Z, 22Z)
                22Z = (22B, 22B)
                XXX = (XXX, XXX)
                """.split(separator: "\n").map { String($0) }
                let expected = 6
                let output = day.b(lines: input)
                expect(output).to(equal(expected))
            }
        }
    }
}
