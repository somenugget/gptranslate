const sortLanguagesByUsage = ({ languages, languageUsages = {} }) => {
  return Object.fromEntries(
    Object.entries(languages).sort((a, b) => {
      if (languageUsages[a[0]] && languageUsages[b[0]]) {
        return languageUsages[b[0]] - languageUsages[a[0]]
      }

      if (languageUsages[a[0]]) {
        return -1
      }

      if (languageUsages[b[0]]) {
        return 1
      }

      return a[1].localeCompare(b[1])
    }),
  )
}

export { sortLanguagesByUsage }
