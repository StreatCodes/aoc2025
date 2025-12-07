import Foundation

func day7_1() {
    let fileURL = URL(filePath: "inputs/day7.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let _lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let lines = _lines.map({ l in Array(l) })

    var splitCount = 0
    var beams = Set<Int>()
    for line in lines {
        if beams.count == 0 {
            let beam = line.firstIndex(of: "S")!
            beams.insert(beam)
            continue
        }

        for i in 0..<line.count {
            if line[i] == "^" && beams.contains(i) {
                splitCount += 1
                beams.remove(i)
                if i > 0 && line[i - 1] == "." {
                    beams.insert(i - 1)
                }
                if i < line.count - 1 && line[i + 1] == "." {
                    beams.insert(i + 1)
                }
            }
        }
    }

    print("Split count \(splitCount)")
}
