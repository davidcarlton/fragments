require 'erb'
require 'rubygems'
require 'redcarpet'

class FragmentWriter
  def initialize
    renderer = Redcarpet::Render::HTML.new
    @markdown = Redcarpet::Markdown.new(renderer)
    @template = ERB.new(IO.read("templates/fragment.html.erb"))
  end

  class Fragment
    attr_reader :fragment_text

    def initialize(text)
      @fragment_text = text
    end

    def get_binding
      binding
    end
  end

  def write(fragment_markdown)
    fragment = Fragment.new(@markdown.render(fragment_markdown))
    @template.result(fragment.get_binding)
  end
end
