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

    def js(basename)
      "#{@base_url}/js/#{basename}.js"
    end

    def directory_name(collection)
      "#{@base_url}/#{collection}/"
    end

    def item_path(collection, item)
      if (collection == "fragments")
        "#{@base_url}/#{item}"
      else
        "#{@base_url}/#{collection}/#{item}"
      end
    end

    def feed(feed_name)
      "#{@base_url}/#{feed_name}.xml"
    end
  end

  def fragment_names
    names_in "published/fragments"
  end

  def mosaic_names
    names_in "published/mosaics"
  end

  def publication_time(item_location)
    DateTime.parse(IO.read("#{source_root}/published/#{item_location}"))
  end
end
