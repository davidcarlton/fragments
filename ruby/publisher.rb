require 'feed_writer'
require 'fragment_writer'
require 'index_writer'
require 'mosaic_writer'
require 'mosaic'

class Publisher
  def initialize(source_root, dest_root, paths)
    @source_root = source_root
    @dest_root = dest_root
    @paths = paths
    @fragment_writer = FragmentWriter.new(paths)
    @mosaic_writer = MosaicWriter.new(paths, fragments_map)
  end

  attr_reader :source_root

  def publish
    fragment_names.map { |fragment| publish_fragment(fragment) }
    mosaic_names.map { |mosaic| publish_mosaic(mosaic) }
    publish_fragments_feed
    publish_mosaics_feed
    publish_index
  end

  def fragments_map
    map = {}
    fragment_names.map { |fragment| map[fragment] = fragment_text(fragment) }
    map
  end

  def names_in(directory)
    Dir.entries("#{@source_root}/#{directory}").reject { |filename| filename[0] == ?. }
  end

  def fragment_text(fragment_name)
    IO.read("#{@source_root}/fragments/#{fragment_name}")
  end

  def publish_fragment(fragment_name)
    publish_to("fragments/#{fragment_name}.html",
      @fragment_writer.write(fragment_text(fragment_name)))
  end

  def mosaic(mosaic_name)
    Mosaic.new(IO.readlines("#{@source_root}/mosaics/#{mosaic_name}"))
  end

  def publish_mosaic(mosaic_name)
    publish_to("mosaics/#{mosaic_name}.html", @mosaic_writer.write(mosaic(mosaic_name)))
  end

  def publish_fragments_feed
    feed_writer = FeedWriter.new("fragments", @paths)
    fragment_names.each do |fragment_name|
      feed_writer.add(fragment_name,
        @fragment_writer.body(fragment_text(fragment_name)),
        publication_time("fragments/#{fragment_name}"))
    end

    publish_to("feeds/fragments.xml", feed_writer.write)
  end

  def publish_mosaics_feed
    feed_writer = FeedWriter.new("mosaics", @paths)
    mosaic_names.each do |mosaic_name|
      feed_writer.add(mosaic_name,
        @mosaic_writer.body(mosaic(mosaic_name)),
        publication_time("mosaics/#{mosaic_name}"))
    end

    publish_to("feeds/mosaics.xml", feed_writer.write)
  end

  def publish_index
    index_writer = IndexWriter.new(@paths)
    fragment_names.each do |fragment_name|
      index_writer.add(fragment_name,
        @fragment_writer.body(fragment_text(fragment_name)),
        publication_time("fragments/#{fragment_name}"))
    end

    publish_to("index.html", index_writer.write)
  end

  def publish_to(location, contents)
    File.open("#{@dest_root}/#{location}", "w") do |output|
      output.write(contents)
    end
  end
end
