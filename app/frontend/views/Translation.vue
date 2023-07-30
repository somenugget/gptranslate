<template>
  <div class="h-full overflow-y-auto">
    <div
      v-for="translationPhrase in translation.translationPhrases"
      :key="translationPhrase.id"
      class="flex gap-2 mb-3"
    >
      <div class="w-1/2">
        <h5>
          {{ translationPhrase.langFrom }}
        </h5>
        {{ translationPhrase.textFrom }}
      </div>
      <div class="w-1/2">
        <h5>
          {{ translationPhrase.langTo }}
        </h5>
        {{ translationPhrase.textTo }}
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { useRoute } from 'vue-router'
import { useQuery } from '@tanstack/vue-query'

import { getTranslation } from '@/api/translations'

export default defineComponent({
  name: 'Translation',
  setup() {
    const { params } = useRoute()
    console.log(params)
    const { isFetching, data } = useQuery({
      queryKey: ['translations', params.id],
      queryFn: () => getTranslation({ id: params.id }),
    })

    return { isFetching, translation: data }
  },
})
</script>
