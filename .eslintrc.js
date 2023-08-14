module.exports = {
  extends: [
    'eslint:recommended',
    'plugin:vue/vue3-recommended',
    'plugin:tailwindcss/recommended',
    'prettier',
  ],
  plugins: ['simple-import-sort', 'vue'],
  env: {
    browser: true,
    node: true,
  },
  rules: {
    'vue/attributes-order': 'error',
    'vue/multi-word-component-names': 'off',
    'vue/require-default-prop': 'off',
    // override/add rules settings here, such as:
    // 'vue/no-unused-vars': 'error'
    'simple-import-sort/imports': [
      'warn',
      {
        groups: [
          // Packages. `vue` related packages go first
          ['^vue(?!.*css$).*$', '^@?\\w', '^lodash'],
          // Internal packages.
          [
            '^@/plugins',
            '^@/components',
            '^@/components/ui',
            '^@/stores',
            '^@/helpers',
            '^@/\\w',
          ],
          // Parent imports. Put `..` last.
          ['^\\.\\.(?!/?$)', '^\\.\\./?$'],
          // Other relative imports. Put same-folder imports and `.` last.
          ['^\\./(?=.*/)(?!/?$)', '^\\.(?!/?$)', '^\\./?$'],
          // Side effect imports.
          ['^\\u0000'],
          // Style imports.
          ['^.+\\.css$'],
        ],
      },
    ],
  },
}
