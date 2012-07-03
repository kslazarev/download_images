require 'net/http'
require 'uri'
require 'yaml'
require 'thread'
require 'zlib'

require './download_images/logger'
require './download_images/async_tasks'
require './download_images/helpers'
require './download_images/strategies'
require './download_images/html_parser'

module DownloadImages
  extend self

  def init url
    results = save_to_files(load_images(url))
    Logger.saved results.count, :images
  end

  def load_images url
    tasks = AsyncTasks.new(Strategies::RETRIEVE_IMAGES)

    tasks.synchronize do
      HtmlParser.new(url).images_links { |link| tasks << link unless tasks.include?(link) }
    end
  end

  def save_to_files images
    images.each do |image|
      File.open("pictures/#{image[:filename]}", 'w+') { |f| f.write image[:content] }
    end
  end
end

DownloadImages.init ARGV.first