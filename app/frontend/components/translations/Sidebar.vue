<template>
  <div
    class="flex h-screen w-1/4 max-w-xs shrink-0 flex-col justify-between border-r bg-slate-50 p-2 shadow-inner-right"
  >
    <div>
      <TopPanel />
      <TranslationsList />
    </div>
    <CurrentUser />
  </div>
</template>

<script>
import { defineComponent } from 'vue'

import CurrentUser from '@/components/translations/sidebar/CurrentUser.vue'
import TopPanel from '@/components/translations/sidebar/TopPanel.vue'
import TranslationsList from '@/components/translations/sidebar/TranslationsList.vue'

export default defineComponent({
  name: 'Sidebar',
  components: {
    TranslationsList,
    TopPanel,
    CurrentUser,
  },
  computed: {
    currentTranslationId() {
      return this.$router.currentRoute?.value?.params?.id
    },
  },
})
</script>
