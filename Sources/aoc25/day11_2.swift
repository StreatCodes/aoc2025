import Foundation

private func countPaths(
    paths: [String: [String]], current: String, cache: inout [String: Int],
    history: Set<String>, level: Int,
) -> Int {
    let destinations = paths[current]!
    var dupeHistory = history

    if current == "dac" || current == "fft" {
        dupeHistory.insert(current)
    }

    var newRoutes = 0
    for destination in destinations {
        if destination == "out" {
            if dupeHistory.contains("dac") && dupeHistory.contains("fft") {
                newRoutes += 1
            }
        } else {
            let cacheKey = (dupeHistory + [destination + String(level)]).joined()
            if let cached = cache[cacheKey] {
                newRoutes += cached
            } else {
                let count = countPaths(
                    paths: paths, current: destination, cache: &cache,
                    history: dupeHistory, level: level + 1)

                cache[cacheKey] = count
                newRoutes += count
                print(cacheKey)
            }
        }
    }
    return newRoutes
}

func day11_2() {
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

    var cache = [String: Int]()
    let history = Set<String>()
    let totalPaths = countPaths(
        paths: paths, current: "svr", cache: &cache, history: history, level: 0)

    print("Total paths \(totalPaths)")
}
