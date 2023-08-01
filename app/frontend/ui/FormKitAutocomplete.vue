<template>
  <Autocomplete
    :options="context.options"
    :label-field="context.labelField"
    :value-field="context.valueField"
    :default-value="context.value"
    @update:model-value="setValue"
  />
</template>

<script>
import { defineComponent } from 'vue'

import Autocomplete from '@/ui/Autocomplete.vue'

export default defineComponent({
  components: { Autocomplete },
  props: {
    context: {
      type: Object,
      required: true,
    },
  },
  mounted() {
    console.log(this.context.value)
  },
  methods: {
    setValue(value) {
      this.context.node.input(value)
    },
  },
})
</script>
