import { camelizeKeys } from 'humps'

import queryKeys from '@/helpers/queryKeys'

export const addPhraseToCache = ({ queryClient, phrase }) => {
  const translationId = phrase.translationId
  const translationKey = queryKeys.translation(translationId)
  const translation = queryClient.getQueryData(translationKey)

  queryClient.setQueryData(translationKey, {
    ...translation,
    phrases: [...translation.phrases, phrase],
  })
}

export const updatePhraseInCache = ({
  queryClient,
  phrase,
  translationId: givenTranslationId,
}) => {
  const translationId = givenTranslationId || phrase.translationId
  const translationKey = queryKeys.translation(translationId)
  const translation = queryClient.getQueryData(translationKey)

  queryClient.setQueryData(translationKey, {
    ...translation,
    phrases: translation.phrases.map((loadedPhrase) => {
      if (loadedPhrase.id === phrase.id) {
        return {
          ...loadedPhrase,
          ...camelizeKeys(phrase),
        }
      } else {
        return loadedPhrase
      }
    }),
  })
}

export const invalidateTranslationsCache = ({ queryClient }) => {
  queryClient.invalidateQueries({ queryKey: queryKeys.translations() })
}
