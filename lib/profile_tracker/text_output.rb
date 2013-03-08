module ProfileTracker
  class TextOutput

    def self.traces
      Hirb::Helpers::AutoTable.render Profiler.instance.traces,
                                      {
                                          fields: [:klass, :method, :scope, :elapsed_time, :timestamp, :args],
                                          headers: {klass: 'Class', elapsed_time: 'Time (ms)'},
                                          header_filter: :capitalize,
                                          unicode: true
                                      }
    end

    def self.summary
      Hirb::Helpers::AutoTable.render Profiler.instance.summary,
                                      {
                                          fields: [:klass, :method, :scope, :elapsed_time, :calls],
                                          headers: {klass: 'Class', elapsed_time: 'Time (ms)'},
                                          header_filter: :capitalize,
                                          unicode: true
                                      }
    end

    def self.tree

    end

  end
end