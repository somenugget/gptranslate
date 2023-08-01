<template>
  <div class="border h-1/6">
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
      <div class="flex gap-2 items-center">
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

      <FormKit
        id="textFrom"
        type="textarea"
        name="textFrom"
        :classes="{ input: 'w-full resize-none', message: 'hidden' }"
        validation="required"
      />
      <FormKit
        type="submit"
        :disabled="!state.valid"
        :classes="{
          input: `bg-emerald-400 hover:bg-emerald-500 transition rounded px-3 py-1 text-white ${
            (state?.valid && !state.loading) || 'opacity-50 pointer-events-none'
          }`,
        }"
      />
    </FormKit>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { FormKitMessages } from '@formkit/vue'
import { useQueryClient } from '@tanstack/vue-query'

import {
  addTranslationPhraseToCache,
  invalidateTranslationsCache,
} from '@/helpers/cache'
import { createTranslationPhrase } from '@/api/translationPhrases'

export default defineComponent({
  name: 'TranslationsForm',
  components: { FormKitMessages },
  props: {
    translation: {
      type: Object,
      default: null,
    },
  },
  setup() {
    const queryClient = useQueryClient()
    return { queryClient }
  },
  methods: {
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
