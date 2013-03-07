module ProfileTracker
  class Profiler

    include Singleton

    def watch(klass, method_selector, *methods)
      klass.send :extend, ProfileTracker::Watcher unless (class << klass; self end).included_modules.include? ProfileTracker::Watcher
      klass.send "watch_#{method_selector}", *methods
    end

    def traces
      @traces ||= []
    end

    def root_traces
      traces.select { |t| t.parent.nil? }
    end

    def notify(trace)
      traces << trace
    end

  end
end