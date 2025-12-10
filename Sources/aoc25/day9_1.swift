import Foundation

private struct Position {
    var x: Int
    var y: Int

    init(_ text: String.SubSequence) {
        let parts = text.split(separator: ",")
        x = Int(parts[0])!
        y = Int(parts[1])!
    }

    func area(other: Position) -> Int {
        let xl = abs(x - other.x) + 1
        let yl = abs(y - other.y) + 1

        return xl * yl
    }
}

func day9_1() {
    let fileURL = URL(filePath: "inputs/day9.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let coords = lines.map { line in Position(line) }

    var largestArea = 0
    for i in 0..<coords.count {
        let coordA = coords[i]
        for j in i..<coords.count {
            let coordB = coords[j]
            let area = coordA.area(other: coordB)
            if area > largestArea {
                largestArea = area
            }
        }
    }

    print("Largest area \(largestArea)")
}
