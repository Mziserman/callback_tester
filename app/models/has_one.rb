class HasOne < ApplicationRecord
  has_one :callbacker, dependent: :nullify, touch: true
  # has_one :callbacker, dependent: :nullify
end
