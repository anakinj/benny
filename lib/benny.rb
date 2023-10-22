# frozen_string_literal: true

require_relative 'benny/dsl'
require_relative 'benny/cli'
require_relative 'benny/output'
require_relative 'benny/configuration'
require_relative 'benny/executors/benchmark'
require_relative 'benny/executors/environment'
require_relative 'benny/reporters/stdout'
require_relative 'benny/reporters/gruff'
require_relative 'benny/reporters/file'
require_relative 'benny/version'

module Benny
  extend DSL

  def self.load_env
    load('benchmarks/bench_helper.rb')
    load_benchmarks(configuration.benchmark_path)
    Output.puts("Loaded #{benchmarks.size} benchmark(s)")
  end

  def self.execute
    Executors::Environment.new(environments: configuration.environments,
                               reporter: configuration.reporter).run!
  end

  def self.load_benchmarks(path)
    Dir[path].each do |file|
      load(file)
    end
  end
end
