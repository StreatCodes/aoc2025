import Foundation

private struct Coordinate: Hashable {
    var line: Int
    var column: Int
}

private func countTimelines(
    _ cache: inout [Coordinate: Int], lines: [[Substring.Element]], lineIndex: Int, i: Int
) -> Int {
    let line = lines[lineIndex]
    if lineIndex == lines.count - 1 {
        return 1
    }

    var timelines = 0
    if line[i] == "^" {
        if i > 0 && line[i - 1] == "." {
            if lineIndex + 1 < lines.count {
                if let cached = cache[Coordinate(line: lineIndex, column: i - 1)] {
                    timelines += cached
                } else {
                    let additionalTimelines = countTimelines(
                        &cache, lines: lines, lineIndex: lineIndex + 1, i: i - 1)
                    timelines += additionalTimelines
                    cache[Coordinate(line: lineIndex, column: i - 1)] = additionalTimelines
                }
            }
        }

        if i < line.count - 1 && line[i + 1] == "." {
            if lineIndex + 1 < lines.count {
                if let cached = cache[Coordinate(line: lineIndex, column: i + 1)] {
                    timelines += cached
                } else {
                    let additionalTimelines = countTimelines(
                        &cache, lines: lines, lineIndex: lineIndex + 1, i: i + 1)
                    timelines += additionalTimelines
                    cache[Coordinate(line: lineIndex, column: i + 1)] = additionalTimelines
                }
            }
        }

    } else {
        if lineIndex + 1 < lines.count {
            return countTimelines(&cache, lines: lines, lineIndex: lineIndex + 1, i: i)
        }
    }

    return timelines
}

func day7_2() {
    let fileURL = URL(filePath: "inputs/day7.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let _lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let lines = _lines.map({ l in Array(l) })

    var cache = [Coordinate: Int]()
    let pos = lines[0].firstIndex(of: "S")!
    let totalTimlines = countTimelines(&cache, lines: lines, lineIndex: 1, i: pos)

    print("Split count \(totalTimlines)")
}
