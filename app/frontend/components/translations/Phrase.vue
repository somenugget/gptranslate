<template>
  <article class="flex items-start justify-between gap-4">
    <div class="flex w-1/2 flex-col">
      <div class="flex items-center gap-x-4 text-xs">
        <span class="text-gray-500">{{ phrase.langFrom }}</span>
      </div>
      <div class="group relative">
        <p class="mt-1 whitespace-pre-wrap leading-6">
          {{ phrase.textFrom }}
        </p>
      </div>
    </div>

    <div class="flex w-1/2 flex-col">
      <div class="flex items-center justify-between gap-x-4 text-xs">
        <span class="text-gray-500">{{ phrase.langTo }}</span>
        <button
          v-if="showBadge"
          class="pointer-events-none cursor-default rounded-full px-2 py-1 font-medium text-gray-600 transition"
          :class="badgeClass"
          :title="badgeTitle"
          @click="retry"
        >
          {{ badgeStatus }}
        </button>
      </div>
      <div class="group relative">
        <p class="mt-1 whitespace-pre-wrap leading-6">
          {{ phrase.textTo }}
        </p>
      </div>
    </div>
  </article>
</template>

<script>
import { defineComponent } from 'vue'
import { useMutation, useQueryClient } from '@tanstack/vue-query'
import { startCase } from 'lodash'

import { updatePhraseInCache } from '@/helpers/cache'
import { retryPhraseTranslation } from '@/api/phrases'

export default defineComponent({
  name: 'Phrase',
  props: {
    phrase: {
      type: Object,
      default: undefined,
    },
  },
  setup(props) {
    const queryClient = useQueryClient()
    const { mutateAsync } = useMutation({
      mutationFn: () => {
        retryPhraseTranslation({ phraseId: props.phrase.id })
      },
    })

    return { queryClient, retryPhraseTranslation: mutateAsync }
  },
  computed: {
    showBadge() {
      return ['failed', 'pending', 'in_progress'].includes(this.phrase?.status)
    },
    badgeTitle() {
      return this.phrase?.status === 'failed' ? 'Click to retry' : ''
    },
    badgeClass() {
      return {
        'bg-red-100 text-red-800 pointer-events-auto cursor-pointer active:translate-y-0.5':
          this.phrase?.status === 'failed',
        'bg-yellow-100 text-yellow-800 hover:bg-red-200':
          this.phrase?.status === 'pending',
        'bg-emerald-200 text-emerald-800':
          this.phrase?.status === 'in_progress',
      }
    },
    badgeStatus() {
      return startCase(this.phrase?.status).toLowerCase()
    },
  },
  methods: {
    retry() {
      updatePhraseInCache({
        queryClient: this.queryClient,
        phrase: {
          id: this.phrase.id,
          translationId: this.phrase.translationId,
          status: 'pending',
        },
      })

      this.retryPhraseTranslation()
    },
  },
})
</script>
