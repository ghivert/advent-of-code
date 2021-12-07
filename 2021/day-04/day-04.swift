import Foundation

typealias Board = [[Int]]

func toInt(_ value: String) -> Int { return Int(value)! }

func readValues() throws -> ([Int], [Board]) {
  let dir = FileManager.default.currentDirectoryPath
  let path = [dir, "day-04", "input.txt"].joined(separator: "/")
  let values = try String.init(contentsOfFile: path, encoding: .utf8)
  let trimmed = values.trimmingCharacters(in: .whitespacesAndNewlines)
  let components = trimmed.components(separatedBy: "\n\n")
  let first = components[0].components(separatedBy: ",").map(toInt)
  let rest = Array(components[1 ..< components.count]).map {
    $0.components(separatedBy: "\n").map {
      $0.components(separatedBy: " ").filter { !$0.isEmpty }.map(toInt)
    }
  }
  return (first, rest)
}

func isWinner(board: Board, elements: [Int]) -> Bool {
  let range = 0...4
  return range.reduce(false, { acc, i in
    let (row, column) = range.reduce((true, true), { truths, j in
      let row = elements.contains(board[i][j])
      let col = elements.contains(board[j][i])
      return (truths.0 && row, truths.1 && col)
    })
    return acc || row || column
  })
}

func first() {
  let (inputs, bingos) = try! readValues()
  let (elements, board) = inputs.reduce(([], nil), { (acc: ([Int], Board?), input) in
    if acc.1 != nil { return acc }
    let elements = acc.0 + [input]
    let board = bingos.reduce(nil, { (actualBoard: Board?, board) in
      if actualBoard != nil { return actualBoard }
      if isWinner(board: board, elements: elements) { return board }
      return nil
    })
    return (elements, board)
  })
  let sum = board!.joined().filter { !elements.contains($0) }.reduce(0, +)
  print(sum * elements.last!)
}

func second() {
  let (inputs, bingos) = try! readValues()
  let (elements, board) = inputs.reduce(([], nil), { (acc: ([Int], Board?), input) in
    if acc.1 != nil {
      if isWinner(board: acc.1!, elements: acc.0) { return acc }
      return (acc.0 + [input], acc.1)
    }
    let elements = acc.0 + [input]
    let board = bingos.filter { !isWinner(board: $0, elements: elements) }
    if board.count == 1 { return (elements, board[0]) }
    return (elements, nil)
  })
  let sum = board!.joined().filter { !elements.contains($0) }.reduce(0, +)
  print(sum * elements.last!)
}

second()
