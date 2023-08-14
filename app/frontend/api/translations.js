import { get, put } from '@/api/apiClient'

const getTranslations = () => {
  return get('/api/translations')
}

const getTranslation = ({ id }) => {
  return get(`/api/translations/${id}`)
}

const updateTranslation = ({ id, translation }) => {
  return put(`/api/translations/${id}`, {
    body: {
      translation,
    },
  })
}

export { getTranslations, getTranslation, updateTranslation }
