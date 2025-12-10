import Foundation

private struct Point: Hashable {
    var x: Int
    var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    init(_ text: String.SubSequence) {
        let parts = text.split(separator: ",")
        x = Int(parts[0])!
        y = Int(parts[1])!
    }

    func area(other: Point) -> Int {
        let xl = max(x, other.x) - min(x, other.x) + 1
        let yl = max(y, other.y) - min(y, other.y) + 1

        return xl * yl
    }

    func containsPoints(other: Point, points: [Point]) -> Bool {
        let minX = min(x, other.x)
        let minY = min(y, other.y)
        let maxX = max(x, other.x)
        let maxY = max(y, other.y)
        for point in points {
            if point.x > minX && point.x < maxX && point.y > minY && point.y < maxY {
                return true
            }
        }

        return false
    }

    func wholeLineInside(other: Point, points: [Point]) -> Bool {
        let minX = min(x, other.x)
        let maxX = max(x, other.x)
        let minY = min(y, other.y)
        let maxY = max(y, other.y)

        for x in minX...maxX {
            if !Point(x: x, y: minY).inPath(points: points) { return false }
            if !Point(x: x, y: maxY).inPath(points: points) { return false }
        }

        for y in minY...maxY {
            if !Point(x: minX, y: y).inPath(points: points) { return false }
            if !Point(x: maxX, y: y).inPath(points: points) { return false }
        }

        return true
    }

    func inPath(points: [Point]) -> Bool {
        for i in 0..<points.count {
            let current = points[i]
            let next = i + 1 == points.count ? points[0] : points[i + 1]

            if isOnSegment(p: self, a: current, b: next) {
                return true
            }
        }
        var inside = false
        for i in 0..<points.count {
            let current = points[i]
            let next = i + 1 == points.count ? points[0] : points[i + 1]

            if ((current.y > y) != (next.y > y))
                && (x < (next.x - current.x) * (y - current.y) / (next.y - current.y) + current.x)
            {
                inside.toggle()
            }
        }

        return inside
    }

    func isOnSegment(p: Point, a: Point, b: Point) -> Bool {
        let minX = min(a.x, b.x)
        let maxX = max(a.x, b.x)
        let minY = min(a.y, b.y)
        let maxY = max(a.y, b.y)

        if p.x < minX || p.x > maxX || p.y < minY || p.y > maxY {
            return false
        }

        return (b.x - a.x) * (p.y - a.y) == (b.y - a.y) * (p.x - a.x)
    }
}

func day9_2() {
    let fileURL = URL(filePath: "inputs/day9.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let points = lines.map { line in Point(line) }

    var largestArea = 0
    for i in 0..<points.count {
        print("\(i)/\(points.count) - \(largestArea)")
        let pointA = points[i]
        for j in i..<points.count {
            let pointB = points[j]
            let area = pointA.area(other: pointB)
            if area < largestArea { continue }

            if pointA.containsPoints(other: pointB, points: points) { continue }
            if pointA.wholeLineInside(other: pointB, points: points) {
                largestArea = area
            }
        }
    }

    print("Largest area \(largestArea)")
}
