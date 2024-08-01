module PersistedAttributes
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      has_many :dynamic_fields_attributes, class_name: "PersistedAttributes::Attribute", as: :record
    end

    class_methods do
      def has_persisted_attribute(field_name, field_type: PersistedAttributes::Attribute::DEFAULT_ATTRIBUTE_TYPE)
        raise ArgumentError, "#{field_type} is not a valid PersistedAttributes attribute type. Available values include #{PersistedAttributes::Attribute::AVAILABLE_ATTRIBUTE_TYPES}" unless PersistedAttributes::Attribute::AVAILABLE_ATTRIBUTE_TYPES.include?(field_type.to_sym)

        has_one :"#{field_name}_attribute", -> { where(name: field_name) }, class_name: PersistedAttributes::Attribute.attribute_class_for_attribute_type(field_type), as: :record, inverse_of: :record, dependent: :destroy

        define_method(field_name) do
          if peresisted_attribute_changes["#{field_name}"]
            peresisted_attribute_changes["#{field_name}"].value
          else
            dynamic_fields_attributes.find { |attribute| attribute.name == field_name.to_s }&.value
          end
        end

        define_method("#{field_name}=") do |value|
          # Not checking for `value.blank?` here to account for boolean fields, as false.blank? is true
          peresisted_attribute_changes["#{field_name}"] = if value == "" || value.nil?
            PersistedAttributes::Changes::Delete.new(field_name, self)
          else
            PersistedAttributes::Changes::CreateOrUpdate.new(value, field_name, field_type, self)
          end
        end

        after_save { peresisted_attribute_changes[field_name.to_s]&.save }
      end

    end

    def peresisted_attribute_changes
      @peresisted_attribute_changes ||= {}
    end

    def reload(*)
      super.tap { @peresisted_attribute_changes = nil }
    end
  end
end
