# frozen_string_literal: true

require 'benchmark'

module Benny
  module Executors
    class Benchmark
      attr_reader :benchmarks, :reporter

      def initialize(benchmarks:, reporter:)
        @benchmarks = benchmarks
        @reporter   = reporter
      end

      def execute
        benchmarks.each do |benchmark|
          execute_one(benchmark)
        end
      end

      def execute_one(benchmark)
        benchmark.definition.before_blocks.each(&:call)

        benchmark.definition.warmup_options.iterations.times do
          benchmark.block.call
        end

        measure = ::Benchmark.measure do
          benchmark.block.call
        end

        reporter.report(benchmark, measure)
      end

      def self.execute(benchmarks:, reporter:)
        new(benchmarks: benchmarks, reporter: reporter).execute
      end
    end
  end
end
