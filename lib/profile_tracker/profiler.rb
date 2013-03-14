module ProfileTracker
  class Profiler

    include Singleton

    def watch(klass, method_selector, *methods)
      klass.send :extend, ProfileTracker::Watcher unless watched? klass
      klass.send "watch_#{method_selector}", *methods
    end

    def notify(trace)
      traces << trace
    end

    def clean
      @traces = []
    end

    def traces
      @traces ||= []
    end

    def root_traces
      traces.select { |t| t.parent.nil? }
    end

    def summary
      summary = traces.inject({}) do |hash, trace|
        key = "#{trace.klass}|#{trace.method}|#{trace.scope}"
        if hash.has_key? key
          hash[key][:elapsed_time] += trace.elapsed_time
          hash[key][:calls] += 1
        else
          hash[key] = {
              klass: trace.klass,
              method: trace.method,
              scope: trace.scope,
              elapsed_time: trace.elapsed_time,
              calls: 1
          }
        end
        hash
      end

      summary.values.sort_by { |t| -t[:elapsed_time] }
    end

    private

    def watched?(klass)
      (class << klass; self end).included_modules.include? ProfileTracker::Watcher
    end

  end
end