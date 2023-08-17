<template>
  <div ref="wrapper" class="grow overflow-y-auto border-b border-gray-300 pb-2">
    <div v-if="isSuccess" class="flex flex-col gap-5">
      <Phrase
        v-for="phrase in translations"
        :key="phrase.id"
        :phrase="phrase"
      />
    </div>
  </div>
</template>

<script>
import { computed, defineComponent, ref } from 'vue'
import { useQuery } from '@tanstack/vue-query'

import Phrase from '@/components/translations/Phrase.vue'
import queryKeys from '@/helpers/queryKeys'
import { translationPhrases } from '@/api/phrases'

export default defineComponent({
  name: 'TranslationList',
  components: { Phrase },
  props: {
    translationId: {
      type: String,
      default: undefined,
    },
    translation: {
      type: Object,
      default: undefined,
    },
  },
  setup(props) {
    const scrollTopBetweenUpdates = ref(0)
    const translationId = computed(() => props.translationId)
    const { isSuccess, data } = useQuery({
      queryKey: queryKeys.translationPhrases(translationId),
      queryFn: () =>
        translationPhrases({ translationId: translationId.value.toString() }),
    })

    return { isSuccess, scrollTopBetweenUpdates, translations: data }
  },
  watch: {
    translations(next, prev) {
      // when new phrase was added
      if (!prev || next?.length > prev?.length) {
        this.$nextTick(() => {
          if (this.$refs.wrapper) {
            this.$refs.wrapper.scrollTop = this.$refs.wrapper.scrollHeight
          }
        })
      }
    },
  },
  beforeUpdate() {
    this.scrollTopBetweenUpdates = this.$refs.wrapper.scrollTop
  },
  updated() {
    this.$refs.wrapper.scrollTop = this.scrollTopBetweenUpdates
  },
})
</script>
