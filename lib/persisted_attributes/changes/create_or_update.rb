module PersistedAttributes
  class Changes::CreateOrUpdate
    attr_reader :record, :value, :field_name, :field_type, :attribute

    def initialize(value, field_name, field_type, record)
      @value, @field_name, @field_type, @record = value, field_name, field_type, record
      @attribute = find_or_build_attribute
    end

    def save
      attribute.value = value
      record.public_send("#{field_name}_attribute=", attribute)
    end

    private

    def find_or_build_attribute
      record.dynamic_fields_attributes.find_or_initialize_by(
        name: field_name,
        type: PersistedAttributes::Attribute.attribute_class_for_attribute_type(field_type)
      )
    end
  end
end
