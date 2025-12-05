import Foundation

private struct Range {
    var start: Int
    var end: Int

    init(_ text: String.SubSequence) {
        let parts = text.split(separator: "-")
        start = Int(parts[0])!
        end = Int(parts[1])!
    }

    func isFresh(ingredientId: Int) -> Bool {
        return ingredientId >= start && ingredientId <= end
    }

    mutating func merge(other: Range) -> Bool {
        if (other.start >= start && other.start <= end) || (other.end >= start && other.end <= end)
            || (other.start < start && other.end > end)
        {
            start = start < other.start ? start : other.start
            end = end > other.end ? end : other.end
            return true
        }

        return false
    }

    func count() -> Int {
        return end - start + 1
    }
}

func day5_2() {
    let fileURL = URL(filePath: "inputs/day5.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    var ranges = [Range]()

    for line in lines {
        if line == "" {
            break
        }

        ranges.append(Range(line))
    }

    loop: while true {
        var normalised = true
        for i in 0..<ranges.count {
            if i == ranges.count - 1 { break }
            for j in (i + 1)..<ranges.count {
                let consumed = ranges[i].merge(other: ranges[j])
                if consumed {
                    ranges.remove(at: j)
                    normalised = false
                    continue loop
                }
            }

        }
        if normalised { break }
    }

    var total = 0
    for range in ranges {
        total += range.count()
    }

    print("Fresh ingredients \(total)")
}
