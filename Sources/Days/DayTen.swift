import Foundation

struct DayTen: Solver {
    let day = 10

    enum Dir: Int {
        case north = 1
        case east = 2
        case south = -1
        case west = -2
    }

    struct Coord: Equatable { let row, col: Int }
    typealias Connections = [Dir]
    typealias Map = [[Connections]]

    let pipes: [Character: Connections] = [
        ".": [],
        "L": [.north, .east],
        "F": [.east, .south],
        "7": [.south, .west],
        "J": [.west, .north],
        "|": [.north, .south],
        "-": [.west, .east],
        "S": [.north, .west, .east, .south],
    ]

    func findStart(map: Map) -> Coord {
        for row in 0 ..< map.count {
            for c in 0 ..< map[row].count where map[row][c] == pipes["S"] {
                return Coord(row: row, col: c)
            }
        }
        fatalError("Start not found in map")
    }

    func getConnectedPaths(coord: Coord, map: Map) -> [Coord] {
        let current = map[coord.row][coord.col]
        return current.compactMap { dir in
            switch dir {
            case .north:
                if coord.row != 0 &&
                    map[coord.row - 1][coord.col].contains(.south) {
                    return Coord(row: coord.row - 1, col: coord.col)
                }
            case .east:
                if coord.col < map[0].count &&
                    map[coord.row][coord.col + 1].contains(.west) {
                    return Coord(row: coord.row, col: coord.col + 1)
                }
            case .south:
                if coord.row < map.count &&
                    map[coord.row + 1][coord.col].contains(.north) {
                    return Coord(row: coord.row + 1, col: coord.col)
                }
            case .west:
                if coord.col != 0 &&
                    map[coord.row][coord.col - 1].contains(.east) {
                    return Coord(row: coord.row, col: coord.col - 1)
                }
            }
            return nil
        }
    }

    func walkPath(path: [Coord], curr: Coord, dest: Coord, map: Map) -> [Coord] {
        if path.count > 0 && curr == dest { return path }
        let paths = getConnectedPaths(coord: curr, map: map)
        let next = paths.first { path.last == nil || $0 != path.last }!
        return walkPath(path: path + [curr], curr: next, dest: dest, map: map)
    }

    func buildMap(lines: [String]) -> Map {
        let map = lines.map { $0.split(separator: "").map { pipes[$0.first!]! } }
        return map
    }

    func a(lines: [String]) -> Int {
        let map = buildMap(lines: lines)
        let start = findStart(map: map)
        let path = walkPath(path: [], curr: start, dest: start, map: map)
        return Int(floor(Double(path.count) / 2.00))
    }

    /// !! TURN ON THE PRINTS IN HERE. IT'S COOL AF
    func countInside(row: Int, path: [Coord], map: Map) -> Int {
        var inside = false
        var lastTrigger: [Dir] = [.north, .south]
        // print("")
        return (0 ..< map[row].count).reduce(0) { acc, c in
            let p = map[row][c]
            if path.contains(Coord(row: row, col: c)) {
                // print(pipes.first { $0.value == p }!.key, terminator: "")
                if lastTrigger.contains(.north) && p.contains(.north) {
                    lastTrigger = p
                    inside = !inside
                } else if lastTrigger.contains(.south) && p.contains(.south) {
                    lastTrigger = p
                    inside = !inside
                }
                return acc
            } else if inside {
                // print("I", terminator: "")
                return acc + 1
            } else {
                // print("O", terminator: "")
                return acc
            }
        }
    }

    func b(lines: [String]) -> Int {
        let map = buildMap(lines: lines)
        let start = findStart(map: map)
        let path = walkPath(path: [], curr: start, dest: start, map: map)
        let insideRows = (0 ..< map.count).map { countInside(row: $0, path: path, map: map) }
        return insideRows.reduce(0, +)
    }
}
