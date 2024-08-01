class ActiveRecordTest < ActiveSupport::TestCase
  test "setting a field and saving the record sets the attribute" do
    post = Post.create(title: "Post title")
    assert_not_nil post.title_attribute
    assert_equal "Post title", post.reload.title
  end

  test "setting a field returns the updated value" do
    post = Post.new(title: "Post title")
    assert_equal "Post title", post.title
  end

  test "setting a blank field removes the attribute" do
    post = Post.create(title: "Hello, world!")
    post.update(title: "")
    assert_nil post.reload.title_attribute
  end

  test "setting up a wrong field type for a dynamic field raises" do
    assert_raises ArgumentError do
      Post.has_persisted_attribute :title, type: :wrong_type
    end
  end

  test "reloading the model removes the pending updates to attributes" do
    post = Post.create(title: "Hello, world!")
    post.title = "New title"
    post.reload
    assert_equal "Hello, world!", post.title
  end
end
