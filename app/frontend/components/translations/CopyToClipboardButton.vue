<template>
  <button
    type="button"
    class="inline-flex items-center rounded border border-transparent px-1 py-0.5 text-xs text-gray-500 transition hover:bg-gray-100"
    @click="copyToClipboard"
  >
    {{ isCopied ? 'Copied' : 'Copy' }}
  </button>
</template>

<script>
export default {
  name: 'CopyToClipboardButton',
  props: {
    text: {
      type: String,
      default: undefined,
    },
  },
  data() {
    return {
      isCopied: false,
    }
  },
  methods: {
    copyToClipboard() {
      this.isCopied = true

      navigator.clipboard.writeText(this.text)

      setTimeout(() => {
        this.isCopied = false
      }, 3000)
    },
  },
}
</script>
