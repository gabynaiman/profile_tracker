require 'profile_tracker'

Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].each { |f| require f }

RSpec::Matchers.define :track do |expected|
  match do |actual|
    actual.detect do |t|
      expected.keys.inject(true) do |bool, k|
        bool &&= t[k] == expected[k]
      end
    end
  end

  failure_message_for_should do |actual|
    "expected: #{actual}\ncontains: #{expected}"
  end
end