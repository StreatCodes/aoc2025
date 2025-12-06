import Foundation

private func findOp(lastRow: [String.Element], offset: Int) -> Character {
    for c in lastRow[offset...] {
        if c != " " {
            return c
        }
    }

    fatalError("impossible")
}

func day6_2() {
    let fileURL = URL(filePath: "inputs/day6.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    var rows = lines.map({ line in Array(String(line)) })
    for i in 0..<rows.count {
        rows[i].reverse()
    }

    var total = 0
    var currentTotal = 0
    for x in 0..<rows[0].count {
        let op = findOp(lastRow: rows.last!, offset: x)
        var colText = ""
        for y in 0..<rows.count - 1 {
            colText.append(rows[y][x])
        }
        colText = colText.trimmingCharacters(in: [" "])

        guard let value = Int(colText) else {
            total += currentTotal
            currentTotal = 0
            continue
        }

        switch op {
        case "+":
            currentTotal += value
        case "*":
            if currentTotal == 0 {
                currentTotal = value
            } else {
                currentTotal *= value
            }
        default:
            print("unknown operator!!! \(op)")
        }

        if x == rows[0].count - 1 {
            total += currentTotal
        }
    }

    print("total \(total)")
}
