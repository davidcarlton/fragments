require 'publisher'

class LocalPublisher < Publisher
  def initialize(source_dir, dest_dir)
    super(source_dir, dest_dir, LocalPaths.new)
  end

  class LocalPaths
    def css(basename)
      "../css/#{basename}.css"
    end

    def fragments
      "../fragments/"
    end

    def fragment(fragment_name)
      "../fragments/#{fragment_name}"
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

  def fragment_time(fragment_name)
    File.new("fragments/#{fragment_name}").mtime
  end
end
