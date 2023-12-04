@testable import aoc_2023
import Nimble
import Quick

class DayOneSpec: QuickSpec {
    override class func spec() {
        describe("DayOne") {
            var day = DayOne()

            it("Should have a day of 1") {
                expect(day.day).to(equal(1))
            }

            it("Should solve part A") {
                let input = """
                1abc2
                pqr3stu8vwx
                a1b2c3d4e5f
                treb7uchet
                """.split(separator: "\n").map { String($0) }
                let expected = 142
                let output = day.a(lines: input)
                expect(output).to(equal(expected))
            }

            it("Should solve part B") {
                let input = """
                two1nine
                eightwothree
                abcone2threexyz
                xtwone3four
                4nineeightseven2
                zoneight234
                7pqrstsixteen
                """.split(separator: "\n").map { String($0) }
                let expected = 281
                let output = day.b(lines: input)
                expect(output).to(equal(expected))
            }
        }
    }
}
