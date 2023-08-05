class Translation < ApplicationRecord
  belongs_to :user

  has_many :translation_phrases, -> { order(:created_at) }

  LANGUAGES = {
    'en' => 'English',
    'ge' => 'Georgian',
    'uk' => 'Ukrainian',
    'zh' => 'Chinese',
    'hi' => 'Hindi',
    'es' => 'Spanish',
    'fr' => 'French',
    'ar' => 'Standard Arabic',
    'pt' => 'Portuguese',
    'id' => 'Indonesian',
    'de' => 'German',
    'ru' => 'Russian',
    'ja' => 'Japanese',
    'it' => 'Italian',
    'nl' => 'Dutch',
    'pl' => 'Polish',
    'ko' => 'Korean',
    'tr' => 'Turkish',
    'vi' => 'Vietnamese',
    'no' => 'Norwegian',
    'sv' => 'Swedish',
    'fi' => 'Finnish',
    'da' => 'Danish'
  }.freeze

  def phrases
    translation_phrases
  end
end
