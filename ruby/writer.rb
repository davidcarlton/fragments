require 'erb'
require 'rubygems'
require 'redcarpet'

class Writer
  def initialize(paths)
    @paths = paths
    renderer = Redcarpet::Render::HTML.new
    @markdown = Redcarpet::Markdown.new(renderer)
  end

  attr_reader :paths, :markdown

  def template(name)
    ERB.new(IO.read("templates/#{name}.html.erb"))
  end
end
