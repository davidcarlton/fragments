require 'mosaic_row'
require 'set'

class Mosaic
  include Enumerable

  def initialize(rows)
    @rows = []

    while (!rows.empty?)
      @rows.push(next_row(rows))
    end
  end

  def each(&block)
    @rows.each { |row| block.call(row) }
  end

  def size
    @rows.size
  end

  def row(i)
    @rows[i]
  end

  def all_fragments
    fragments = Set.new(@rows.map { |row| row.body })
    @rows.each do |row|
      fragments.merge(row.comments.all_fragments) if (!row.comments.nil?)
    end
    fragments
  end

  def next_row(rows)
    body = rows.shift.strip
    comments = []
    while (!rows.empty? && rows[0][0] == ?*)
      comment = rows.shift
      comments.push(comment.slice(1, comment.length - 1).strip) 
    end

    if (comments.empty?)
      MosaicRow.new(body, nil)
    else
      MosaicRow.new(body, Mosaic.new(comments))
    end
  end
end
