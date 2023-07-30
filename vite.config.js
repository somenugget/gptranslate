import * as path from 'path'

import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from 'vite-plugin-full-reload'
import VuePlugin from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/**/*'], { delay: 250 }),
    VuePlugin(),
  ],
  resolve: {
    alias: [
      {
        find: '@/lib',
        replacement: path.resolve(__dirname, './app/frontend/components/lib/'),
      },
      {
        find: '@/components',
        replacement: path.resolve(__dirname, './app/frontend/components/'),
      },
      {
        find: '@/entrypoints',
        replacement: path.resolve(__dirname, './app/frontend/entrypoints'),
      },
    ],
  },
  server: {
    hmr: {
      port: 3036,
    },
  },
})
