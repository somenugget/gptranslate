<template>
  <div
    class="flex h-screen w-1/4 shrink-0 flex-col justify-between border-r bg-slate-50 p-2 shadow-inner-right"
  >
    <TranslationsList />
    <CurrentUser />
  </div>
</template>

<script>
import { defineComponent } from 'vue'

import CurrentUser from '@/components/translations/CurrentUser.vue'
import TranslationsList from '@/components/translations/sidebar/TranslationsList.vue'

export default defineComponent({
  name: 'Sidebar',
  components: {
    TranslationsList,
    CurrentUser,
  },
  computed: {
    currentTranslationId() {
      return this.$router.currentRoute?.value?.params?.id
    },
  },
})
</script>
