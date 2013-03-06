module ProfileTracker
  class Profiler

    attr_reader :tracking

    def initialize(&block)
      @tracking = []

      if block_given?
        if block.arity == 0
          instance_eval(&block)
        else
          block.call(self)
        end
      end
    end

    def watch(klass, options={})
      profiler = self

      klass.singleton_class.module_eval do
        klass.methods(false).each do |method|
          alias_method "#{method}_without_profiler", method

          define_method method do |*args, &block|
            profiler.send(:track, klass, method, :singleton) { send("#{method}_without_profiler", *args, &block) }
          end

          private "#{method}_without_profiler"
        end
      end

      klass.module_eval do
        klass.instance_methods(false).each do |method|
          alias_method "#{method}_without_profiler", method

          define_method method do |*args, &block|
            profiler.send(:track, klass, method, :instance) { send("#{method}_without_profiler", *args, &block) }
          end

          private "#{method}_without_profiler"
        end
      end

      klass.module_eval do
        klass.private_instance_methods(false).each do |method|
          alias_method "#{method}_without_profiler", method

          define_method method do |*args, &block|
            profiler.send(:track, klass, method, :private_instance) { send("#{method}_without_profiler", *args, &block) }
          end

          private method
          private "#{method}_without_profiler"
        end
      end
    end

    private

    def track(klass, method, type, &block)
      start = Time.now
      result = yield
      elapsed = Time.now - start

      @tracking << {
          class: klass,
          method: method,
          type: type,
          elapsed: elapsed
      }

      result
    end

  end
end