require 'fragment_writer'
require 'mosaic_writer'
require 'mosaic'

class Publisher
  def initialize(source_root, dest_root, paths)
    @source_root = source_root
    @dest_root = dest_root
    @fragment_writer = FragmentWriter.new(paths)
    @mosaic_writer = MosaicWriter.new(paths, fragments_map)
  end

  def publish
    fragment_names.map { |fragment| publish_fragment(fragment) }
    mosaic_names.map { |mosaic| publish_mosaic(mosaic) }
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
    html = @fragment_writer.write(fragment_text(fragment_name))
    File.open("#{@dest_root}/fragments/#{fragment_name}.html", "w") do |output|
      output.write(html)
    end
  end

  def mosaic(mosaic_name)
    Mosaic.new(IO.readlines("#{@source_root}/mosaics/#{mosaic_name}"))
  end

  def publish_mosaic(mosaic_name)
    html = @mosaic_writer.write(mosaic(mosaic_name))
    File.open("#{@dest_root}/mosaics/#{mosaic_name}.html", "w") do |output|
      output.write(html)
    end
  end
end
