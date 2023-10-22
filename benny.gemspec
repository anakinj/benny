# frozen_string_literal: true

require_relative 'lib/benny/version'

Gem::Specification.new do |spec|
  spec.name = 'benny'
  spec.version = Benny::VERSION
  spec.authors = ['Joakim Antman']
  spec.email = ['antmanj@gmail.com']

  spec.summary = 'Benny the benchmark gem'
  spec.description = 'Define and maintain your benchmarks in a familiarway.' \
                     'Execute on different variations of environments'
  spec.homepage = 'https://github.com/anakinj/benny'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/anakinj/benny'
  spec.metadata['changelog_uri'] = 'https://github.com/anakinj/benny/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").select do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[exe/ lib/ README benny.gemspec LICENSE])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'gruff', '~> 0.23'
  spec.add_dependency 'terminal-table', '~> 3.0'
  spec.add_dependency 'thor', '~> 1.3'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
