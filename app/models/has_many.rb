class HasMany < ApplicationRecord
  # has_many :callback:ers, dependent: :nullify
  has_many :callbackers, dependent: :destroy
end
