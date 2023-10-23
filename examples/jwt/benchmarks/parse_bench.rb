# frozen_string_literal: true

Benny.define do
  before do
    require 'jwt'
  end

  benchmark 'HS256 encode-decode' do
    token = JWT.encode({ pay: 'load' }, 'secret', 'HS256')
    JWT.decode(token, 'secret', true, { algorithm: 'HS256' })
  end
end
