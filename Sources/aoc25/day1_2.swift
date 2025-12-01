import Foundation

func day1_2() {
    let fileURL = URL(filePath: "inputs/day1.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n")

    var position = 50
    var passedZero = 0
    for line in lines {
        let chars = Array(line)
        let direction = chars[0]
        let count = Int(String(chars[1...]))!

        if direction == "L" {
            for _ in 0..<count {
                position -= 1
                if position == 0 {
                    passedZero += 1
                }
                if position < 0 {
                    position += 100
                }
            }
        } else {
            for _ in 0..<count {
                position += 1
                if position > 99 {
                    position -= 100
                }
                if position == 0 {
                    passedZero += 1
                }
            }
        }
    }

    print("Clicked \(passedZero) times")
}
