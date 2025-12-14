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
        buttons.sort(by: { a, b in a.togglers.count > b.togglers.count })
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

enum SolveError: Error {
    case CouldNotSolve
}

private func solveRemaining(buttons: [Button], remainingJoltages: [Int]) throws -> Int {
    // for negator in 0..<remainingJoltages.max()! {
    for (index, button) in buttons.enumerated() {
        var maxConsume = 99999
        var newJoltages = remainingJoltages
        for toggle: Int in button.togglers {
            if newJoltages[toggle] < maxConsume {
                maxConsume = newJoltages[toggle]
            }
        }

        // maxConsume -= negator  //Handles partial solves

        if maxConsume > 0 && maxConsume < 99999 {
            for toggle: Int in button.togglers {
                newJoltages[toggle] -= maxConsume
            }
            var newButtons = buttons
            newButtons.remove(at: index)

            if newJoltages.max()! == 0 {
                print(newJoltages)
                return maxConsume
            }

            do {
                let count = try solveRemaining(
                    buttons: newButtons, remainingJoltages: newJoltages)
                return count + maxConsume
            } catch {
                //continue.
            }
        }
    }
    // }

    throw SolveError.CouldNotSolve
}

func day10_2() {
    let fileURL = URL(filePath: "inputs/day10.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let manuals = lines.map { line in Manual(line) }

    var totalPresses = 0
    for manual in manuals {
        do {
            let presses = try solveRemaining(
                buttons: manual.buttons, remainingJoltages: manual.joltages)

            print("required \(presses)")
            totalPresses += presses
        } catch {
            print("Could not solve \(manual.joltages)")
        }
    }

    print("Total machine presses \(totalPresses)")
}
