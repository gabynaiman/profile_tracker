module ProfileTracker
  class TraceSummary

    attr_reader :klass
    attr_reader :method
    attr_reader :scope
    attr_reader :elapsed_time
    attr_reader :calls

    def initialize(klass, method, scope)
      @klass = klass
      @method = method
      @scope = scope
      @elapsed_time = 0
      @calls = 0
    end

    def add_call(elapsed_time)
      @calls += 1
      @elapsed_time += elapsed_time
    end

    def average
      @elapsed_time.to_f / @calls
    end

    def average_to_ms
      (average * 1000.0).round(3)
    end

    def elapsed_time_to_ms
      (@elapsed_time * 1000.0).round(3)
    end

    def self.build(trace)
      summary = new trace.klass, trace.method, trace.scope
      summary.add_call trace.elapsed_time
      summary
    end

  end
end