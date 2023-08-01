<template>
  <div v-if="translation" ref="wrapper" class="overflow-y-auto">
    <div
      v-for="translationPhrase in translation.translationPhrases"
      :key="translationPhrase.id"
      class="flex gap-2 mb-3 px-3 py-2"
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

export default defineComponent({
  name: 'TranslationList',
  components: {},
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
