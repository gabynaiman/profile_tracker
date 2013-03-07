require 'singleton'

require 'profile_tracker/version'
require 'profile_tracker/watcher'
require 'profile_tracker/trace'
require 'profile_tracker/profiler'
require 'profile_tracker/text_output'
require 'profile_tracker/text_report'

module ProfileTracker

  def self.profiler
    Profiler.instance
  end

end


