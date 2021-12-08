import Foundation

func toInt(_ value: String) -> Int { return Int(value)! }

func readValues() throws -> [Int] {
  let dir = FileManager.default.currentDirectoryPath
  let path = [dir, "day-07", "input.txt"].joined(separator: "/")
  let values = try String.init(contentsOfFile: path, encoding: .utf8)
  let trimmed = values.trimmingCharacters(in: .whitespacesAndNewlines)
  return trimmed.components(separatedBy: ",").map(toInt)
}

func computeFuel(_ positions: [Int], _ position: Int) -> Int {
  return positions.reduce(0, { $0 + (abs(position - $1)) })
}

func computeRate(_ positions: [Int], _ position: Int) -> Int {
  return positions.reduce(0, { total, val in
    let count = abs(position - val)
    let value = (count * (count + 1)) / 2
    return total + value
  })
}

func computation(_ positions: [Int], _ calc: (_: [Int], _: Int) -> Int) -> Int {
  let top = positions.max()!
  let total = positions.reduce(0, +) * Int(1e10)
  return (0 ... top).reduce(total, { minFuel, position in
    let total = calc(positions, position)
    return minFuel > total ? total : minFuel
  })
}

func first() {
  let values = try! readValues()
  let value = computation(values, computeFuel)
  print(value)
}

func second() {
  let values = try! readValues()
  let value = computation(values, computeRate)
  print(value)
}

second()
