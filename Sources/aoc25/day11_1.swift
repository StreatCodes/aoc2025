import Foundation

private func countPaths(paths: [String: [String]], current: String) -> Int {
    var newRoutes = 0
    let destinations = paths[current]!

    for destination in destinations {
        if destination == "out" {
            newRoutes += 1
        } else {
            newRoutes += countPaths(paths: paths, current: destination)
        }
    }
    return newRoutes
}

func day11_1() {
    let fileURL = URL(filePath: "inputs/day11.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    var paths = [String: [String]]()

    for line in lines {
        let parts = line.split(separator: " ")
        let from = parts.first!.trimmingCharacters(in: [":"])
        let destinations = parts[1...].map { d in String(d) }

        paths[from] = destinations
    }

    let totalPaths = countPaths(paths: paths, current: "you")

    print("Total paths \(totalPaths)")
}
