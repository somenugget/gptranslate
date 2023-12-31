class Translation < ApplicationRecord
  belongs_to :user

  has_many :phrases, -> { order(:created_at) }, dependent: :delete_all

  LANGUAGES = {
    'en' => 'English',
    'ge' => 'Georgian',
    'uk' => 'Ukrainian',
    'zh' => 'Chinese',
    'hi' => 'Hindi',
    'es' => 'Spanish',
    'fr' => 'French',
    'ar' => 'Arabic',
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
end
