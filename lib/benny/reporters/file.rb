# frozen_string_literal: true

require 'json'

module Benny
  module Reporters
    class File
      def initialize(path:, env_name:)
        @path = path
        @data = {
          env_name: env_name,
          benchmarks: []
        }

        at_exit { ::File.write(::File.join(@path, "#{Process.pid}.json"), JSON.dump(@data)) }
      end

      def report(benchmark, measure)
        raise ArgumentError, "Measure of type #{measure.class} not supported." unless measure.is_a?(Benchmark::Tms)

        @data[:benchmarks] << {
          type: 'Benchmark::Tms',
          name: benchmark.name,
          utime: measure.utime,
          stime: measure.stime,
          total: measure.total
        }
      end
    end
  end
end
