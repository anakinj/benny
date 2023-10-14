# frozen_string_literal: true

require 'benchmark'

module Benny
  module Executors
    class BenchmarkTime
      attr_reader :benchmarks

      def initialize(benchmarks)
        @benchmarks = benchmarks.select { |b| b.type.include?(:time) }
      end

      def run!
        benchmarks.each do |benchmark|
          run_one(benchmark)
        end
      end

      def run_one(benchmark)
        measure = ::Benchmark.measure do
          benchmark.block.call
        end
        puts "#{benchmark.name}: #{measure}"
      end

      def self.run!(*args)
        new(*args).run!
      end
    end
  end
end
