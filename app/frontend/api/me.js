import { get } from '@/api/apiClient'

export const getMe = () => get(`/api/me`)
