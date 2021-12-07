import Foundation

typealias Coordinates = (Int, Int)
typealias Plan = [String: Int]

func toInt(_ value: String) -> Int { return Int(value)! }

func toCoordinates(coordinates: String) -> Coordinates {
  let asArray = coordinates.components(separatedBy: ",").map(toInt)
  let x = asArray[0]
  let y = asArray[1]
  return (x, y)
}

func toCoordinatesPair(line: String) -> (Coordinates, Coordinates) {
  let asArray = line.components(separatedBy: " -> ").map(toCoordinates)
  let origin = asArray[0]
  let end = asArray[1]
  return (origin, end)
}

func readValues() throws -> [(Coordinates, Coordinates)] {
  let dir = FileManager.default.currentDirectoryPath
  let path = [dir, "day-05", "input.txt"].joined(separator: "/")
  let values = try String.init(contentsOfFile: path, encoding: .utf8)
  let trimmed = values.trimmingCharacters(in: .whitespacesAndNewlines)
  let components = trimmed.components(separatedBy: "\n")
  return components.map(toCoordinatesPair)
}

func countCoordinates(_ plan: inout Plan, _ coordinates: (Coordinates, Coordinates)) {
  let ((x1, y1), (x2, y2)) = coordinates
  for x in min(x1, x2)...max(x1, x2) {
    for y in min(y1, y2)...max(y1, y2) {
      let key = "\(x)-\(y)"
      let count = plan[key] ?? 0
      plan[key] = count + 1
    }
  }
}

func first() {
  let allCoordinates = try! readValues()
  var plan = Plan()
  allCoordinates.forEach { coordinates in
    let ((x1, y1), (x2, y2)) = coordinates
    if (x1 == x2 || y1 == y2) { countCoordinates(&plan, coordinates) }
  }
  let count = plan.values.reduce(0, { acc, i in i > 1 ? acc + 1 : acc })
  print(count)
}

func countDiagonals(_ plan: inout Plan, _ coordinates: (Coordinates, Coordinates)) {
  let ((x1, y1), (x2, y2)) = coordinates
  let key = "\(x1)-\(y1)"
  let count = plan[key] ?? 0
  plan[key] = count + 1
  if (x1 != x2 && y1 != y2) {
    let newX = x1 < x2 ? x1 + 1 : x1 - 1
    let newY = y1 < y2 ? y1 + 1 : y1 - 1
    countDiagonals(&plan, ((newX, newY), (x2, y2)))
  }
}

func second() {
  let allCoordinates = try! readValues()
  var plan = Plan()
  allCoordinates.forEach { coordinates in
    let ((x1, y1), (x2, y2)) = coordinates
    if (x1 == x2 || y1 == y2) { countCoordinates(&plan, coordinates) }
    else { countDiagonals(&plan, coordinates) }
  }
  let count = plan.values.reduce(0, { acc, i in i > 1 ? acc + 1 : acc })
  print(count)
}

second()
