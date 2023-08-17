<template>
  <div class="pt-2">
    <FormKit
      id="translationForm"
      v-slot="{ state, value }"
      type="form"
      name="translationForm"
      submit-label="Translate"
      :value="{
        langFrom: $currentUser.settings.languageFrom || languages[0],
        langTo: $currentUser.settings.languageTo || languages[1],
      }"
      :classes="{ form: 'flex flex-col gap-2' }"
      :actions="false"
      @submit="submit"
    >
      <FormKitMessages />
      <div class="flex items-center gap-2">
        <span class="text-sm text-gray-600">Translate from</span>
        <FormKit
          id="langFrom"
          type="select"
          name="langFrom"
          validation="required"
          :classes="{
            outer: 'inline-block',
            input:
              'px-2 py-1 border border-slate-100 text-sm text-gray-600 font-medium cursor-pointer',
          }"
          :options="languages"
          @input="setLanguages('langFrom', value.langFrom)"
        />
        <span class="text-sm text-gray-600">to</span>
        <FormKit
          id="langTo"
          type="select"
          name="langTo"
          validation="required"
          :classes="{
            outer: 'inline-block',
            input:
              'px-2 py-1 border border-slate-100 text-sm text-gray-600 font-medium',
          }"
          :options="languages"
          @input="setLanguages('langTo', value.langTo)"
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
              'block w-full transition-[height] duration-100 overflow-y-hidden rounded-md border-0 px-3 py-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-1 focus:ring-inset focus:ring-emerald-400 resize-none',
            message: 'hidden',
          }"
          validation="required:trim"
          @input="textareaHeightUpdate"
          @node="setTextareaRef"
          @keydown.enter="addNewlineOrSubmit"
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
import { getNode } from '@formkit/core'
import { FormKitMessages } from '@formkit/vue'
import { PaperAirplaneIcon } from '@heroicons/vue/24/outline'
import { useQueryClient } from '@tanstack/vue-query'

import { addPhraseToCache, invalidateTranslationsCache } from '@/helpers/cache'
import { sortLanguagesByUsage } from '@/helpers/languages'
import { createPhrase } from '@/api/phrases'
export default defineComponent({
  name: 'TranslationsForm',
  components: { FormKitMessages, PaperAirplaneIcon },
  setup() {
    const textareaRef = ref(null)
    const textareaMinHeight = ref(64)
    const queryClient = useQueryClient()

    return { queryClient, textareaRef, textareaMinHeight }
  },
  computed: {
    languages() {
      return sortLanguagesByUsage({
        languages: this.$languages,
        languageUsages: this.$currentUser.languageUsages,
      })
    },
  },
  mounted() {
    window.addEventListener('resize', this.textareaHeightUpdate)
  },
  beforeUnmount() {
    window.removeEventListener('resize', this.textareaHeightUpdate)
  },
  methods: {
    textareaHeightUpdate() {
      const maxHeight = 300
      this.$refs.hiddenTextarea.value = this.textareaRef.value
      this.$refs.hiddenTextarea.style.width = `${this.textareaRef.offsetWidth}px`

      const newCalculatedHeight = Math.max(
        this.textareaMinHeight,
        this.$refs.hiddenTextarea.scrollHeight,
      )
      const newHeight = Math.min(newCalculatedHeight, maxHeight)

      this.textareaRef.style.height = `${newHeight}px`
      this.textareaRef.style.overflowY =
        newHeight === maxHeight ? 'auto' : 'hidden'
    },
    setTextareaRef(node) {
      node.settled.then(() => {
        this.textareaRef = document.getElementById('textFrom')
        this.textareaMinHeight = this.textareaRef.scrollHeight
      })
    },
    setLanguages(changedNodeName, prevValue) {
      const changedNode = getNode(changedNodeName)
      const otherNode = getNode(
        changedNodeName === 'langFrom' ? 'langTo' : 'langFrom',
      )

      if (changedNode.value === otherNode.value) {
        otherNode.input(prevValue)
      }
    },
    addNewlineOrSubmit(e) {
      e.preventDefault()

      if (e.key !== 'Enter') {
        return
      }

      if (e.ctrlKey) {
        this.addNewline()
      } else {
        const translationForm = this.$formkit.get('translationForm')

        if (translationForm.context.state.valid) {
          translationForm.submit()
        }
      }
    },
    addNewline() {
      const textFromNode = getNode('textFrom')
      const newValue = textFromNode.value ? textFromNode.value + '\n' : '\n'

      getNode('textFrom').input(newValue)

      this.textareaHeightUpdate()
    },
    submit(data, node) {
      const translationId = this.$router.currentRoute?.value?.params?.id

      return createPhrase({
        translationId,
        ...data,
      })
        .then((phrase) => {
          this.$currentUser.settings.languageFrom = data.langFrom
          this.$currentUser.settings.languageTo = data.langTo

          node.reset({
            textFrom: '',
            langFrom: data.langFrom,
            langTo: data.langTo,
          })

          this.$nextTick(() => {
            this.textareaHeightUpdate()

            setTimeout(function () {
              document.getElementById('textFrom').focus()
            }, 0)
          })

          if (translationId) {
            addPhraseToCache({
              queryClient: this.queryClient,
              phrase,
            })
          } else {
            invalidateTranslationsCache({ queryClient: this.queryClient })
            this.$router.push({
              name: 'translation',
              params: { id: phrase.translationId },
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
