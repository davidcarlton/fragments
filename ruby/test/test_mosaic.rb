require 'mosaic'
require 'test/unit'

class TestMosaic < Test::Unit::TestCase
  def test_single_no_comments
    mosaic = Mosaic.new(["only"])
    assert_equal(1, mosaic.size)
    assert_equal("only", mosaic.row(0).body)
    assert_nil(mosaic.row(0).comments)
  end

  def test_multiple_no_comments
    mosaic = Mosaic.new(["first", "second", "third"])
    assert_equal(3, mosaic.size)
    assert_equal(["first", "second", "third"], bodies(mosaic))
    mosaic.map { |row| assert_nil(row.comments) }
  end

  def test_whitespace
    mosaic = Mosaic.new([" a", "b\n"])
    assert_equal(["a", "b"], bodies(mosaic))
  end

  def test_single_row_single_comment
    mosaic = Mosaic.new(["only", "* comment"])
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
    mosaic = Mosaic.new(["only", "* comment-1", "* comment-2", "* comment-3"])
    assert_equal(1, mosaic.size)
    row = mosaic.row(0)
    assert_equal("only", row.body)
    comments = row.comments
    assert_equal(["comment-1", "comment-2", "comment-3"], bodies(comments))
    comments.map { |comment| assert_nil(comment.comments) }
  end

  def test_varying_comment_whitespace
    mosaic = Mosaic.new(["only", "*comment-1", "*  comment-2", "* comment-3\n"])
    assert_equal(["comment-1", "comment-2", "comment-3"], comment_bodies(mosaic.row(0)))
  end

  def test_multiple_rows_comments
    mosaic = Mosaic.new(["1", "*1-1", "2", "*2-1", "*2-2", "3", "4", "*4-1"])
    assert_equal(4, mosaic.size)
    assert_equal(["1-1"], comment_bodies(mosaic.row(0)))
    assert_equal(["2-1", "2-2"], comment_bodies(mosaic.row(1)))
    assert_nil(mosaic.row(2).comments)
    assert_equal(["4-1"], comment_bodies(mosaic.row(3)))
  end

  def test_nested_comments
    mosaic = Mosaic.new(["outer", "*middle-1", "**inner-1-1", "**inner-1-2", "*middle-2", "*middle-3", "**inner-3-1"])
    comments = mosaic.row(0).comments
    assert_equal(3, comments.size)
    assert_equal(["inner-1-1", "inner-1-2"], comment_bodies(comments.row(0)))
    assert_nil(comments.row(1).comments)
    assert_equal(["inner-3-1"], comment_bodies(comments.row(2)))
  end

  def test_all_fragments_no_comments
    mosaic = Mosaic.new(["1", "2", "3"])
    assert_equal(Set["1", "2", "3"], mosaic.all_fragments)
  end

  def test_all_fragments_comments
    mosaic = Mosaic.new(["1", "*1-1", "*1-2", "2", "*2-1", "3"])
    assert_equal(Set["1", "1-1", "1-2", "2", "2-1", "3"], mosaic.all_fragments)
  end

  def test_all_fragments_nested_comments
    mosaic = Mosaic.new(["outer", "*middle", "**inner"])
    assert_equal(Set["outer", "middle", "inner"], mosaic.all_fragments)
  end

  def bodies(mosaic)
    mosaic.map { |row| row.body }
  end

  def comment_bodies(row)
    bodies(row.comments)
  end
end
