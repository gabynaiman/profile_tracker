require 'singleton'
require 'hirb'

require 'profile_tracker/version'
require 'profile_tracker/watcher'
require 'profile_tracker/trace'
require 'profile_tracker/profiler'
require 'profile_tracker/text_output'

module ProfileTracker

  def self.profiler(&block)
    if block_given?
      if block.arity == 0
        Profiler.instance.instance_eval &block
      else
        block.call(Profiler.instance)
      end
    else
      Profiler.instance
    end
  end

end


