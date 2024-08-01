module PersistedAttributes
  class Attribute < ApplicationRecord
    DEFAULT_ATTRIBUTE_TYPE = :string

    AVAILABLE_ATTRIBUTE_TYPES = %i[
      string
      boolean
      integer
    ].freeze

    belongs_to :record, polymorphic: true

    validates :name, presence: true
    validates :name, uniqueness: { scope: [:record_type, :record_id] }

    class << self
      def attribute_class_for_attribute_type(attribute_type)
        case attribute_type
        when :string
          return "PersistedAttributes::Attribute::StringAttribute"
        when :integer
          return "PersistedAttributes::Attribute::IntegerAttribute"
        when :boolean
          return "PersistedAttributes::Attribute::BooleanAttribute"
        end
      end
    end
  end
end
