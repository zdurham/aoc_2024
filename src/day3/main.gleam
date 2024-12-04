import gleam/io
import gleam/list
import gleam/pair
import gleam/regexp
import gleam/result.{unwrap}
import gleam/string
import util/read_input.{parse_number, read_input}

// ok what if I just delete any muls from the string between don't an
pub fn run() {
  let assert Ok(re) = regexp.from_string("mul\\(\\d{1,3},\\d{1,3}\\)")
  let assert Ok(num_re) = regexp.from_string("\\d{1,3}")
  let assert Ok(do_re) = regexp.from_string("do\\(\\)")
  let assert Ok(dont_re) = regexp.from_string("don't\\(\\)")
  let input = read_input("./src/day3/data.txt")
  // let input_without_donts = regexp.split(dont_re, input)
  let input_without_donts =
    regexp.split(do_re, input)
    |> list.map(fn(do_split) {
      regexp.split(dont_re, do_split) |> list.first() |> result.unwrap("")
    })
    |> string.join("")

  regexp.scan(re, input_without_donts)
  |> list.map(fn(match) {
    let numbers = regexp.scan(num_re, match.content)
    pair.new(
      unwrap(list.first(numbers), regexp.Match("", [])).content
        |> parse_number(),
      unwrap(list.last(numbers), regexp.Match("", [])).content |> parse_number(),
    )
  })
  |> list.fold(0, fn(total, pair: #(Int, Int)) {
    let sum = total + pair.0 * pair.1
    sum
  })
  |> io.debug()
}
