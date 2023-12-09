import Foundation

struct DayEight: Solver {
    let day = 8

    typealias NamedNode = (String, Node)
    typealias Graph = [String: Node]

    struct Node: CustomStringConvertible {
        let left: String
        let right: String

        var description: String {
            return "L: \(left), R: \(right)"
        }
    }

    func gcd(a: Int, b: Int) -> Int {
        b == 0 ? a : gcd(a: b, b: a % b)
    }

    func lcm(nums: [Int]) -> Int {
        func lcmReduce(a: Int, b: Int) -> Int {
            a / gcd(a: a, b: b) * b
        }

        return nums.reduce(1, lcmReduce)
    }

    func lineToNode(line: String) -> NamedNode {
        // swiftlint:disable:next opening_brace
        let regex = #/([A-Z0-9]{3}) = \(([A-Z0-9]{3}), ([A-Z0-9]{3})\)/#

        let match = line.firstMatch(of: regex)!
        let name = match.output.1
        let left = match.output.2
        let right = match.output.3

        return (String(name), Node(left: String(left), right: String(right)))
    }

    func followPathToNode(
        path: String,
        from: String,
        until: (String) -> Bool,
        graph: Graph
    ) -> Int {
        var currentNodeName = from
        var currentStep = 0

        while !until(currentNodeName) {
            let lOrR = path[currentStep % path.count]
            let currentNode = graph[currentNodeName]!

            currentNodeName = lOrR == "L" ? currentNode.left : currentNode.right

            currentStep += 1
        }

        return currentStep
    }

    func a(lines: [String]) -> Int {
        let nodes = lines[1...].map(lineToNode)
        let graph = Dictionary(uniqueKeysWithValues: nodes)
        let path = lines[0]
        func condition(node: String) -> Bool {
            return node == "ZZZ"
        }
        let steps = followPathToNode(path: path, from: "AAA", until: condition, graph: graph)

        return steps
    }

    func b(lines: [String]) -> Int {
        let nodes = lines[1...].map(lineToNode)
        let graph = Dictionary(uniqueKeysWithValues: nodes)
        let path = lines[0]
        func condition(node: String) -> Bool {
            return node.last! == "Z"
        }

        let startNodes = graph.filter { $0.key.last! == "A" }.keys

        let pathsCounts = startNodes.map {
            followPathToNode(path: path, from: $0, until: condition, graph: graph)
        }

        return lcm(nums: pathsCounts)
    }
}
