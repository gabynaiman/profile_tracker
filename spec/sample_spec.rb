require 'spec_helper'

describe 'Sample' do

  it 'test' do

    ProfileTracker.profiler.watch User, :all_methods

    user = User.john_doe
    user.full_name

    puts ProfileTracker::TextOutput.traces
    puts ProfileTracker::TextOutput.summary
    puts ProfileTracker::TextOutput.tree
  end

end