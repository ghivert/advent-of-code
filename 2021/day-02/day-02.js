const fs = require('fs').promises
const path = require('path')

// Common
const readValues = async () => {
  const path_ = path.resolve(__dirname, 'input.txt')
  const input = await fs.readFile(path_, 'utf8')
  const values = input.trim().split('\n').map(v => {
    const [instruction, value] = v.split(' ')
    return [instruction, parseInt(value, 10)]
  })
  return values
}

// First assignment
const first = async () => {
  const values = await readValues()
  const res = values.reduce(([horizontal, depth], [instruction, value]) => {
    switch (instruction) {
      case 'forward' : return [horizontal + value, depth]
      case 'down': return [horizontal, depth + value]
      case 'up': return [horizontal, depth - value]
      default:
        console.log('Nope', instruction)
        return [horizontal, depth]
    }
  }, [0, 0])
  const [horizontal, depth] = res
  console.log(horizontal * depth)
}

// second assignment
const second = async () => {
  const values = await readValues()
  const res = values.reduce(([horizontal, depth, aim], [instruction, value]) => {
    switch (instruction) {
      case 'forward' : return [horizontal + value, depth + (aim * value), aim]
      case 'down': return [horizontal, depth, aim + value]
      case 'up': return [horizontal, depth, aim - value]
      default:
        console.log('Nope', instruction)
        return [horizontal, depth]
    }
  }, [0, 0, 0])
  const [horizontal, depth] = res
  console.log(horizontal * depth)
}

second()
