import { camelizeKeys } from 'humps'

import queryKeys from '@/helpers/queryKeys'

export const addTranslationPhraseToCache = ({
  queryClient,
  translationPhrase,
}) => {
  const translationId = translationPhrase.translationId
  const translationKey = queryKeys.translation(translationId)
  const translation = queryClient.getQueryData(translationKey)

  queryClient.setQueryData(translationKey, {
    ...translation,
    translationPhrases: [...translation.translationPhrases, translationPhrase],
  })
}

export const updateTranslationPhraseInCache = ({
  queryClient,
  translationPhrase,
  translationId: givenTranslationId,
}) => {
  const translationId = givenTranslationId || translationPhrase.translationId
  const translationKey = queryKeys.translation(translationId)
  const translation = queryClient.getQueryData(translationKey)

  queryClient.setQueryData(translationKey, {
    ...translation,
    translationPhrases: translation.translationPhrases.map(
      (loadedTranslationPhrase) => {
        if (loadedTranslationPhrase.id === translationPhrase.id) {
          return {
            ...loadedTranslationPhrase,
            ...camelizeKeys(translationPhrase),
          }
        } else {
          return loadedTranslationPhrase
        }
      },
    ),
  })
}

export const invalidateTranslationsCache = ({ queryClient }) => {
  queryClient.invalidateQueries({ queryKey: queryKeys.translations() })
}
