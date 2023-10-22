# frozen_string_literal: true

Benny.configure do |config|
  config.environment 'Oj - latest' do
    gemfile 'gemfiles/latest.gemfile'
  end

  config.environment 'Oj - 3.7.0' do
    gemfile 'gemfiles/3_7_0.gemfile'
  end

  config.environment 'Oj - 3.3.0' do
    gemfile 'gemfiles/3_3_0.gemfile'
  end
end
