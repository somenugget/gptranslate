<template>
  <button
    type="button"
    class="inline-flex items-center rounded border border-transparent px-1 py-0.5 text-xs text-red-400 transition hover:bg-red-50"
    :class="{ 'pointer-events-none': isDeleting }"
    :disabled="isDeleting"
    @click="deletePhrase"
  >
    Delete
  </button>
</template>

<script>
import { useRoute } from 'vue-router'
import { useMutation, useQueryClient } from '@tanstack/vue-query'

import queryKeys from '@/helpers/queryKeys'
import { deletePhrase } from '@/api/phrases'

export default {
  name: 'DeleteTranslationButton',
  props: {
    id: {
      type: Number,
      default: undefined,
    },
  },
  setup(props) {
    const route = useRoute()
    const queryClient = useQueryClient()
    const { isLoading, mutateAsync } = useMutation({
      mutationFn: () => {
        return deletePhrase({ phraseId: props.id })
      },
    })

    return {
      queryClient,
      mutateAsync,
      isDeleting: isLoading,
      translationId: parseInt(route.params.id),
    }
  },
  methods: {
    deletePhrase() {
      console.log(this.isDeleting)
      this.mutateAsync().then(() => {
        console.log('phrase deleted')
        console.log(queryKeys.translationPhrases(this.translationId))
        this.queryClient.refetchQueries({
          queryKey: queryKeys.translationPhrases(this.translationId),
        })
      })
    },
  },
}
</script>
