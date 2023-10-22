# Benny, your Ruby benchmarking buddy

This tool was created to answer the question: How does this version of a library compare to another version of the same library?
For a familiar feel for Rubyists, [rspec](https://github.com/rspec/rspec-core) has been as inspiration for how benchmarks are structured and defined.

## Basic structure of a benchmarking project

A simple benchmark project looks something like this. To generate such a project you can execute:

```bash
gem install benny
benny init my_benny_project
cd my_benny_project
bundle install
bundle exec benny
```

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
Dependencies are managed by [bundler](https://github.com/rubygems/rubygems/tree/master/bundler) and therefore a Gemfile is required

```ruby
source 'https://rubygems.org'

gem 'benny'
```

### benchmarks/ folder
Contains files that define environments and benchmarks.

### benchmarks/bench_helper.rb
Configures the benchmarks and defines the different environments

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
All the files ending with the suffix `_bench.rb` will be evaluated and added to the benchmark suite.


```ruby
Benny.define do
  benchmark 'Simple calculation' do
    700_000.times do
      sum = 1+1
    end
  end
end
```

### gemfiles/ folder

The gemfile folder contains the different Gemfiles for version variations. These are referenced from the [benchmark/bench_helper.rb](#benchmarksbench_helperrb) file.

## Defining benchmarks

TBD

## Reporters

TBD
