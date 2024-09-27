require "test_helper"

module PersistedAttributes
  class AttributeTest < ActiveSupport::TestCase
    test "valid attribute" do
      attribute = PersistedAttributes::Attribute.new(record: Post.new, name: "title")
      assert attribute.valid?
    end

    test "invalid without a name" do
      attribute = PersistedAttributes::Attribute.new(record: Post.new)
      assert_not attribute.valid?
    end

    test "invalid with a duplicate name for a given record" do
      Post.create
      PersistedAttributes::Attribute.create(record: Post.last, name: "title")
      attribute = PersistedAttributes::Attribute.create(record: Post.last, name: "title")

      assert_not attribute.valid?
    end
  end
end
