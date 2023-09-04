import { destroy, get, post, put } from '@/api/apiClient'

const getTranslations = () => {
  return get('/api/translations')
}

const getTranslation = ({ id }) => {
  return get(`/api/translations/${id}`)
}

const createTranslation = ({ translation = {} } = {}) => {
  return post('/api/translations', {
    body: {
      translation,
    },
  })
}
const updateTranslation = ({ id, translation }) => {
  return put(`/api/translations/${id}`, {
    body: {
      translation,
    },
  })
}

const deleteTranslation = ({ id }) => {
  return destroy(`/api/translations/${id}`)
}

export {
  getTranslations,
  getTranslation,
  createTranslation,
  updateTranslation,
  deleteTranslation,
}
