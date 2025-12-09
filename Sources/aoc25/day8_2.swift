import Foundation

private struct Connection: Hashable, CustomStringConvertible {
    var from: Position
    var to: Position
    var distance: Double

    var description: String {
        return "\(from) -> \(to) \(distance)"
    }

    func swapped() -> Connection {
        return Connection(from: to, to: from, distance: distance)
    }
}

private struct Position: Equatable, CustomStringConvertible, Hashable {
    var x: Int
    var y: Int
    var z: Int

    var description: String {
        return "\(x),\(y),\(z)"
    }

    init(_ text: String.SubSequence) {
        let values = text.split(separator: ",")
        x = Int(values[0])!
        y = Int(values[1])!
        z = Int(values[2])!
    }

    func distance(_ other: Position) -> Double {
        let dx = Double(self.x - other.x)
        let dy = Double(self.y - other.y)
        let dz = Double(self.z - other.z)
        return sqrt(dx * dx + dy * dy + dz * dz)
    }

    func closest(positions: [Position], blackList: Set<Connection>) -> Connection? {
        var shortest: Connection?

        for position in positions {
            if self == position { continue }
            let distance = self.distance(position)
            let newConn = Connection(from: self, to: position, distance: distance)

            if shortest == nil {
                if blackList.contains(newConn) {
                    continue
                }
                shortest = newConn
            } else if distance < shortest!.distance {
                if blackList.contains(newConn) {
                    continue
                }
                shortest = newConn
            }
        }

        return shortest
    }
}

private func closestConnection(positions: [Position], blackList: Set<Connection>) -> Connection {
    var shortestConn: Connection? = nil
    outer: for position in positions {
        guard let conn = position.closest(positions: positions, blackList: blackList) else {
            continue
        }

        if shortestConn == nil {
            shortestConn = conn
        } else if conn.distance < shortestConn!.distance {
            shortestConn = conn
        }
    }
    return shortestConn!
}

private func resolveConnections(
    remaining: inout [Connection], current: Connection, visited: inout Set<Position>
) {
    var found = [Connection]()
    var removables = [Int]()
    for i in 0..<remaining.count {
        let connection = remaining[i]
        if current.to == connection.to || current.to == connection.from {
            removables.append(i)
            found.append(connection)
        }
        if current.from == connection.to || current.from == connection.from {
            removables.append(i)
            found.append(connection)
        }
    }

    for removable in removables {
        remaining.remove(at: removable)
    }

    for connection in found {
        visited.insert(connection.to)
        visited.insert(connection.from)
        resolveConnections(remaining: &remaining, current: connection, visited: &visited)
    }
}

private func isContiguous(connections: [Connection], totalJunctions: Int) -> Bool {
    var dupeConnections = connections
    let connection = dupeConnections.popLast()
    var visited = Set<Position>()
    resolveConnections(remaining: &dupeConnections, current: connection!, visited: &visited)
    print(visited.count, totalJunctions)
    return visited.count == totalJunctions
}

func day8_2() {
    let fileURL = URL(filePath: "inputs/day8.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let positions = lines.map({ line in Position(line) })
    var connections = [Connection]()
    var blackList = Set<Connection>()

    var finalConnection: Connection?
    while true {
        let closestConn = closestConnection(positions: positions, blackList: blackList)
        blackList.insert(closestConn)
        blackList.insert(closestConn.swapped())
        connections.append(closestConn)

        if isContiguous(connections: connections, totalJunctions: positions.count) {
            finalConnection = closestConn
            break
        }
    }

    let total = finalConnection!.from.x * finalConnection!.to.x
    print("Final connection \(finalConnection!.from.x) * \(finalConnection!.to.x) = \(total)")
}
