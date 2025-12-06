import Foundation

func day6_1() {
    let fileURL = URL(filePath: "inputs/day6.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let rows = lines.map({ line in line.split(separator: " ") })

    var total = 0
    for x in 0..<rows[0].count {
        let op = rows.last![x]
        var colTotal = 0
        for y in 0..<rows.count - 1 {
            let value = Int(rows[y][x])!
            switch op {
            case "+":
                colTotal += value
            case "*":
                if y == 0 {
                    colTotal = value
                } else {
                    colTotal *= value
                }
            default:
                print("unknown operator!!! \(op)")
            }
        }
        total += colTotal
    }

    print("total \(total)")
}
