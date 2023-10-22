# frozen_string_literal: true

Benny.define do
  warmup iterations: 2

  before do
    require 'oj'
    @h = { 'one' => 1, 'array' => [true, false] }
  end

  benchmark 'Simple parse' do
    700_000.times do
      Oj.load(Oj.dump(@h))
    end
  end

  benchmark 'String parse' do
    700_000.times do
      Oj.load(Oj.dump('string'))
    end
  end
end
