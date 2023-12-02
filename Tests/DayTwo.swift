@testable import aoc_2023
import Nimble
import Quick

class DayTwoSpec: QuickSpec {
    override class func spec() {
        describe("DayTwo") {
            let day = DayTwo()

            it("Should have a day of 2") {
                expect(day.day).to(equal(2))
            }

            it("Should solve part A") {
                let input = """
                Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
                Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
                Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
                Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
                Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
                """
                let expected = 8
                let output = day.a(input: input)
                expect(output).to(equal(expected))
            }

            it("Should solve part B") {
                let input = """
                Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
                Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
                Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
                Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
                Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
                """
                let expected = 2286
                let output = day.b(input: input)
                expect(output).to(equal(expected))
            }
        }
    }
}
