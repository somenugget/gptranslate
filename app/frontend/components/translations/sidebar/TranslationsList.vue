<template>
  <div class="overflow-auto">
    <div v-if="translations?.length" class="flex flex-col gap-y-3">
      <router-link
        v-for="translation in translations"
        :key="translation.id"
        :to="{ name: 'translation', params: { id: translation.id } }"
        :class="[
          {
            'bg-gray-200 hover:bg-gray-200':
              currentTranslationId === translation.id.toString(),
          },
          ' flex gap-x-3 rounded-md p-2 leading-6 text-gray-700 hover:bg-gray-100',
        ]"
      >
        {{ translation.name }}
      </router-link>
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
