import gleam/result.{unwrap}
import simplifile.{read}

pub fn read_input(file_path: String) {
  let result = read(file_path)
  unwrap(result, "")
}
