require "dcs/version"
require 'rtesseract'
require 'rmagick'

module Dcs
  def self.solve(image_path)

    RTesseract.configure do |config|
      # User only LSTM neural network engine
      config.oem = '3'

      # Path to directory with models
      config.tessdata_dir = Dir.pwd + "/lib/tessdata"

      # Use a specific model
      config.lang = 'digits'
    end

    RTesseract.new(image_path)
              .to_s
              .gsub!(/[^0-9A-Za-z]/, '')
  end
end
