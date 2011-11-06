require 'erb'
require 'rubygems'
require 'redcarpet'

class MosaicWriter
  def initialize(paths, fragments)
    @paths = paths
    @fragments = fragments
    renderer = Redcarpet::Render::HTML.new
    @markdown = Redcarpet::Markdown.new(renderer)
    @outer = ERB.new(IO.read("templates/outer.html.erb"))
    #@comment = ERB.new(IO.read("templates/row.html.erb"))
  end

  class MosaicBody
    attr_reader :paths

    def initialize(mosaic, paths, fragments, markdown)
      @mosaic = mosaic
      @paths = paths
      @fragments = fragments
      @markdown = markdown
    end

    def body_text
      @mosaic.map { |row| @markdown.render(@fragments[row.body]) }.join("<hr />\n")
    end

    def get_binding
      binding
    end
  end

  def write(mosaic)
    body = MosaicBody.new(mosaic, @paths, @fragments, @markdown)
    @outer.result(body.get_binding)
  end
end
