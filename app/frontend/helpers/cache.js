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
