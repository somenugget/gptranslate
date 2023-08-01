<template>
  <div class="flex flex-col w-full">
    <TranslationsList :translation="translation" />
    <TranslationsForm :translation="translation" />
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { useRoute } from 'vue-router'
import * as ActionCable from '@rails/actioncable'
import { useQuery, useQueryClient } from '@tanstack/vue-query'

import TranslationsForm from '@/components/translations/TranslationsForm.vue'
import TranslationsList from '@/components/translations/TranslationsList.vue'
import { updateTranslationPhraseInCache } from '@/helpers/cache'
import queryKeys from '@/helpers/queryKeys'
import { getTranslation } from '@/api/translations'

export default defineComponent({
  name: 'Translation',
  components: {
    TranslationsList,
    TranslationsForm,
  },
  setup() {
    const queryClient = useQueryClient()
    const { params } = useRoute()
    const translationId = params.id
    const { isFetching, data } = useQuery({
      queryKey: queryKeys.translation(translationId),
      queryFn: () => getTranslation({ id: translationId }),
    })

    return { queryClient, isFetching, translationId, translation: data }
  },
  mounted() {
    const translationId = this.translationId
    const queryClient = this.queryClient

    window.App || (window.App = {})
    window.App.cable = ActionCable.createConsumer()

    window.App.cable.subscriptions.create(
      { channel: 'TranslationChannel', id: translationId },
      {
        connected() {
          console.log('Connected to the channel:', this)
        },
        disconnected() {
          console.log('Disconnected')
        },
        received(translationPhrase) {
          console.log('Received some data:', translationPhrase)
          updateTranslationPhraseInCache({
            queryClient,
            translationId,
            translationPhrase,
          })
        },
      },
    )
  },
})
</script>