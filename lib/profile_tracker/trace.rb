module ProfileTracker
  class Trace

    @@stack = []

    attr_reader :object
    attr_reader :method
    attr_reader :args
    attr_reader :timestamp
    attr_reader :elapsed_time
    attr_reader :parent
    attr_accessor :traces

    def initialize(object, method, *args)
      @object = object
      @method = method
      @args = args
      @parent = nil
      @traces = []
    end

    def klass
      object.is_a?(Class) | object.is_a?(Module) ? object : object.class
    end

    def scope
      object.is_a?(Class) | object.is_a?(Module) ? object.class.to_s.downcase : 'instance'
    end

    def elapsed_time_to_ms
      (elapsed_time * 1000.0).round(3)
    end

    def call(*args, &block)
      if @@stack.last
        @@stack.last.traces << self
        @parent = @@stack.last
      end
      @@stack.push self

      start = Time.now.to_f

      exception = nil
      begin
        @timestamp = Time.now
        result = block.call(*args)
      rescue Exception => ex
        exception = ex
      end

      @elapsed_time = ((Time.now.to_f - start) * 1000.0).round(3)

      @@stack.pop

      if exception
        raise exception
      else
        result
      end
    end

  end
end