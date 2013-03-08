module ProfileTracker
  class TextOutput

    def self.traces
      Hirb::Helpers::AutoTable.render Profiler.instance.traces,
                                      {
                                          fields: [:klass, :method, :scope, :elapsed_time_to_ms, :timestamp, :args],
                                          headers: {klass: 'Class', elapsed_time_to_ms: 'Time (ms)'},
                                          header_filter: :capitalize,
                                          unicode: true
                                      }
    end

    def self.summary
      Hirb::Helpers::AutoTable.render Profiler.instance.summary,
                                      {
                                          fields: [:klass, :method, :scope, :elapsed_time_to_ms, :calls, :average_to_ms, :max_to_ms, :min_to_ms],
                                          headers: {klass: 'Class', elapsed_time_to_ms: 'Time (ms)', average_to_ms: 'Average (ms)', max_to_ms: 'Max (ms)', min_to_ms: 'Min (ms)'},
                                          header_filter: :capitalize,
                                          unicode: true
                                      }
    end

    def self.tree

    end

  end
end