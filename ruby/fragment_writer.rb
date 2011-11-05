require 'erb'
require 'rubygems'
require 'redcarpet'

class FragmentWriter
  def initialize(paths)
    @paths = paths
    renderer = Redcarpet::Render::HTML.new
    @markdown = Redcarpet::Markdown.new(renderer)
    @template = ERB.new(IO.read("templates/fragment.html.erb"))
  end

  class Fragment
    attr_reader :fragment_text, :paths

    def initialize(text, paths)
      @fragment_text = text
      @paths = paths
    end

    def get_binding
      binding
    end
  end

  def write(fragment_markdown)
    fragment = Fragment.new(@markdown.render(fragment_markdown), @paths)
    @template.result(fragment.get_binding)
  end
end
