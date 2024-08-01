module PersistedAttributes
  class Changes::Delete
    attr_reader :record, :field_name, :value

    def initialize(field_name, record)
      @field_name, @record = field_name, record
      @value = nil
    end

    def save
      record.public_send("#{field_name}_attribute=", nil)
    end
  end
end
