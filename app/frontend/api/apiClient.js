import { camelizeKeys, decamelizeKeys } from 'humps'
import { pickBy } from 'lodash'

const defaultFetch = (
  url,
  method = 'GET',
  { params = {}, body = {}, headers = {} } = {},
) => {
  const queryParams = pickBy(params, Boolean)

  const urlWithParams = Object.keys(queryParams).length
    ? `${url}?${new URLSearchParams(decamelizeKeys(queryParams)).toString()}`
    : url

  return fetch(urlWithParams, {
    method,
    body: body && JSON.stringify(decamelizeKeys(body)),
    headers: {
      ...defaultHeadersWithToken(),
      ...headers,
    },
  })
    .then(processSuccessfulResponse)
    .then(camelizeKeys)
    .catch((error) => {
      if (error?.headers?.get('Content-Type')?.includes('application/json')) {
        return error.json().then((json) => {
          throw json
        })
      }

      throw error
    })
}

const defaultHeadersWithToken = () => {
  const csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content')

  return {
    'Content-Type': 'application/json',
    'X-CSRF-Token': csrfToken,
  }
}

const processSuccessfulResponse = (response) => {
  if (response.ok) {
    return response.json()
  } else {
    return Promise.reject(response)
  }
}

const post = (url, { body = {}, headers = {} } = {}) => {
  return fetch(url, {
    method: 'POST',
    headers: {
      ...defaultHeadersWithToken(),
      ...headers,
    },
    body: JSON.stringify(decamelizeKeys(body)),
  })
    .then(processSuccessfulResponse)
    .then(camelizeKeys)
    .catch((error) => {
      if (error?.headers?.get('Content-Type')?.includes('application/json')) {
        return error.json().then((json) => {
          throw json
        })
      }

      throw error
    })
}

const put = (url, { body = {}, headers = {} } = {}) => {
  return defaultFetch(url, 'PUT', { body, headers })
}

const destroy = (url, { headers = {} } = {}) => {
  return fetch(url, {
    method: 'DELETE',
    headers: {
      ...defaultHeadersWithToken(),
      ...headers,
    },
  })
    .then(processSuccessfulResponse)
    .then(camelizeKeys)
}

const get = (url, { params = {}, headers = {} } = {}) => {
  const queryParams = pickBy(params, Boolean)

  const urlWithParams = Object.keys(queryParams).length
    ? `${url}?${new URLSearchParams(decamelizeKeys(queryParams)).toString()}`
    : url

  return fetch(urlWithParams, {
    method: 'GET',
    headers: {
      ...defaultHeadersWithToken(),
      ...headers,
    },
  })
    .then(processSuccessfulResponse)
    .then(camelizeKeys)
}

export { get, put, post, destroy }
