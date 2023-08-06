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

const retryPhraseTranslation = ({ phraseId }) => {
  return post(`/api/phrases/${phraseId}/retry`)
}

export { createPhrase, retryPhraseTranslation }
