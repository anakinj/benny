# frozen_string_literal: true

module Benny
  module Output
    def self.puts(txt)
      $stdout.puts("[Benny] #{txt}")
    end
  end
end
