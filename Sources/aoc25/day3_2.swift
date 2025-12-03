import Foundation

struct HighValue {
    var value: Int = 0
    var consumed: Int = 0
}

private func getHighest(_ numbers: [Int], _ remainingOffsets: Int) -> HighValue {
    var largest = 0
    var index = 0
    for i in 0..<remainingOffsets {
        if numbers[i] > largest {
            largest = numbers[i]
            index = i
        }
    }

    return HighValue(value: largest, consumed: index)
}

private func calculateJoltage(_ numbers: [Int]) -> Int {
    var totalJoltage = 0
    var consumedOffsets = 0
    var remainingOffsets = numbers.count - 11

    for offset in 0..<12 {
        let values = numbers[(offset + consumedOffsets)...]
        let highest = getHighest([Int](values), remainingOffsets)

        consumedOffsets += highest.consumed
        remainingOffsets -= highest.consumed

        let power = 11 - offset
        let joltage = highest.value * Int(pow(Double(10), Double(power)))  //wtf swift...
        totalJoltage += joltage
    }

    return totalJoltage
}

func day3_2() {
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
