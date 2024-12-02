import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result.{unwrap}
import gleam/string
import util/read_input.{create_list_from_input, read_input}

fn parse_levels(levels: String) {
  levels
  |> string.split(" ")
  |> list.map(int.parse)
  |> list.map(fn(x) { unwrap(x, 0) })
}

fn parse_reports(reports: List(String)) -> List(List(Int)) {
  reports |> list.map(parse_levels)
}

fn check_levels(levels: #(Int, Int)) {
  let diff = levels.0 - levels.1
  case diff {
    -3 | -2 | -1 -> -1
    3 | 2 | 1 -> 1
    _ -> 0
  }
}

// part 2
fn check_report_with_dampener(report: List(Int)) {
  let combinations = list.combinations(report, list.length(report) - 1)
  list.any(combinations, determine_if_report_is_safe)
}

fn determine_if_report_is_safe(report: List(Int)) {
  let diffs = report |> list.window_by_2() |> list.map(check_levels)
  let total = diffs |> int.sum()
  let length = list.length(report) - 1
  let negated_length = int.negate(length)
  total == length || total == negated_length
}

fn check_report_safety(report: List(Int)) {
  let original_result = determine_if_report_is_safe(report)
  case original_result {
    True -> True
    False -> check_report_with_dampener(report)
  }
}

pub fn run() {
  let safe_reports_count =
    read_input("./src/day2/data.txt")
    |> create_list_from_input()
    |> parse_reports()
    |> list.map(check_report_safety)
    |> list.count(fn(report_safety) { report_safety == True })

  io.println("Part 1: " <> int.to_string(safe_reports_count))
}
