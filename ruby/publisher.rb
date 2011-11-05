require 'fragment_writer'

class Publisher
  def initialize(source_root, dest_root, paths)
    @source_root = source_root
    @fragment_dest = "#{dest_root}/fragments"
    @writer = FragmentWriter.new(paths)
  end

  def publish
    fragment_names.map { |fragment| publish_fragment(fragment) }
  end

  def fragment_names_in(directory)
    Dir.entries("#{@source_root}/#{directory}").reject { |filename| filename[0] == ?. }
  end

  def publish_fragment(filename)
    File.open("#{@source_root}/fragments/#{filename}") do |contents|
      write_contents(filename, contents.read)
    end
  end

  def write_contents(filename, contents)
    html = @writer.write(contents)
    File.open("#{@fragment_dest}/#{filename}.html", "w") do |output|
      output.write(html)
    end
  end
end
