<template>
  <PhrasesList :translation="translation" :translation-id="translationId" />
  <TranslationsForm />
</template>

<script>
import { defineComponent, ref, watch } from 'vue'
import { useRoute } from 'vue-router'
import { useQuery, useQueryClient } from '@tanstack/vue-query'

import PhrasesList from '@/components/translations/PhrasesList.vue'
import TranslationsForm from '@/components/translations/TranslationsForm.vue'
import { createTranslationChannelSubscription } from '@/helpers/cable'
import { updatePhraseInCache } from '@/helpers/cache'
import queryKeys from '@/helpers/queryKeys'
import { getTranslation } from '@/api/translations'

export default defineComponent({
  name: 'Translation',
  components: {
    PhrasesList,
    TranslationsForm,
  },
  setup() {
    const queryClient = useQueryClient()
    const route = useRoute()
    const translationId = ref(route.params.id)
    const previousTranslationId = ref(route.params.id)

    watch(
      () => route.params.id,
      () => {
        previousTranslationId.value = translationId.value
        translationId.value = route.params.id
      },
    )

    const { isFetching, data } = useQuery({
      queryKey: queryKeys.translation(translationId),
      queryFn: () => getTranslation({ id: translationId.value }),
      placeholderData: () => {
        return queryClient.getQueryData(
          queryKeys.translation(previousTranslationId),
        )
      },
    })

    return {
      queryClient,
      isFetching,
      translationId: translationId,
      translation: data,
    }
  },
  watch: {
    translationId() {
      this.connectToTranslationChannel()
    },
  },
  mounted() {
    this.subscription?.unsubscribe()
    this.connectToTranslationChannel()
  },
  methods: {
    connectToTranslationChannel() {
      const translationId = this.translationId
      const queryClient = this.queryClient
      let wasDisconnected = false

      this.subscription = createTranslationChannelSubscription({
        translationId,
        mixin: {
          connected() {
            console.log('Connected to the channel:', this)

            if (wasDisconnected) {
              queryClient.invalidateQueries({
                queryKey: queryKeys.translation(translationId),
                refetchType: 'all',
              })
            }
          },
          disconnected() {
            wasDisconnected = true
            console.log('Disconnected')
          },
          received(phrase) {
            console.log('Received some data:', phrase)
            updatePhraseInCache({
              queryClient,
              translationId,
              phrase,
            })
          },
        },
      })
    },
  },
})
</script>
