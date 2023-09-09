import { destroy, get, post } from '@/api/apiClient'

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

const deletePhrase = ({ phraseId }) => {
  return destroy(`/api/phrases/${phraseId}`)
}

const retryPhraseTranslation = ({ phraseId }) => {
  return post(`/api/phrases/${phraseId}/retry`)
}

const translationPhrases = ({ translationId }) => {
  return get(`/api/translations/${translationId}/phrases`)
}

export {
  createPhrase,
  deletePhrase,
  retryPhraseTranslation,
  translationPhrases,
}
