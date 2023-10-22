# frozen_string_literal: true

require 'terminal-table'

module Benny
  module Reporters
    class Stdout
      def initialize
        @io = $stdout
      end

      def report(metrics)  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        result = {}
        labels = ['']

        metrics.each.with_index do |metric, _i|
          labels << metric[:env_name]
          metric[:benchmarks].each do |bm|
            result[bm[:name]] ||= []
            result[bm[:name]] << bm[:total].round(5)
          end
        end

        rows = result.map do |k, v|
          ([k] + v)
        end

        puts Terminal::Table.new(headings: labels, rows: rows)
      end
    end
  end
end
