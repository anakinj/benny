# frozen_string_literal: true

require 'gruff'

module Benny
  module Reporters
    class Gruff
      def report(metrics) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        g = ::Gruff::SideBar.new(800)
        g.title = 'Benchmark results'
        result = {}
        labels = {}

        metrics.each.with_index do |metric, i|
          labels[i] = metric[:env_name]
          metric[:benchmarks].each do |bm|
            result[bm[:name]] ||= []
            result[bm[:name]] << bm[:total]
          end
        end

        g.labels = labels
        result.each { |k, v| g.data(k, v) }

        g.write('result.png')
      end
    end
  end
end
