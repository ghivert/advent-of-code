import Foundation

func toInt(_ value: String) -> Int { return Int(value)! }
func separateBySpace(_ value: String) -> [String] {
  return value.components(separatedBy: " ")
}

func readValues() throws -> [([String], [String])] {
  let dir = FileManager.default.currentDirectoryPath
  let path = [dir, "day-08", "input.txt"].joined(separator: "/")
  let values = try String.init(contentsOfFile: path, encoding: .utf8)
  let trimmed = values.trimmingCharacters(in: .whitespacesAndNewlines)
  return trimmed.components(separatedBy: "\n").map { value in
    let values = value.components(separatedBy: " | ").map(separateBySpace)
    return (values[0], values[1])
  }
}

func first() {
  let values = try! readValues()
  let count = values.reduce(0, { acc, val in
    let (_, output) = val
    return acc + output.reduce(0, { acc2, val2 in
      let adder = [2, 3, 7, 4].contains(val2.count) ? 1 : 0
      return acc2 + adder
    })
  })
  print(count)
}

let numbers = [
  "acedgfb": "8",
  "cdfbe": "5",
  "gcdfa": "2",
  "fbcad": "3",
  "dab": "7",
  "cefabd": "9",
  "cdfgeb": "6",
  "eafb": "4",
  "cagedb": "0",
  "ab": "1",
]

func second() {
  let values = try! readValues()
  let count = values.reduce(0, { acc, val in
    let (_, output) = val
    let number = output.map { numbers[$0] ?? $0 }.joined(separator: "")
    print(number)
    let asInt = toInt(number)
    return acc + asInt
  })
  print(count)
}

second()
