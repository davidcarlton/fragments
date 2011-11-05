require 'fragment_writer'

class LocalPublisher
	def initialize(source_dir, dest_dir)
		@fragment_source = "#{source_dir}/fragments"
		@fragment_dest = "#{dest_dir}/fragments"
		@writer = FragmentWriter.new
	end

	def publish
		fragment_names.map { |fragment| publish_fragment(fragment) }
	end

	def fragment_names
		Dir.entries("#{@fragment_source}").reject { |filename| filename[0] == ?. }
	end

	def publish_fragment(filename)
		File.open("#{@fragment_source}/#{filename}") do |contents|
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
