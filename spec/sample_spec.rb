require 'spec_helper'

describe 'Sample' do

  it 'test' do

    ProfileTracker.profiler.watch User, :all_methods

    user = User.john_doe
    user.full_name

    puts ProfileTracker::TextOutput.summary
  end

  it 'test module' do

    ProfileTracker.profiler.watch Helper, :all_methods

    Helper.module_method

    puts ProfileTracker::TextOutput.traces

  end


end