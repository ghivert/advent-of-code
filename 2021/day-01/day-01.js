const fs = require('fs').promises
const path = require('path')

// Common
const readValues = async () => {
  const path_ = path.resolve(__dirname, 'input.txt')
  const input = await fs.readFile(path_, 'utf8')
  const values = input.trim().split('\n').map(v => parseInt(v, 10))
  return values
}

const count = values => {
  const [_, res] = values.reduce(([previous, count], value) => {
    if (!previous) return [value, count]
    return [value, value > previous ? count + 1 : count]
  }, [null, 0])
  return res
}

// First assignment
const first = async () => {
  const values = await readValues()
  const res = count(values)
  console.log(res)
}

// Second assignment
const threeSlidingWindow = (values, inputs = []) => {
  if (values.length < 3) return inputs
  const [ein, zwei, drei] = values
  const sum = ein + zwei + drei
  return threeSlidingWindow(values.slice(1), [...inputs, sum])
}

const second = async () => {
  const values = await readValues()
  const realValues = threeSlidingWindow(values)
  const res = count(realValues)
  console.log(res)
}

second()
