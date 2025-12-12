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

private struct Level {
    var states = [[Bool]]()

    init(states: [[Bool]]) {
        self.states = states
    }

    init(fromStates: [[Bool]], buttons: [Button]) {
        for fromState in fromStates {
            for button in buttons {
                var newState = fromState
                for bIndex in button.togglers {
                    newState[bIndex].toggle()
                }
                states.append(newState)
            }
        }
    }

    func isSolved(requiredState: [Bool]) -> Bool {
        for state in states {
            if state == requiredState {
                return true
            }
        }
        return false
    }
}

private struct Tree {
    var levels = [Level]()

    init(baseLevel: Level) {
        levels.append(baseLevel)
    }

    mutating func solveNext(requiredState: [Bool], buttons: [Button]) -> Bool {
        let currentLevel = levels.last!
        let newLevel = Level(fromStates: currentLevel.states, buttons: buttons)
        self.levels.append(newLevel)
        return newLevel.isSolved(requiredState: requiredState)
    }
}

func day10_1() {
    let fileURL = URL(filePath: "inputs/day10.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let manuals = lines.map { line in Manual(line) }

    var totalPresses = 0
    for manual in manuals {
        let baseState = [Bool](repeating: false, count: manual.requiredState.count)
        let baseLevel = Level(states: [baseState])
        var tree = Tree(baseLevel: baseLevel)

        var presses = 0
        while true {
            let isSolved = tree.solveNext(
                requiredState: manual.requiredState, buttons: manual.buttons)
            presses += 1
            print("Pressed \(presses) times")

            if isSolved {
                break
            }
        }

        print("required \(presses)")
        totalPresses += presses
    }

    print("Total machine presses \(totalPresses)")
}
