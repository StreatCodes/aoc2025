import Foundation

struct Challenge {
    var gridWidth: Int
    var gridHeight: Int
    var presents = [Present]()

    init(_ line: String.SubSequence, presents: [Present]) {
        let parts = line.split(separator: " ")
        let sizes = parts[0].trimmingCharacters(in: [":"]).split(separator: "x")
        gridWidth = Int(sizes[0])!
        gridHeight = Int(sizes[1])!

        var i = 0
        for value in parts[1...] {
            let count = Int(value)!

            for _ in 0..<count {
                self.presents.append(presents[i])
            }
            i += 1
        }
    }

    func presentsFit() -> Bool {
        return presents.count * 9 <= gridWidth * gridHeight
    }
}

struct Present {
    var grid = [[Bool]]()

    init(_ lines: [String]) {
        for line in lines {
            var row = [Bool]()
            let chars = Array(line)
            for c in chars {
                row.append(c == "#")
            }
            grid.append(row)
        }
    }

    func printGrid() {
        for row in grid {
            print(row)
        }
    }
}

func day12_1() {
    let fileURL = URL(filePath: "inputs/day12.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    var presents = [Present]()
    var challenges = [Challenge]()

    var current = [String]()
    for line in lines {
        if line.contains(":\n") { continue }
        if line.count == 0 {
            presents.append(Present(current))
            current.removeAll()
        }
        if line.contains("#") {
            current.append(String(line))
        }
        if line.contains("x") {
            let challenge = Challenge(line, presents: presents)
            challenges.append(challenge)
        }
    }

    var fits = 0
    for challenge in challenges {
        if challenge.presentsFit() {
            fits += 1
        }
    }

    print("Fits \(fits)")
}
