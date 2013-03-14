module ProfileTracker
  class TraceSummary

    attr_reader :klass
    attr_reader :method
    attr_reader :scope
    attr_reader :elapsed_time
    attr_reader :calls
    attr_reader :max
    attr_reader :min

    def initialize(klass, method, scope)
      @klass = klass
      @method = method
      @scope = scope
      @elapsed_time = 0
      @calls = 0
      @max = nil
      @min = nil
    end

    def add_call(elapsed_time)
      @calls += 1
      @elapsed_time += elapsed_time
      @max = @max ? [@max, elapsed_time].max : elapsed_time
      @min = @min ? [@min, elapsed_time].min : elapsed_time
    end

    def elapsed_time_to_ms
      to_ms @elapsed_time
    end

    def average
      @elapsed_time.to_f / @calls
    end

    def average_to_ms
      to_ms average
    end

    def max_to_ms
      to_ms @max
    end

    def min_to_ms
      to_ms @min
    end

    def self.build(trace)
      summary = new trace.klass, trace.method, trace.scope
      summary.add_call trace.elapsed_time
      summary
    end

    private

    def to_ms(seconds)
      (seconds * 1000.0).round(3)
    end

  end
end