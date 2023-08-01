import { post } from '@/api/apiClient'

const createTranslationPhrase = ({
  translationId = null,
  langFrom,
  langTo,
  textFrom,
}) => {
  return post('/api/translation_phrases', {
    body: {
      translationPhrase: {
        translationId,
        langFrom,
        langTo,
        textFrom,
      },
    },
  })
}

export { createTranslationPhrase }
