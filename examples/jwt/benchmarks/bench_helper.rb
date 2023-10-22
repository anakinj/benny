# frozen_string_literal: true

Benny.configure do |config|
  config.environment 'jwt - 3.0 (WIP)' do
    gemfile 'gemfiles/3_0.gemfile'
  end
  config.environment 'jwt - latest' do
    gemfile 'gemfiles/latest.gemfile'
  end
  config.environment 'jwt - 2.7' do
    gemfile 'gemfiles/2_7.gemfile'
  end
end
