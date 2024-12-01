import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result.{unwrap}
import gleam/string
import util/read_input.{read_input}

fn line_to_tuple(line: String) {
  let nums = string.split(line, " ")
  let first = list.first(nums) |> unwrap("") |> int.parse() |> unwrap(0)
  let last = list.last(nums) |> unwrap("") |> int.parse() |> unwrap(0)
  #(first, last)
}

pub fn run() {
  let lists =
    read_input("./src/day1/day1.txt")
    |> string.split("\n")
    |> list.map(line_to_tuple)
    |> list.unzip()
    |> pair.map_first(fn(l) { list.sort(l, int.compare) })
    |> pair.map_second(fn(l) { list.sort(l, int.compare) })

  let result =
    list.zip(lists.0, lists.1)
    |> list.fold(0, fn(base, curr) {
      int.subtract(curr.0, curr.1) |> int.absolute_value |> int.add(base)
    })

  io.debug("part 1: " <> int.to_string(result))

  // part 2
  let part2_result =
    lists.0
    |> list.map(fn(x) { x * list.count(lists.1, fn(y) { y == x }) })
    |> int.sum

  io.debug("part 2: " <> int.to_string(part2_result))
}
