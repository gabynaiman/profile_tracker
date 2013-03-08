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
      Hirb::Helpers::Tree.render tree_nodes(Profiler.instance.root_traces), type: :directory
    end

    private

    def self.tree_nodes(traces, level=0)
      traces.inject([]) do |list, t|
        list << {value: "#{t.klass}.#{t.method} (#{t.scope})".ljust(80-level*4) + "#{t.elapsed_time_to_ms}ms", level: level}
        list += tree_nodes(t.traces, level + 1) unless t.traces.empty?
        list
      end
    end

  end
end