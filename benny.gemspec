# frozen_string_literal: true

require_relative 'lib/benny/version'

Gem::Specification.new do |spec|
  spec.name = 'benny'
  spec.version = Benny::VERSION
  spec.authors = ['Joakim Antman']
  spec.email = ['antmanj@gmail.com']

  spec.summary = 'Benny the benchmark gem'
  spec.description = 'Helps you maintain your benchmarks and execute on different variations of environments'
  spec.homepage = 'https://github.com/anakinj/benny'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/anakinj/benny'
  spec.metadata['changelog_uri'] = 'https://github.com/anakinj/benny/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'benchmark-memory'
  spec.add_dependency 'shellwords'
  spec.add_dependency 'thor'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
