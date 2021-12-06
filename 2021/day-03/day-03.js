const fs = require('fs').promises
const path = require('path')

// Common
const readValues = async () => {
  const path_ = path.resolve(__dirname, 'input.txt')
  const input = await fs.readFile(path_, 'utf8')
  const values = input.trim().split('\n').map(v => v.split(''))
  return values
}

const findMean = (values, index) => {
  return values.reduce(([zeros, ones], value) => {
    if (value[index] === '0') return [zeros + 1, ones]
    return [zeros, ones + 1]
  }, [0, 0])
}

const computeGamma = values => {
  const num = new Array(12).fill(0)
  const res =
    num
      .map((_, index) => findMean(values, index))
      .map(([zeros, ones]) => zeros > ones ? '0' : '1')
  return res.join('')
}

const computeEpsilon = gamma => {
  return gamma.split('').map(value => value === '0' ? '1' : '0').join('')
}

// First assignment
const first = async () => {
  const values = await readValues()
  const gamma = computeGamma(values)
  const epsilon = computeEpsilon(gamma)
  console.log(parseInt(gamma, 2) * parseInt(epsilon, 2))
}

const compareMeans = comp => (values, index = 0) => {
  if (values.length === 1) return values[0].join('')
  const [zeros, ones] = findMean(values, index)
  const criteria = comp(zeros, ones)
  const newValues = values.filter(t => t[index] === criteria.toString())
  return compareMeans(comp)(newValues, index + 1)
}
const findOxygen = compareMeans((zeros, ones) => zeros <= ones ? 1 : 0)
const findCO2 = compareMeans((zeros, ones) => zeros > ones ? 1 : 0)

// second assignment
const second = async () => {
  const values = await readValues()
  const oxygen = parseInt(findOxygen(values), 2)
  const co2 = parseInt(findCO2(values), 2)
  console.log(oxygen * co2)
}

second()
