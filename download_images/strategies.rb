module DownloadImages
  module Strategies
    RETRIEVE_IMAGES = Proc.new do |url|
      filename = url.path.split('/').last

      begin
        Logger.retrieve filename
        {:filename => filename, :content => Net::HTTP.get(url)}
      rescue
        Logger.warning filename
      end
    end
  end
end