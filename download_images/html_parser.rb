module DownloadImages
  class HtmlParser
    SEPARATORS = %w(" ' \()

    attr_reader :uri, :images_formats

    def initialize url
      @uri = URI.parse(url)
      @images_formats = YAML.load_file('formats.yaml')['images']
    end

    def images_links
      source.scan(link_regexp) { |link| yield host_with(link) }
    end

    private

    def source
      Net::HTTP.get uri
    end

    def link_regexp
       /[^#{SEPARATORS.join}]+\.(?>#{images_formats.join '|'})/
    end

    def host_with link
      uri.merge link
    end
  end
end