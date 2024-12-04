import gleam/int
import gleam/list
import gleam/result.{unwrap}
import gleam/string.{split}
import simplifile.{read}

pub fn read_input(file_path: String) {
  let result = read(file_path)
  unwrap(result, "")
}

pub fn create_list_from_input(input: String) {
  split(input, "\n") |> list.filter(fn(line) { line != "" })
}

pub fn parse_number(input: String) -> Int {
  let assert Ok(n) = int.parse(input)
  n
}
