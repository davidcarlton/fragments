require 'publisher'

class LocalPublisher < Publisher
  def initialize(source_dir, dest_dir)
    super(source_dir, dest_dir, LocalPaths.new)
  end

  class LocalPaths
    def css(basename)
      "../css/#{basename}.css"
    end

    def js(basename)
      "../js/#{basename}.js"
    end

    def directory_name(collection)
      "../#{collection}/"
    end

    def item_name(collection, item)
      "../#{collection}/#{item}"
    end

    def feed(feed_name)
      "../feeds/#{feed_name}.xml"
    end
  end

  def fragment_names
    names_in "fragments"
  end

  def mosaic_names
    names_in "mosaics"
  end

  def publication_time(item_location)
    File.new("#{source_root}/#{item_location}").mtime
  end
end
