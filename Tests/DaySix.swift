@testable import aoc_2023
import Nimble
import Quick

class DaySixSpec: QuickSpec {
    override class func spec() {
        describe("DaySix") {
            let day = DaySix()

            let input = """
            Time:      7  15   30
            Distance:  9  40  200
            """.split(separator: "\n").map { String($0) }

            it("Should have a day of 6") {
                expect(day.day).to(equal(6))
            }

            it("Should solve part A") {
                let expected = 288
                let output = day.a(lines: input)
                expect(output).to(equal(expected))
            }

            it("Should solve part B") {
                let expected = 71503
                let output = day.b(lines: input)
                expect(output).to(equal(expected))
            }
        }
    }
}
