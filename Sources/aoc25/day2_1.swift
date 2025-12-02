import Foundation

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
            if textId.count % 2 != 0 {
                continue
            }

            let half = textId.count / 2
            let firstHalf = textId[0..<half]
            let secondHalf = textId[half...]

            if firstHalf == secondHalf {
                total += id
            }
        }

        return total
    }
}

func day2_1() {
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
