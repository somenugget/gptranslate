<template>
  <Sidebar />
  <MainSectionWrapper>
    <router-view />
  </MainSectionWrapper>
</template>

<script>
import { defineComponent } from 'vue'

import MainSectionWrapper from '@/components/translations/MainSectionWrapper.vue'
import Sidebar from '@/components/translations/Sidebar.vue'

export default defineComponent({
  name: 'Translations',
  components: {
    MainSectionWrapper,
    Sidebar,
  },

  data() {
    return {
      msg: 'Welcome to Your Vue.js App',
    }
  },
})
</script>
