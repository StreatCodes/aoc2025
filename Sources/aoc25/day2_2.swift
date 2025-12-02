import Foundation

private func equalParts(_ text: [String.Element], slice: [String.Element].SubSequence) -> Bool {
    if slice.count == text.count {
        return false
    }

    for i in stride(from: 0, to: text.count, by: slice.count) {
        if text[i..<i + slice.count] != slice {
            return false
        }
    }

    return true
}

private func isDuplicated(_ text: [String.Element]) -> Bool {
    for i in 0..<text.count {
        if text.count % (i + 1) != 0 {
            continue
        }

        let slice = text[0...i]
        if equalParts(text, slice: slice) {
            return true
        }
    }
    return false
}

private struct IdRange {
    var from: Int
    var to: Int

    init(_ text: Substring) {
        let parts = text.split(separator: "-")
        from = Int(parts[0])!
        to = Int(parts[1])!
    }

    func invalidSum() -> Int {
        var total = 0
        for id in from...to {
            let textId = Array(String(id))
            if isDuplicated(textId) {
                total += id
            }
        }

        return total
    }
}

func day2_2() {
    let fileURL = URL(filePath: "inputs/day2.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let textRanges = input.split(separator: ",")

    let ranges = textRanges.map({ textRange in IdRange(textRange) })

    var totalInvalid = 0
    for range in ranges {
        totalInvalid += range.invalidSum()
    }

    print("Total invalid \(totalInvalid)")
}
