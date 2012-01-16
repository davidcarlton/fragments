require 'writer'

class MosaicWriter < Writer
  def initialize(paths, fragments)
    super(paths)
    @fragments = fragments
    @outer = template("outer")
    @row = template("row")
  end

  class Context
    def initialize(fragments, markdown, row_template)
      @fragments = fragments
      @markdown = markdown
      @row_template = row_template
    end

    attr_reader :fragments, :markdown

    def render_row(row)
      context = MosaicRowContext.new(row, @fragments, @markdown, @row_template)
      @row_template.result(context.get_binding)
    end
  end

  class MosaicContext < Context
    def initialize(mosaic, paths, fragments, markdown, row_template)
      super(fragments, markdown, row_template)
      @mosaic = mosaic
      @paths = paths
    end

    attr_reader :paths

    def body_text
      @mosaic.map { |row| render_row(row) }.join("<hr />\n")
    end

    def get_binding
      binding
    end
  end

  class MosaicRowContext < Context
    def initialize(mosaic_row, fragments, markdown, row_template)
      super(fragments, markdown, row_template)
      @mosaic_row = mosaic_row
    end

    def render_body
      markdown.render(fragments[@mosaic_row.body])
    end

    def comments
      @mosaic_row.comments
    end

    def get_binding
      binding
    end
  end

  def write(mosaic)
    body = MosaicContext.new(mosaic, paths, @fragments, markdown, @row)
    @outer.result(body.get_binding)
  end

  def body(mosaic)
    MosaicContext.new(mosaic, paths, @fragments, markdown, @row).body_text
  end
end
