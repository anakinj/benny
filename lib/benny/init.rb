# frozen_string_literal: true

require 'fileutils'

module Benny
  module Init
    def self.create(name)
      raise ArgumentError, "The dir '#{name}' already exists" if Dir.exist?(name)

      FileUtils.copy_entry(File.join(__dir__, 'init'), name)
    end
  end
end
