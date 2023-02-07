# frozen_string_literal: true

class Attachment < ApplicationRecord
  validates :id, presence: true, uniqueness: true, format: { without: /\s/ }
  validates :data, presence: true
end
