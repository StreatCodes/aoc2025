let runInstructions = """
    aoc25 - Advent of code 2025 solver

    USAGE: aoc25 <puzzle>

    ARGUMENTS:
      <puzzle>    The puzzle to run formatted as day_part e.g. day1_1
    """

enum Puzzle: String {
    case day1_1, day1_2
}

@main
struct aoc25 {
    static func main() {
        if CommandLine.arguments.count < 2 {
            return print(runInstructions)
        }

        let puzzle = Puzzle(rawValue: CommandLine.arguments[1])
        switch puzzle {
        case .day1_1: day1_1()
        case .day1_2: day1_2()
        default: print(runInstructions)
        }
    }
}
