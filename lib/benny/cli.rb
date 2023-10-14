# frozen_string_literal: true

require 'bundler/setup'
require 'thor'

module Benny
  class CLI < Thor
    default_task :all

    desc 'all', 'Execute all bechmarks in all environments'
    def all
      Benny.init
      Executors::Environment.run!(Benny.environments)
    end

    desc 'execute', 'Execute a set of benchmarks'
    option :type, type: :array, required: true
    def execute
      Benny.init
      options['type'].each do |type|
        case type
        when 'time'
          Executors::BenchmarkTime.run!(Benny.benchmarks)
        when 'memory'
          Executors::BenchmarkMemory.run!(Benny.benchmarks)
        end
      end
    end
  end
end
