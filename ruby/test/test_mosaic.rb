require 'mosaic'
require 'test/unit'

class TestMosaic < Test::Unit::TestCase
  def test_single_no_nesting
    mosaic = Mosaic.new(["only"])
    assert_equal(1, mosaic.size)
    assert_equal("only", mosaic.row(0).body)
    assert_nil(mosaic.row(0).comments)
  end

  def test_multiple_no_nesting
    mosaic = Mosaic.new(["first", "second", "third"])
    assert_equal(3, mosaic.size)
    assert_equal(["first", "second", "third"], mosaic.map { |row| row.body })
    mosaic.map { |row| assert_nil(row.comments) }
  end

  def test_single_row_single_comment
    mosaic = Mosaic.new(["only", "# comment"])
    assert_equal(1, mosaic.size)
    row = mosaic.row(0)
    assert_equal("only", row.body)
    comments = row.comments
    assert_equal(1, comments.size)
    comment = comments.row(0)
    assert_equal("comment", comment.body)
    assert_nil(comment.comments)
  end

  def test_single_row_multiple_comments
    mosaic = Mosaic.new(["only", "# comment-1", "# comment-2", "# comment-3"])
    assert_equal(1, mosaic.size)
    row = mosaic.row(0)
    assert_equal("only", row.body)
    comments = row.comments
    assert_equal(3, comments.size)
    assert_equal(["comment-1", "comment-2", "comment-3"], comments.map { |comment| comment.body })
    comments.map { |comment| assert_nil(comment.comments) }
  end
end
