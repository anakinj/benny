# frozen_string_literal: true

module Benny
  module DSL
    class Definition
      class WarmupOptions
        attr_reader :iterations

        def initialize(iterations:)
          @iterations = iterations
        end
      end

      class BenchmarkEntry
        attr_reader :name, :block, :definition

        def initialize(definition, name, &block)
          @name = name
          @block = block
          @definition = definition
        end
      end

      attr_reader :benchmarks, :before_blocks, :warmup_options

      def initialize(&block)
        @before_blocks = []
        @benchmarks    = []
        @warmup_options = WarmupOptions.new(iterations: 1)
        instance_eval(&block)
      end

      def warmup(iterations:)
        @warmup_options = WarmupOptions.new(iterations: iterations)
      end

      def before(&block)
        @before_blocks << block
      end

      def benchmark(name, &block)
        @benchmarks << BenchmarkEntry.new(self, name, &block)
      end
    end

    def define(&block)
      @definitions ||= []
      @definitions << Definition.new(&block)
    end

    def benchmarks
      definitions.flat_map(&:benchmarks)
    end

    def load(path)
      instance_eval(File.read(path), path, 1)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    attr_reader :environments, :definitions
  end
end
