class MosaicRow
  def initialize(body, comments)
    @body = body
    @comments = comments
  end

  attr_reader :body, :comments
end
