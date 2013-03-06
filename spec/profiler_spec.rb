require 'spec_helper'

describe 'Profiler' do

  context 'Without profiler' do

    it 'Model behavior' do
      user = User.john_doe
      user.first_name.should eq 'John'
      user.last_name.should eq 'Doe'
      user.full_name.should eq 'John Doe'
    end

    it 'Model methods' do
      User.methods(false).should eq [:john_doe]
      User.instance_methods(false).should eq [:first_name, :last_name, :full_name]
      User.private_instance_methods(false).should eq [:initialize, :concatenate]
    end

  end

  context 'With profiler' do

    it 'Model behavior' do
      ProfileTracker::Profiler.new { watch User }

      User.should_receive(:john_doe_without_profiler).and_call_original

      user = User.john_doe

      user.should_receive(:first_name_without_profiler).exactly(2).and_call_original
      user.should_receive(:last_name_without_profiler).exactly(2).and_call_original
      user.should_receive(:full_name_without_profiler).once.and_call_original
      user.should_receive(:concatenate_without_profiler).once.and_call_original

      user.first_name.should eq 'John'
      user.last_name.should eq 'Doe'
      user.full_name.should eq 'John Doe'
    end

    it 'Model methods' do
      ProfileTracker::Profiler.new { watch User }

      User.methods(false).should eq [:john_doe]
      User.instance_methods(false).should eq [:first_name, :last_name, :full_name]

      User.methods(false).map { |m| "#{m}_without_profiler".to_sym }.each do |method|
        User.private_methods(false).should include method
      end

      User.instance_methods(false).map { |m| "#{m}_without_profiler".to_sym }.each do |method|
        User.private_instance_methods(false).should include method
      end
    end

    it 'Model explicit methods' do
      ProfileTracker::Profiler.new { watch User }
    end

  end

  context 'Tracking' do



  end

end