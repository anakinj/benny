# frozen_string_literal: true

require 'bundler/setup'
require 'thor'

module Benny
  class CLI < Thor
    def self.exit_on_failure?
      true
    end
    default_task :all

    desc 'init NAME', 'Create a new benny project'
    def init(name)
      require_relative 'init'
      Init.create(name)
    end

    desc 'all', 'Run all bechmarks in all environments'
    def all
      require 'benny'
      Benny.load_env
      Benny.execute
    end

    desc 'execute', 'Execute a set of benchmarks'
    method_options 'result-path' => :string
    method_options 'env-name' => :string
    def execute
      require 'benny'
      Benny.load_env
      Executors::Benchmark.execute(benchmarks: Benny.benchmarks,
                                   reporter: Reporters::File.new(env_name: options['env-name'],
                                                                 path: options['result-path']))
    end
  end
end
