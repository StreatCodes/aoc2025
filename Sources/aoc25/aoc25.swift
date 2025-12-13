let runInstructions = """
    aoc25 - Advent of code 2025 solver

    USAGE: aoc25 <puzzle>

    ARGUMENTS:
      <puzzle>    The puzzle to run formatted as day_part e.g. day1_1
    """

@main
struct aoc25 {
    static func main() {
        if CommandLine.arguments.count < 2 {
            return print(runInstructions)
        }

        switch CommandLine.arguments[1] {
        case "day1_1": day1_1()
        case "day1_2": day1_2()
        case "day2_1": day2_1()
        case "day2_2": day2_2()
        case "day3_1": day3_1()
        case "day3_2": day3_2()
        case "day4_1": day4_1()
        case "day4_2": day4_2()
        case "day5_1": day5_1()
        case "day5_2": day5_2()
        case "day6_1": day6_1()
        case "day6_2": day6_2()
        case "day7_1": day7_1()
        case "day7_2": day7_2()
        case "day8_1": day8_1()
        case "day8_2": day8_2()
        case "day9_1": day9_1()
        case "day9_2": day9_2()
        case "day10_1": day10_1()
        case "day10_2": day10_2()
        case "day11_1": day11_1()
        case "day11_2": day11_2()
        case "day12_1": day12_1()
        default: print(runInstructions)
        }
    }
}
