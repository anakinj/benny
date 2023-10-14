# frozen_string_literal: true

module Benny
  module DSL
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

    class BenchmarkEntry
      attr_reader :name, :block, :type

      def initialize(name, options, &block)
        @name = name
        @block = block
        @type = options[:type] || [:time]
      end
    end

    def environment(name, &block)
      @environments ||= []
      @environments << EnvironmentEntry.new(name, &block)
    end

    def benchmark(name, options = {}, &block)
      @benchmarks ||= []
      @benchmarks << BenchmarkEntry.new(name, options, &block)
    end

    def bennies_path(path = nil)
      @bennies_path = path unless path.nil?
      @bennies_path || 'benchmarks/**/*_bench.rb'
    end

    def load(path)
      instance_eval(File.read(path), path, 1)
    end

    def load_bennies(path)
      Dir[path].each do |file|
        load(file)
      end
    end

    def setup(&block)
      instance_exec(&block)
      load_bennies(bennies_path)
    end

    attr_reader :environments, :benchmarks
  end
end
