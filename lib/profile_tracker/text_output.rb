module ProfileTracker
  class TextOutput

    def self.plain
      report = TextReport.new

      report.table do |t|
        t.column 'Class', 20
        t.column 'Method', 30
        t.column 'Type', 10
        t.column 'Time (ms)', 10

        Profiler.instance.traces.each do |trace|
          t.row trace.object.is_a?(Class) ? trace.object.to_s : trace.object.class.to_s,
                trace.method,
                trace.object.is_a?(Class) ? 'class' : 'instance',
                (trace.elapsed_time * 1000.0).round(3).to_s
        end
      end

      report.to_s
    end

  end
end