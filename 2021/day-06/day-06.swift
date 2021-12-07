import Foundation

func toInt(_ value: String) -> Int { return Int(value)! }

func readValues() throws -> [Int] {
  let dir = FileManager.default.currentDirectoryPath
  let path = [dir, "day-06", "input.txt"].joined(separator: "/")
  let values = try String.init(contentsOfFile: path, encoding: .utf8)
  let trimmed = values.trimmingCharacters(in: .whitespacesAndNewlines)
  return trimmed.components(separatedBy: ",").map(toInt)
}

func first() {
  let values = try! readValues()
  var fishes = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  for i in values { fishes[i] = fishes[i] + 1 }
  for _ in 0 ..< 80 {
    let zeros = fishes[0]
    (0..<fishes.count).forEach { if $0 != 8 { fishes[$0] = fishes[$0 + 1] } }
    fishes[8] = zeros
    fishes[6] = fishes[6] + zeros
  }
  print(fishes.reduce(0, +))
}

func second() {
  let values = try! readValues()
  var fishes = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  for i in values { fishes[i] = fishes[i] + 1 }
  for _ in 0 ..< 256 {
    let zeros = fishes[0]
    (0..<fishes.count).forEach { if $0 != 8 { fishes[$0] = fishes[$0 + 1] } }
    fishes[8] = zeros
    fishes[6] = fishes[6] + zeros
  }
  print(fishes.reduce(0, +))
}

second()
