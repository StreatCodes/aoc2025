import Foundation

private struct Range {
    var start: Int
    var end: Int

    init(_ text: String.SubSequence) {
        let parts = text.split(separator: "-")
        start = Int(parts[0])!
        end = Int(parts[1])!
    }

    func isFresh(ingredientId: Int) -> Bool {
        return ingredientId >= start && ingredientId <= end
    }
}

func day5_1() {
    let fileURL = URL(filePath: "inputs/day5.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    var ranges = [Range]()
    var ingredientIds = [Int]()

    var ingredientRanges = true
    for line in lines {
        if line == "" {
            ingredientRanges = false
            continue
        }

        if ingredientRanges {
            ranges.append(Range(line))
        } else {
            ingredientIds.append(Int(line)!)
        }
    }

    var freshIngredients = 0
    for ingredientId in ingredientIds {
        var isFresh = false
        for range in ranges {
            if range.isFresh(ingredientId: ingredientId) {
                isFresh = true
            }
        }

        if isFresh {
            freshIngredients += 1
        }
    }

    print("Fresh ingredients \(freshIngredients)")
}
