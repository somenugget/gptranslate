import { post } from '@/api/apiClient'

const createPhrase = ({ translationId = null, langFrom, langTo, textFrom }) => {
  return post('/api/phrases', {
    body: {
      phrase: {
        translationId,
        langFrom,
        langTo,
        textFrom,
      },
    },
  })
}

export { createPhrase }
