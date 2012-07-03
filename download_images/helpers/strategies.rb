module DownloadImages
  module Helpers
    module Strategies

      private

      def filename url
        hsh = Zlib.crc32(url.to_s, 0)
        image_name = url.path.split('/').last.split('.')
        "#{image_name[0..-2].join('.')}_#{hsh}.#{image_name.last}"
      end
    end
  end
end
