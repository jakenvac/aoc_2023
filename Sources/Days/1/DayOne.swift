struct DayOne: Solver {
    let day = 1

    func a(input: String) -> Int {
        let lines = input.split(separator: "\n")
        let regex = #/[^0-9]/#
        let numbers = lines.map { line in
            let nums = line.replacing(regex, with: "")
            let (first, last) = (nums.first!, nums.last!)
            return Int("\(first)\(last)")!
        }
        return (numbers.reduce(0, +))
    }

    func b(input: String) -> Int {
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
