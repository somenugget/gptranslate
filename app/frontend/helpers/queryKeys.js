const coerceNumber = (num) => (typeof num === 'number' ? num.toString() : num)

export default {
  translations: () => ['translations'],
  translation: (id) => ['translations', coerceNumber(id)],
}
