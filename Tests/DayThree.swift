@testable import aoc_2023
import Nimble
import Quick

class DayThreeSpec: QuickSpec {
    override class func spec() {
        describe("DayThree") {
            let day = DayThree()

            it("Should have a day of 3") {
                expect(day.day).to(equal(3))
            }

            it("Should solve part A") {
                let input = """
                467..114..
                ...*......
                ..35..633.
                ......#...
                617*......
                .....+.58.
                ..592.....
                ......755.
                ...$.*....
                .664.598..
                """
                let expected = 4361
                let output = day.a(input: input)
                expect(output).to(equal(expected))
            }

            it("Should solve part B") {
                let input = """
                467..114..
                ...*......
                ..35..633.
                ......#...
                617*......
                .....+.58.
                ..592.....
                ......755.
                ...$.*....
                .664.598..
                """
                let expected = 467835
                let output = day.b(input: input)
                expect(output).to(equal(expected))
            }
        }
    }
}
