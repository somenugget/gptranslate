class Translation < ApplicationRecord
  belongs_to :user

  has_many :translation_phrases

  LANGUAGES = {
    'en' => 'English',
    'ge' => 'Georgian',
    'es' => 'Spanish',
    'fr' => 'French',
    'de' => 'German',
    'it' => 'Italian',
    'pt' => 'Portuguese',
    'ru' => 'Russian',
    'zh' => 'Chinese',
    'ja' => 'Japanese',
    'ar' => 'Arabic',
    'hi' => 'Hindi',
    'tr' => 'Turkish',
    'ko' => 'Korean',
    'th' => 'Thai',
    'pl' => 'Polish',
    'uk' => 'Ukrainian',
    'nl' => 'Dutch',
    'sv' => 'Swedish',
    'no' => 'Norwegian',
    'fi' => 'Finnish',
    'da' => 'Danish'
  }.freeze
end
