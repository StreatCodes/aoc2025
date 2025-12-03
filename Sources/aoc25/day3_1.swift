import Foundation

private func calculateJoltage(_ numbers: [Int]) -> Int {
    var highestIndex = 0
    var highestValue = 0
    for i in 0..<numbers.count - 1 {
        if numbers[i] > highestValue {
            highestValue = numbers[i]
            highestIndex = i
        }
    }

    var secondHighest = 0
    for i in highestIndex + 1..<numbers.count {
        if numbers[i] > secondHighest {
            secondHighest = numbers[i]
        }
    }

    return (highestValue * 10) + secondHighest
}

func day3_1() {
    let fileURL = URL(filePath: "inputs/day3.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n")

    var totalJoltage = 0
    for line in lines {
        let characters = Array(line)
        let numbers = characters.map({ c in Int(String(c))! })
        let joltage = calculateJoltage(numbers)
        totalJoltage += joltage
    }

    print("Total joltage \(totalJoltage)")
}
