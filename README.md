# Benny, your Ruby benchmarking buddy

[![Gem Version](https://badge.fury.io/rb/benny.svg)](https://badge.fury.io/rb/jwt)
[![Build Status](https://github.com/anakinj/benny/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/anakinj/benny/actions)

This tool was created to answer the question: How does this version of a library compare to another version of the same library?
For a familiar feel for Rubyists, [rspec](https://github.com/rspec/rspec-core) has been as inspiration for how the gem is used.

## Getting started

With the snippet bellow benny will help you scaffold a simple benchmarking project.

```bash
gem install benny
benny init my_benny_project

cd my_benny_project
bundle install
bundle exec benny
```

## Structure of a benchmarking project

```
my_benny_project/
    ├── benchmarks/
    │   ├── bench_helper.rb
    │   └── test_bench.rb
    ├── gemfiles/
    │   ├── version-1.gemfile
    │   └── version-2.gemfile
    └── Gemfile
```

### Gemfile
Dependencies are managed by [bundler](https://github.com/rubygems/rubygems/tree/master/bundler) and therefore a Gemfile is required.

```ruby
source 'https://rubygems.org'

gem 'benny'
```

### benchmarks/bench_helper.rb
Configures the benchmarks and defines the different environments.

A simple configuration configuring two environments to be compared:

```ruby
Benny.configure do |config|
  config.environment 'Version 1' do
    gemfile 'gemfiles/version-1.gemfile'
  end
  config.environment 'Version 2' do
    gemfile 'gemfiles/version-2.gemfile'
  end
end
```

### benchmarks/*_bench.rb files
All the files ending with the suffix `_bench.rb` will be loaded and added to the benchmark suite.


```ruby
Benny.define do
  benchmark 'Simple calculation' do
    sum = 1+1
  end
end
```

### gemfiles/ folder

The gemfile folder contains the different Gemfiles for version variations. These are referenced from the [benchmark/bench_helper.rb](#benchmarksbench_helperrb) file.

## Defining benchmarks

`Benny.define` is used to define benchmark suites.

```ruby
Benny.define do

  warmup iterations: 2

  before do
   # Initialization
  end

  benchmark 'Simple calculation' do
    sum = 1+1
  end

  benchmark 'Complicated calculation' do
    product = 10*4
  end
end
```

### Before block

`before` blocks can be registered to do initialization before benchmarks are executed. There can be multiple before blocks and are called in the order they have been defined.

### Warmup

The `warmup` command can be used to control how many times the benchmark is executed before starting to measure the result. The default iterator count is 1.

## Reporters

A reporter has the responsibility of presenting the benchmark results in different ways.

A reporter be defined via the `Benny.configure` mechanism.

```ruby
Benny.configure do |c|
  c.reporter(::Benny::Reporters::Stdout.new)
end
```

### Benny::Reporters::Stdout (default)

Prints the results in a ascii table to STDOUT.

### Benny::Reporters::Gruff

Generates a graph using the [gruff](https://github.com/topfunky/gruff) gem.
