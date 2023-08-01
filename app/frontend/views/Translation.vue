<template>
  <div class="flex flex-col">
    <TranslationsList :translation="translation" />
    <TranslationsForm :translation="translation" />
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { useRoute } from 'vue-router'
import { useQuery } from '@tanstack/vue-query'

import TranslationsForm from '@/components/translations/TranslationsForm.vue'
import TranslationsList from '@/components/translations/TranslationsList.vue'
import queryKeys from '@/helpers/queryKeys'
import { getTranslation } from '@/api/translations'

export default defineComponent({
  name: 'Translation',
  components: {
    TranslationsList,
    TranslationsForm,
  },
  setup() {
    const { params } = useRoute()
    const { isFetching, data } = useQuery({
      queryKey: queryKeys.translation(params.id),
      queryFn: () => getTranslation({ id: params.id }),
    })

    return { isFetching, translation: data }
  },
})
</script>
