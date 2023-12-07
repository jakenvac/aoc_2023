@testable import aoc_2023
import Nimble
import Quick

class DaySevenSpec: QuickSpec {
    override class func spec() {
        describe("DaySeven") {
            let day = DaySeven()

            let input = """
            32T3K 765
            T55J5 684
            KK677 28
            KTJJT 220
            QQQJA 483
            """.split(separator: "\n").map { String($0) }

            it("Should have a day of 7") {
                expect(day.day).to(equal(7))
            }

            it("Should solve part A") {
                let expected = 6440
                let output = day.a(lines: input)
                expect(output).to(equal(expected))
            }

            it("Should solve part B") {
                let expected = 5905
                let output = day.b(lines: input)
                expect(output).to(equal(expected))
            }
        }
    }
}
