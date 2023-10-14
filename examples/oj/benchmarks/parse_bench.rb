# frozen_string_literal: true

Benny.benchmark 'Simple parse' do
  require 'oj'
  100_000.times do
    h = { 'one' => 1, 'array' => [true, false] }
    Oj.load(Oj.dump(h))
  end
end
