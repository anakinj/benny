# frozen_string_literal: true

Benny.define do
  warmup iterations: 2

  before do
    require 'oj'
    @h = { 'one' => 1, 'array' => [true, false] }
  end

  benchmark 'Simple parse' do
    Oj.load(Oj.dump(@h))
  end

  benchmark 'String parse' do
    Oj.load(Oj.dump('string'))
  end
end
