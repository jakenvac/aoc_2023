struct DayOne: Solver {
    let day = 1

    func a(input: String) -> String {
        let lines = input.split(separator: "\n")
        let regex = #/[^0-9]/#
        let numbers = lines.map { line in
            let nums = line.replacing(regex, with: "")
            let (first, last) = (nums.first!, nums.last!)
            return Int("\(first)\(last)")!
        }
        return String(numbers.reduce(0, +))
    }

    func b(input: String) -> String {
        let strMap = [
            "one": "o1e",
            "two": "t2o",
            "three": "t3e",
            "four": "f4r",
            "five": "f5e",
            "six": "s6x",
            "seven": "s7n",
            "eight": "e8t",
            "nine": "n9e",
        ]

        var newInput = input

        strMap.forEach { newInput = newInput.replacingOccurrences(of: $0.key, with: $0.value) }

        return a(input: newInput)
    }
}
