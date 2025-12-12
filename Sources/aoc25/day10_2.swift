import Foundation

private struct Button {
    var togglers = [Int]()

    init(_ text: String.SubSequence) {
        let parts = text.trimmingCharacters(in: ["(", ")"]).split(separator: ",")
        for part in parts {
            togglers.append(Int(part)!)
        }
    }
}

private struct Manual {
    var requiredState = [Bool]()
    var buttons = [Button]()
    var joltages = [Int]()

    init(_ text: String.SubSequence) {
        let parts = text.split(separator: " ")
        for part in parts {
            if part.starts(with: "[") {
                requiredState = parseRequiredState(part)
            }
            if part.starts(with: "(") {
                buttons.append(Button(part))
            }
            if part.starts(with: "{") {
                joltages = parseJoltages(part)
            }
        }
    }

    func parseRequiredState(_ text: String.SubSequence) -> [Bool] {
        var requiredState = [Bool]()
        for c in Array(text) {
            if c == "." {
                requiredState.append(false)
            } else if c == "#" {
                requiredState.append(true)
            }
        }
        return requiredState
    }

    func parseJoltages(_ text: String.SubSequence) -> [Int] {
        var joltages = [Int]()
        let parts = text.trimmingCharacters(in: ["{", "}"]).split(separator: ",")
        for part in parts {
            joltages.append(Int(part)!)
        }
        return joltages
    }
}

// private func solveJoltages()

func day10_2() {
    let fileURL = URL(filePath: "inputs/day10.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let manuals = lines.map { line in Manual(line) }
    _ = manuals

    // var totalPresses = 0
    // for manual in manuals {
    //     let baseState = [Int](repeating: 0, count: manual.requiredState.count)
    //     var tree = Tree()

    //     var presses = 0
    //     while true {
    //         let isSolved = tree.solveNext(
    //             requiredState: manual.joltages, buttons: manual.buttons)
    //         presses += 1
    //         print("Pressed \(presses) times. variations \(tree.levels.last!.states.count)")

    //         if isSolved {
    //             break
    //         }
    //     }

    //     print("required \(presses)")
    //     totalPresses += presses
    // }

    // print("Total machine presses \(totalPresses)")
    print("Incomplete")
}
