class TranslationSet < ApplicationRecord
  belongs_to :user

  has_many :translations
end
