import { camelizeKeys } from 'humps'

import queryKeys from '@/helpers/queryKeys'

export const addPhraseToCache = ({ queryClient, phrase }) => {
  const translationId = phrase.translationId
  const translationPhrasesKey = queryKeys.translationPhrases(translationId)
  const phrases = queryClient.getQueryData(translationPhrasesKey)

  queryClient.setQueryData(translationPhrasesKey, [...phrases, phrase])
}

export const updatePhraseInCache = ({
  queryClient,
  phrase,
  translationId: givenTranslationId,
}) => {
  const translationId = givenTranslationId || phrase.translationId
  const translationPhrasesKey = queryKeys.translationPhrases(translationId)
  const phrases = queryClient.getQueryData(translationPhrasesKey)

  queryClient.setQueryData(
    translationPhrasesKey,
    phrases.map((loadedPhrase) => {
      if (loadedPhrase.id === phrase.id) {
        return {
          ...loadedPhrase,
          ...camelizeKeys(phrase),
        }
      } else {
        return loadedPhrase
      }
    }),
  )
}

export const invalidateTranslationsCache = ({ queryClient }) => {
  queryClient.invalidateQueries({ queryKey: queryKeys.translations() })
}
