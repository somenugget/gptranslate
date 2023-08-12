class CalculateLanguageUsage < Service
  # @!method user
  #  return [User]
  input :user

  def call
    languages_from = Phrase.select('lang_from AS lang').where(translation_id: user.translations).arel
    languages_to = Phrase.select('lang_to AS lang').where(translation_id: user.translations).arel

    subquery = Arel::Nodes::As.new(
      Arel::Nodes::UnionAll.new(languages_from, languages_to),
      Phrase.arel_table
    )

    Phrase.from(subquery).group(:lang).count
  end
end
