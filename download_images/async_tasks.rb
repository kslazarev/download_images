module DownloadImages
  class AsyncTasks < Array
    attr_reader :results

    def initialize strategy
      @threads, @results = [], []
      @strategy = strategy
    end

    def << obj
      super obj
      @threads << Thread.new(obj) { |url| Thread.current[:result] = @strategy.call(url) }
    end

    def synchronize
      yield
      @threads.map! { |thread| thread.join; thread[:result] }.reject(&:nil?)
    end
  end
end