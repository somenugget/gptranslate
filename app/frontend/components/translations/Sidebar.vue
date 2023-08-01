<template>
  <div class="w-1/4 p-2 border-r border-gray-300 shrink-0">
    <div v-if="translations?.length">
      <div v-for="translation in translations" :key="translation.id">
        <router-link
          :to="{ name: 'translation', params: { id: translation.id } }"
        >
          {{ translation.name }}
        </router-link>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { useQuery } from '@tanstack/vue-query'

import queryKeys from '@/helpers/queryKeys'
import { getTranslations } from '@/api/translations'

export default defineComponent({
  name: 'Sidebar',
  setup() {
    const { isFetching, data } = useQuery({
      queryKey: queryKeys.translations(),
      queryFn: getTranslations,
    })

    return { isFetching, translations: data }
  },
})
</script>
