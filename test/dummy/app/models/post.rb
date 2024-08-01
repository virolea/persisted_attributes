class Post < ApplicationRecord
  include PersistedAttributes::ActiveRecord

  has_persisted_attribute :title
  has_persisted_attribute :reading_time, field_type: :integer
  has_persisted_attribute :published, field_type: :boolean
end
