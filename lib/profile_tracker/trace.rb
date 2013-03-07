module ProfileTracker
  class Trace

    @@stack = []

    attr_reader :object
    attr_reader :method
    attr_reader :args
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

    def call(*args, &block)
      if @@stack.last
        @@stack.last.traces << self
        @parent = @@stack.last
      end
      @@stack.push self

      start = Time.now.to_f
      result = block.call(*args)
      @elapsed_time = Time.now.to_f - start

      @@stack.pop

      result
    end

  end
end