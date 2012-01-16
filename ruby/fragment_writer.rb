require 'writer'

class FragmentWriter < Writer
  def initialize(paths)
    super
    @template = template("outer")
  end

  class FragmentContext
    attr_reader :body_text, :paths

    def initialize(text, paths)
      @body_text = text
      @paths = paths
    end

    def get_binding
      binding
    end
  end

  def write(fragment_markdown)
    fragment = FragmentContext.new(body(fragment_markdown), paths)
    @template.result(fragment.get_binding)
  end

  def body(fragment_markdown)
    markdown.render(fragment_markdown)
  end
end
