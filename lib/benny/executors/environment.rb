# frozen_string_literal: true

require 'shellwords'

module Benny
  module Executors
    class Environment
      attr_reader :environments

      def initialize(environments)
        @environments = environments
      end

      def run!
        environments.each do |e|
          run_one(e)
        end
      end

      def run_one(environment)
        Bundler.with_original_env do
          ENV['BUNDLE_GEMFILE'] = environment.gemfile
          puts "Environment '#{environment.name}'"
          Kernel.system('bundle exec benny execute --type time')
        end
      end

      def self.run!(*args)
        new(*args).run!
      end
    end
  end
end
