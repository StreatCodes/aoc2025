import Foundation

func day1_1() {
    let fileURL = URL(filePath: "inputs/day1.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n")

    var position = 50
    var landedOnZero = 0
    for line in lines {
        let chars = Array(line)
        let direction = chars[0]
        let count = Int(String(chars[1...]))!

        if direction == "L" {
            position -= count
            while position < 0 {
                position += 100
            }
        } else {
            position += count
            while position > 99 {
                position -= 100
            }
        }
        if position == 0 {
            landedOnZero += 1
        }
    }

    print("Landed on zero \(landedOnZero) times")
}
