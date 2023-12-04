import RegexBuilder

struct NumberRange {
    var start: Int
    var end: Int
}

struct DayThree: Solver {
    let day = 3

    private func extractRange(line: String?, start: Int, end: Int) -> Substring {
        guard let line = line else {
            return ""
        }

        let safeStart = max(start, 0)
        let safeEnd = min(end, line.count - 1)

        guard safeStart <= safeEnd else {
            return ""
        }

        let startIndex = line.index(
            line.startIndex,
            offsetBy: safeStart
        )

        let endIndex = line.index(
            line.startIndex,
            offsetBy: safeEnd
        )

        let number = line[startIndex ... endIndex]

        return number
    }

    private func hasSymbols(str: Substring) -> Bool {
        let regex = #/[^0-9.]/#
        let m = str.matches(of: regex)
        return m.count > 0
    }

    private func findNumbers(str: String) -> [NumberRange] {
        var ranges: [NumberRange] = []

        var firstDigitInChunk = -1
        var lastDigitInChunk = -1
        for (i, c) in str.enumerated() {
            if c.isNumber {
                if firstDigitInChunk == -1 {
                    firstDigitInChunk = i
                    lastDigitInChunk = i
                } else {
                    lastDigitInChunk = i
                }
            }

            if (i == str.count - 1 || !c.isNumber) && (firstDigitInChunk != -1) {
                let range = NumberRange(
                    start: firstDigitInChunk,
                    end: lastDigitInChunk
                )

                ranges.append(range)

                lastDigitInChunk = -1
                firstDigitInChunk = -1
            }
        }

        return ranges
    }

    func a(lines: [String]) -> Int {
        let numbers = lines.enumerated().flatMap { index, line in
            let lastLine: String? = index == 0 ? nil : lines[index - 1]
            let nextLine: String? = index == lines.count - 1 ? nil : lines[index + 1]
            let validNumbers = findNumbers(str: line).compactMap { r in

                let above = extractRange(line: lastLine, start: r.start - 1, end: r.end + 1)
                let current = extractRange(line: line, start: r.start - 1, end: r.end + 1)
                let below = extractRange(line: nextLine, start: r.start - 1, end: r.end + 1)

                if hasSymbols(str: above) || hasSymbols(str: below) || hasSymbols(str: current) {
                    let num = extractRange(line: line, start: r.start, end: r.end)
                    return Int(num)!
                }

                return nil
            }
            return validNumbers
        }
        return numbers.reduce(0, +)
    }

    func b(lines: [String]) -> Int {
        let numbers = lines.enumerated().reduce(into: [Int: [NumberRange]]()) { dict, tuple in
            let (index, line) = tuple
            let validNumbers = findNumbers(str: line)
            dict[index] = validNumbers
        }

        let ratios = lines.enumerated().flatMap { row, line in
            let ratios: [Int] = line.enumerated().compactMap { col, c in
                if c != "*" { return nil }
                func mapAdjacent(row: Int, num: NumberRange) -> Int? {
                    if (num.start <= col && num.end >= col) ||
                        num.end == col - 1 ||
                        num.start == col + 1 {
                        let numberStr = extractRange(
                            line: lines[row],
                            start: num.start,
                            end: num.end
                        )
                        return Int(numberStr)!
                    }

                    return nil
                }

                let aboveRowNums = numbers[row - 1]
                let currentRowNums = numbers[row]
                let belowRowNums = numbers[row + 1]

                var adjacent: [Int] = []

                if let arn = aboveRowNums {
                    let numbers = arn
                        .compactMap { mapAdjacent(row: row - 1, num: $0) }
                    adjacent.append(contentsOf: numbers)
                }

                if let crn = currentRowNums {
                    let numbers = crn
                        .compactMap { mapAdjacent(row: row, num: $0) }
                    adjacent.append(contentsOf: numbers)
                }

                if let brn = belowRowNums {
                    let numbers = brn
                        .compactMap { mapAdjacent(row: row + 1, num: $0) }
                    adjacent.append(contentsOf: numbers)
                }

                if adjacent.count == 2 {
                    return adjacent.reduce(1, *)
                }

                return nil
            }
            return ratios
        }

        return ratios.reduce(0, +)
    }
}
