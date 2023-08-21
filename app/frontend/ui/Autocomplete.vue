<template>
  <Combobox v-model="selectedValue" :by="valueField">
    <div
      class="relative w-full cursor-default rounded-lg bg-white text-left sm:text-sm"
    >
      <ComboboxInput
        :display-value="(option) => option && option[labelField]"
        class="w-full rounded py-2 pl-3 text-gray-900"
        @change="query = $event.target.value"
      />
      <ComboboxButton class="absolute inset-y-0 right-0 flex items-center pr-2">
        <ChevronUpDownIcon class="h-5 w-5 text-gray-400" aria-hidden="true" />
      </ComboboxButton>
      <ComboboxOptions
        class="ring-opacity/5 absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md bg-white py-1 text-base shadow-lg ring-1 ring-black focus:outline-none sm:text-sm"
        :class="{
          hidden: filteredOptions.length === 0 && query.length < minQuery,
        }"
      >
        <div
          v-if="filteredOptions.length === 0 && query.length >= minQuery"
          class="relative cursor-default select-none px-4 py-2 text-gray-700"
        >
          Nothing found.
        </div>

        <ComboboxOption
          v-for="option in filteredOptions"
          v-slot="{ selected, active }"
          :key="option[valueField]"
          :value="option"
        >
          <li
            class="relative cursor-default select-none py-2 pl-7 pr-4"
            :class="{
              'bg-teal-600 text-white': active,
              'text-gray-900': !active,
            }"
          >
            <span
              class="block truncate"
              :class="{ 'font-medium': selected, 'font-normal': !selected }"
            >
              {{ option[labelField] }}
            </span>
            <span
              v-if="selected"
              class="absolute inset-y-0 left-0 flex items-center pl-2"
              :class="{ 'text-white': active, 'text-teal-600': !active }"
            >
              <CheckIcon size="12" class="h-4 w-4" aria-hidden="true" />
            </span>
          </li>
        </ComboboxOption>
      </ComboboxOptions>
    </div>
  </Combobox>
</template>

<script>
import { defineComponent } from 'vue'
import {
  Combobox,
  ComboboxButton,
  ComboboxInput,
  ComboboxOption,
  ComboboxOptions,
} from '@headlessui/vue'
import { CheckIcon, ChevronUpDownIcon } from '@heroicons/vue/20/solid'

export default defineComponent({
  name: 'Autocomplete',
  components: {
    Combobox,
    ComboboxInput,
    ComboboxOptions,
    ComboboxOption,
    ComboboxButton,
    CheckIcon,
    ChevronUpDownIcon,
  },
  props: {
    labelField: {
      type: String,
      default: 'name',
    },
    valueField: {
      type: String,
      default: 'id',
    },
    options: {
      type: Array,
      required: true,
    },
    defaultValue: {
      type: Object,
      default: null,
    },
  },
  data: function () {
    return {
      query: '',
      minQuery: 3,
      selectedValue: this.defaultValue,
    }
  },
  computed: {
    filteredOptions() {
      if (this.query.length < this.minQuery) {
        return []
      }

      return this.options.filter((option) => {
        return (
          option[this.valueField]
            .toString()
            .toLowerCase()
            .includes(this.query.toLowerCase()) ||
          option[this.labelField]
            .toString()
            .toLowerCase()
            .includes(this.query.toLowerCase())
        )
      })
    },
  },
})
</script>
