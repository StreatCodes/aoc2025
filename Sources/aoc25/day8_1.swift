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
    connections: [Connection], consumed: inout [Connection], current: Connection
) {
    consumed.append(current)
    for connection in connections {
        if consumed.contains(connection) { continue }
        if current.to == connection.to || current.to == connection.from {
            resolveConnections(connections: connections, consumed: &consumed, current: connection)
        }
        if current.from == connection.to || current.from == connection.from {
            resolveConnections(connections: connections, consumed: &consumed, current: connection)
        }
    }

}

func day8_1() {
    let fileURL = URL(filePath: "inputs/day8.txt")
    let input = try! String(contentsOf: fileURL, encoding: .utf8)
    let lines = input.split(separator: "\n", omittingEmptySubsequences: false)

    let positions = lines.map({ line in Position(line) })
    var connections = [Connection]()
    var blackList = Set<Connection>()

    while connections.count < 1000 {
        let closestConn = closestConnection(positions: positions, blackList: blackList)
        blackList.insert(closestConn)
        blackList.insert(closestConn.swapped())
        connections.append(closestConn)
        print(closestConn)
    }

    var connectionLengths = [Int]()
    while connections.count > 0 {
        var foundConnections = [Connection]()
        resolveConnections(
            connections: connections, consumed: &foundConnections, current: connections.first!)

        var junctions = Set<Position>()
        for found in foundConnections {
            junctions.insert(found.from)
            junctions.insert(found.to)
        }
        let connectionCount = junctions.count
        connectionLengths.append(connectionCount)

        connections = connections.filter({ conn in !foundConnections.contains(conn) })
    }

    connectionLengths.sort { a, b in a > b }

    var total = 1
    for connectionLength in connectionLengths[..<3] {
        total *= connectionLength
    }

    print("Junction multiplier \(total)")
}
