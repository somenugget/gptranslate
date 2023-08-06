<template>
  <div ref="wrapper" class="grow overflow-y-auto border-b border-gray-300 pb-2">
    <div v-if="translation" class="flex flex-col gap-5">
      <Phrase
        v-for="phrase in translation.phrases"
        :key="phrase.id"
        :phrase="phrase"
      />
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'

import Phrase from '@/components/translations/Phrase.vue'

export default defineComponent({
  name: 'TranslationList',
  components: { Phrase },
  props: {
    translation: {
      type: Object,
      default: undefined,
    },
  },
  watch: {
    translation() {
      this.$nextTick(() => {
        if (this.$refs.wrapper) {
          this.$refs.wrapper.scrollTop = this.$refs.wrapper.scrollHeight
        }
      })
    },
  },
})
</script>
