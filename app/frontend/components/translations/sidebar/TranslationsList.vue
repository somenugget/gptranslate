<template>
  <div>
    <div v-if="translations?.length">
      <div
        v-for="translation in translations"
        :key="translation.id"
        :class="[
          { 'bg-gray-100': currentTranslationId === translation.id.toString() },
          'mb-3 p-1 px-2 rounded',
        ]"
      >
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
  computed: {
    currentTranslationId() {
      return this.$router.currentRoute?.value?.params?.id
    },
  },
})
</script>
