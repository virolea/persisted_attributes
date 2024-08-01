require "test_helper"

class PersistedAttributesTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert PersistedAttributes::VERSION
  end
end
