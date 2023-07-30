import { get } from '@/api/apiClient'

const getTranslations = () => {
  return get('/api/translations')
}

const getTranslation = ({ id }) => {
  return get(`/api/translations/${id}`)
}

export { getTranslations, getTranslation }
