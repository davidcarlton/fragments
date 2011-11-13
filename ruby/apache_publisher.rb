require 'date'
require 'publisher'

class ApachePublisher < Publisher
  def initialize(source_dir, dest_dir, base_url)
    super(source_dir, dest_dir, ApachePaths.new(base_url))
  end

  class ApachePaths
    def initialize(base_url)
      @base_url = base_url
    end

    def css(basename)
      "#{@base_url}/css/#{basename}.css"
    end

    def fragments
      "#{@base_url}/fragments/"
    end

    def fragment(fragment_name)
      "#{@base_url}/#{fragment_name}"
    end
  end

  def fragment_names
    names_in "published/fragments"
  end

  def mosaic_names
    names_in "published/mosaics"
  end

  def fragment_time(fragment_name)
    DateTime.parse(IO.read("published/fragments/#{fragment_name}"))
  end
end
