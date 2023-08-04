<template>
  <div class="">
    <FormKit
      v-slot="{ state }"
      type="form"
      submit-label="Translate"
      :value="{
        langFrom: 'ge',
        langTo: 'en',
      }"
      :actions="false"
      @submit="submit"
    >
      <FormKitMessages />
      <div class="flex items-center gap-2">
        <span>Translate from</span>
        <FormKit
          id="langFrom"
          type="select"
          name="langFrom"
          validation="required"
          :classes="{ outer: 'inline-block' }"
          :options="['en', 'ge', 'fr']"
        />
        <span>to</span>
        <FormKit
          id="langTo"
          type="select"
          name="langTo"
          validation="required"
          :classes="{ outer: 'inline-block' }"
          :options="['en', 'ge', 'fr']"
        />
      </div>

      <textarea ref="hiddenTextarea" class="invisible absolute -top-10 h-1" />
      <div class="relative">
        <FormKit
          id="textFrom"
          type="textarea"
          name="textFrom"
          placeholder="Your text to translate"
          :classes="{
            input:
              'block w-full overflow-y-hidden rounded-md border-0 px-3 py-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-1 focus:ring-inset focus:ring-emerald-400 resize-none',
            message: 'hidden',
          }"
          validation="required"
          @input="textUpdate"
          @node="setTextareaRef"
        />
        <FormKit type="submit" :disabled="!state.valid">
          <template #input>
            <button
              :class="[
                `absolute bottom-2 right-2 rounded bg-emerald-400 p-2 text-white transition hover:bg-emerald-500`,
                {
                  'pointer-events-none opacity-50':
                    !state?.valid || state.loading,
                },
              ]"
            >
              <PaperAirplaneIcon class="h-5 w-5" />
            </button>
          </template>
        </FormKit>
      </div>
    </FormKit>
  </div>
</template>

<script>
import { defineComponent, ref } from 'vue'
import { FormKitMessages } from '@formkit/vue'
import { PaperAirplaneIcon } from '@heroicons/vue/24/outline'
import { useQueryClient } from '@tanstack/vue-query'

import {
  addTranslationPhraseToCache,
  invalidateTranslationsCache,
} from '@/helpers/cache'
import { createTranslationPhrase } from '@/api/translationPhrases'
export default defineComponent({
  name: 'TranslationsForm',
  components: { FormKitMessages, PaperAirplaneIcon },
  props: {
    translation: {
      type: Object,
      default: null,
    },
  },
  setup() {
    const textareaRef = ref(null)
    const textareaMinHeight = ref(64)
    const queryClient = useQueryClient()

    return { queryClient, textareaRef, textareaMinHeight }
  },
  methods: {
    textUpdate() {
      const maxHeight = 300
      this.$refs.hiddenTextarea.value = this.textareaRef.value

      console.log(
        this.textareaMinHeight,
        this.$refs.hiddenTextarea.scrollHeight,
      )
      const newCalculatedHeight = Math.max(
        this.textareaMinHeight,
        this.$refs.hiddenTextarea.scrollHeight,
      )
      const newHeight = Math.min(newCalculatedHeight, maxHeight)

      this.textareaRef.style.height = `${newHeight}px`
      this.textareaRef.style.overflowY =
        newHeight === maxHeight ? 'auth' : 'hidden'
    },
    setTextareaRef(node) {
      node.settled.then(() => {
        this.textareaRef = document.getElementById('textFrom')
        this.textareaMinHeight = this.textareaRef.scrollHeight
      })
    },
    submit(data, node) {
      const translationId = this.$router.currentRoute?.value?.params?.id

      return createTranslationPhrase({
        translationId,
        ...data,
      })
        .then((translationPhrase) => {
          node.reset()

          if (translationId) {
            addTranslationPhraseToCache({
              queryClient: this.queryClient,
              translationPhrase,
            })
          } else {
            invalidateTranslationsCache({ queryClient: this.queryClient })
            this.$router.push({
              name: 'translation',
              params: { id: translationPhrase.translationId },
            })
          }
        })
        .catch((error) => {
          console.log(error)
          node.setErrors(['Failed to send phrase for a translation'])
        })
    },
  },
})
</script>
