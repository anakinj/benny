# frozen_string_literal: true

require 'shellwords'
require 'tmpdir'

module Benny
  module Executors
    class Environment
      attr_reader :environments, :reporter

      def initialize(environments:, reporter:)
        @environments = environments
        @reporter     = reporter
      end

      def run!
        Output.puts("Running benchmark for #{environments.size} environments. Reporter: #{reporter.class.name}")

        Dir.mktmpdir('benny') do |dir|
          environments.each do |e|
            run_one(e, dir)
          end
          report(dir)
        end
      end

      def run_one(environment, dir)
        Bundler.with_original_env do
          ENV['BUNDLE_GEMFILE'] = environment.gemfile
          Output.puts('Installing dependencies...')
          Kernel.system(Shellwords.join(%w[bundle install]))
          Output.puts("Executing benchmark for '#{environment.name}'..")
          Kernel.system(Shellwords.join(['bundle', 'exec', 'benny', 'execute',
                                         '--result-path', dir,
                                         '--env-name', environment.name]))
        end
      end

      def report(dir)
        Output.puts('Generating report...')
        metrics = Dir.glob(File.join(dir, '*.json')).map { |file| JSON.parse(File.read(file), symbolize_names: true) }
        reporter.report(metrics)
      end

      def self.run!(*args)
        new(*args).run!
      end
    end
  end
end
