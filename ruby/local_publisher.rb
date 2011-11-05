require 'publisher'

class LocalPublisher < Publisher
	def initialize(source_dir, dest_dir)
		super(source_dir, dest_dir, LocalPaths.new)
	end

	class LocalPaths
		def css(basename)
			"../css/#{basename}.css"
		end
	end
end
