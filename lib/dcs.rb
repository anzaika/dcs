require "dcs/version"
require 'rtesseract'
require 'rmagick'

module Dcs
  def self.solve(image_path)
    RTesseract.configure do |config|
      config.tessdata_dir = Dir.pwd + "/lib/tessdata"
      config.oem = '3'
      config.lang = 'digits'
    end
    RTesseract.new(image_path).to_s.gsub!(/[^0-9A-Za-z]/, '')
  end
end
