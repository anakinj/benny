# frozen_string_literal: true

require 'benchmark/memory'

module Benny
  module Executors
    class BenchmarkMemory
      attr_reader :benchmarks

      def initialize(benchmarks)
        @benchmarks = benchmarks.select { |b| b.type.include?(:memory) }
      end

      def run!
        benchmarks.each do |benchmark|
          run_one(benchmark)
        end
      end

      def run_one(benchmark)
        ::Benchmark.memory do |x|
          x.report do
            benchmark.block.call
          end
        end
      end

      def self.run!(*args)
        new(*args).run!
      end
    end
  end
end
