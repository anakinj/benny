# frozen_string_literal: true

Benny.configure do |config|
  config.environment 'latest' do
    gemfile 'gemfiles/latest.gemfile'
  end
end
