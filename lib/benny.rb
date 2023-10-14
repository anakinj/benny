# frozen_string_literal: true

require_relative 'benny/dsl'
require_relative 'benny/cli'
require_relative 'benny/executors/benchmark_time'
require_relative 'benny/executors/benchmark_memory'
require_relative 'benny/executors/environment'
require_relative 'benny/version'

module Benny
  extend DSL

  def self.init
    load('Bennyfile')
  end
end
