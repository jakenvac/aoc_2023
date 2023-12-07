import Foundation

struct DayFive: Solver {
    let day = 5

    struct SeedRange {
        let sourceRange: Int
        let destRange: Int
        let length: Int
    }

    struct SeedMap {
        let name: String
        var ranges: [SeedRange]
    }

    func getSeeds(lines: [String]) -> [Int] {
        return lines[0]
            .replacing(#/seeds: /#, with: "")
            .split(separator: " ")
            .map { Int($0)! }
    }

    func getSeedRanges(lines: [String]) -> [Range<Int>] {
        let parts = lines[0]
            .replacing(#/seeds: /#, with: "")
            .split(separator: " ")

        let ranges = stride(from: 0, to: parts.count, by: 2).map { idx in
            let base = Int(parts[idx])!
            let range = Int(parts[idx + 1])!
            return base ..< base + range
        }
        return ranges
    }

    func pipeThroughMap(input: [Int], map: SeedMap) -> [Int] {
        return input.map { mapSourceToDest(source: $0, map: map) }
    }

    func mapSourceToDest(source: Int, map: SeedMap) -> Int {
        if let range = map.ranges.first(where: { r in
            source >= r.sourceRange && source < r.sourceRange + r.length
        }) {
            let offset = source - range.sourceRange
            return range.destRange + offset
        }

        return source
    }

    func mapRange(input: Range<Int>, left: Range<Int>, right: Range<Int>) -> Range<Int> {
        let lower = input.lowerBound - left.lowerBound
        let upper = input.upperBound - left.lowerBound

        let mapped = (right.lowerBound + lower) ..< (right.lowerBound + upper)
        return mapped
    }

    func pipeRangeshroughMap(input: [Range<Int>], map: SeedMap) -> [Range<Int>] {
        return input.flatMap { mapSourceRangeToDestRange(source: $0, map: map) }
    }

    func mergeRanges(ranges: [Range<Int>]) -> [Range<Int>] {
        guard !ranges.isEmpty else { return [] }

        let sorted = ranges.sorted { $0.lowerBound < $1.lowerBound }
        var merged = [Range<Int>]()
        var currentRange = sorted[0]

        for range in sorted.dropFirst() {
            if range.lowerBound <= currentRange.upperBound {
                currentRange =
                    currentRange.lowerBound ..< max(currentRange.upperBound, range.upperBound)
            } else {
                merged.append(currentRange)
                currentRange = range
            }
        }

        merged.append(currentRange)

        return merged
    }

    func getLeftovers(range: Range<Int>, mapped: [Range<Int>]) -> [Range<Int>] {
        var result = [Range<Int>]()
        var currentStart = range.lowerBound

        for checkRange in mapped.sorted(by: { $0.lowerBound < $1.lowerBound }) {
            if currentStart < checkRange.lowerBound {
                result.append(currentStart ..< checkRange.lowerBound)
            }
            currentStart = max(currentStart, checkRange.upperBound)
        }

        if currentStart < range.upperBound {
            result.append(currentStart ..< range.upperBound)
        }

        return result.filter { !$0.isEmpty }
    }

    func mapSourceRangeToDestRange(source: Range<Int>, map: SeedMap) -> [Range<Int>] {
        var coveredRanges = [Range<Int>]()
        var newRanges = map.ranges.compactMap { r -> Range<Int>? in
            let mappable = (r.sourceRange ..< r.sourceRange + r.length).clamped(to: source)
            if mappable.count == 0 {
                return nil
            }
            coveredRanges.append(mappable)
            let mapped = mapRange(
                input: mappable,
                left: r.sourceRange ..< (r.sourceRange + r.length),
                right: r.destRange ..< (r.destRange + r.length)
            )
            return mapped
        }.sorted { $0.lowerBound < $1.lowerBound }

        if newRanges.count == 0 {
            newRanges.append(source)
        } else {
            let leftovers = getLeftovers(range: source, mapped: coveredRanges)
            newRanges.append(contentsOf: leftovers)
        }

        return mergeRanges(ranges: newRanges)
    }

    func linesToSeedMaps(lines: [String]) -> [SeedMap] {
        let seedMaps = lines[1...]
            .reduce(into: [] as [SeedMap]) { maps, l in
                if l.count > 0 && l.first! != "#" {
                    if l.first!.isNumber {
                        let parts = l.split(separator: " ").map { Int($0)! }
                        let lineMap = SeedRange(
                            sourceRange: parts[1],
                            destRange: parts[0],
                            length: parts[2]
                        )
                        maps[maps.count - 1].ranges.append(lineMap)
                    } else {
                        maps.append(SeedMap(name: l, ranges: []))
                    }
                }
            }
        return seedMaps
    }

    func a(lines: [String]) -> Int {
        let seeds = getSeeds(lines: lines)
        let seedMaps = linesToSeedMaps(lines: lines)

        let locations = seedMaps.reduce(seeds) { pipeThroughMap(input: $0, map: $1) }

        return locations.min() ?? 0
    }

    func b(lines: [String]) -> Int {
        let seedRanges = getSeedRanges(lines: lines)
        let seedMaps = linesToSeedMaps(lines: lines)

        let locations = seedMaps.reduce(seedRanges) { input, map in
            let output = pipeRangeshroughMap(input: input, map: map)
            return output
        }.map { $0.lowerBound }

        return locations.min() ?? 0
    }
}
