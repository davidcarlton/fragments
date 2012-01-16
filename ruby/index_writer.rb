require 'erb'
require 'rubygems'
require 'redcarpet'

class IndexWriter
  def initialize(paths)
    @paths = paths
    renderer = Redcarpet::Render::HTML.new
    @markdown = Redcarpet::Markdown.new(renderer)
    @template = ERB.new(IO.read("templates/index.html.erb"))
    @entries = Set.new
  end

  MaxEntries = 20

  class IndexContext
    attr_reader :fragments, :paths

    def initialize(fragments, paths, markdown)
      @fragments = fragments
      @paths = paths
      @markdown = markdown
    end

    def get_binding
      binding
    end

    def render_fragment(fragment)
      @markdown.render(fragment[:text])
    end

    def title(fragment)
      fragment[:name]
    end

    def path(fragment)
      @paths.item_path("fragments", fragment[:name])
    end
  end

  def add(name, text, timestamp)
    @entries << {
      :name => name,
      :text => text,
      :timestamp => timestamp
    }
  end

  def fragments
    @entries.sort { |a, b| b[:timestamp] <=> a[:timestamp] }.take(MaxEntries)
  end

  def write
    fragment = IndexContext.new(fragments, @paths, @markdown)
    @template.result(fragment.get_binding)
  end
end
