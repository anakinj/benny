# frozen_string_literal: true

module Benny
  class Configuration
    attr_reader :environments

    class EnvironmentEntry
      attr_reader :name

      def initialize(name, &block)
        @name = name
        instance_exec(&block)
      end

      def gemfile(path = nil)
        @gemfile = path unless path.nil?
        @gemfile
      end
    end

    def environment(name, &block)
      @environments ||= []
      @environments << EnvironmentEntry.new(name, &block)
    end

    def reporter(reporter = nil)
      @reporter = reporter
      @reporter || Reporters::Stdout.new
    end

    def benchmark_path(path = nil)
      @benchmark_path = path unless path.nil?
      @benchmark_path || 'benchmarks/**/*_bench.rb'
    end
  end
end
