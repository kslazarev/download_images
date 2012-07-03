module DownloadImages
  module Strategies
    extend DownloadImages::Helpers::Strategies

    RETRIEVE_IMAGES = Proc.new do |url|
      begin
        Logger.retrieve filename(url)
        {:filename => filename(url), :content => Net::HTTP.get(url)}
      rescue
        Logger.warning filename(url)
      end
    end
  end
end