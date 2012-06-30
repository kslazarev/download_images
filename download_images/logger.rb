module DownloadImages
  class Logger
    class << self
      def retrieve file
        puts "Retrieve: #{file}\n"
      end

      def warning file
        puts "Warning: #{file}\n"
      end

      def saved count, type
        puts "Saved: #{count} #{type}"
      end
    end
  end
end