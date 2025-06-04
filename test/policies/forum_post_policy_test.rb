require 'test_helper'

class ForumPostPolicyTest < ActiveSupport::TestCase
  def test_scope
  end

  def test_show
  assert ForumPostPolicy.new(users(:one), forum_posts(:one)).show?
  end

  def test_create
  end

  def test_update
  end

  def test_destroy
  end
end
