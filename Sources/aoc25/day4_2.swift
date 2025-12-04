import Foundation

private func countAdjacent(rolls: [[Substring.Element]], x: Int, y: Int) -> Int? {
    if rolls[y][x] == "." { return nil }
    let maxX = rolls[y].count - 1
    let maxY = rolls.count - 1

    var count = 0
    if x > 0 && y > 0 && rolls[y - 1][x - 1] == "@" { count += 1 }
    if y > 0 && rolls[y - 1][x] == "@" { count += 1 }
    if x < maxX && y > 0 && rolls[y - 1][x + 1] == "@" { count += 1 }

    if x > 0 && rolls[y][x - 1] == "@" { count += 1 }
    if x < maxX && rolls[y][x + 1] == "@" { count += 1 }

    if y < maxY && x > 0 && rolls[y + 1][x - 1] == "@" { count += 1 }
    if y < maxY && rolls[y + 1][x] == "@" { count += 1 }
    if y < maxY && x < maxX && rolls[y + 1][x + 1] == "@" { count += 1 }

    return count
}

struct Removeable {
    var x: Int
    var y: Int
}

func day4_2() {
    let fileURL = URL(filePath: "inputs/day4.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n")

    var rolls = lines.map({ line in Array(line) })

    var totalAccessible = 0
    while true {
        var removeables = [Removeable]()
        for y in 0..<rolls.count {
            let row = rolls[y]
            for x in 0..<row.count {
                if let adjacent = countAdjacent(rolls: rolls, x: x, y: y) {
                    if adjacent < 4 {
                        removeables.append(Removeable(x: x, y: y))
                    }
                }
            }
        }

        for removeable in removeables {
            rolls[removeable.y][removeable.x] = "."
        }

        totalAccessible += removeables.count
        if removeables.count == 0 {
            break
        }
    }

    print("Total rolls accessible \(totalAccessible)")
}
