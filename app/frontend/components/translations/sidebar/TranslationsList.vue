<template>
  <div class="overflow-auto">
    <div v-if="translations?.length" class="flex flex-col gap-y-3">
      <SidebarTranslation
        v-for="translation in translations"
        :key="translation.id"
        :translation="translation"
      />
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { useQuery } from '@tanstack/vue-query'

import SidebarTranslation from '@/components/translations/sidebar/SidebarTranslation.vue'
import queryKeys from '@/helpers/queryKeys'
import { getTranslations } from '@/api/translations'

export default defineComponent({
  name: 'Sidebar',
  components: { SidebarTranslation },
  setup() {
    const { isFetching, data } = useQuery({
      queryKey: queryKeys.translations(),
      queryFn: getTranslations,
    })

    return { isFetching, translations: data }
  },
})
</script>
