module ProfileTracker
  module Watcher

    def watched_instance_methods
      @watched_instance_methods ||= []
    end

    def watch_instance_method(method)
      return if watched_instance_methods.include? method

      module_eval do
        visibility =
            if private_instance_methods(false).include? method
              :private
            elsif private_instance_methods(false).include? method
              :protected
            else
              :public
            end

        alias_method "__#{method}_watched__", method

        define_method method do |*args, &block|
          trace = Trace.new(self, method, *args)
          Profiler.instance.notify trace
          trace.call { send "__#{method}_watched__", *args, &block }
        end

        private method if visibility == :private
        protected method if visibility == :protected
        private "__#{method}_watched__"
      end
    end

    def watch_instance_methods(*methods)
      methods.each { |m| watch_instance_method m }
    end

    def watch_all_instance_methods
      watch_instance_methods *(public_instance_methods(false) + private_instance_methods(false) + protected_instance_methods(false) - Watcher.instance_methods(false))
    end

    def watched_class_methods
      @watched_class_methods ||= []
    end

    def watch_class_method(method)
      return if watched_class_methods.include? method

      singleton_class.module_eval do
        visibility =
            if private_methods(false).any? { |m| m == method }
              :private
            elsif protected_methods(false).any? { |m| m == method }
              :protected
            else
              :public
            end

        alias_method "__#{method}_watched__", method

        define_method method do |*args, &block|
          trace = Trace.new(self, method, *args)
          Profiler.instance.notify trace
          trace.call { send "__#{method}_watched__", *args, &block }
        end

        private method if visibility == :private
        protected method if visibility == :protected
        private "__#{method}_watched__"
      end
    end

    def watch_class_methods(*methods)
      methods.each { |m| watch_class_method m }
    end

    def watch_all_class_methods
      watch_class_methods *(public_methods(false) + private_methods(false) + protected_methods(false) - Watcher.instance_methods(false))
    end

    def watch_all_methods
      watch_all_instance_methods
      watch_all_class_methods
    end

  end
end
