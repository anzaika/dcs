require "dcs/version"
require "logger"

module Dcs

  def self.tessdata_path
    File.join(File.dirname(__FILE__), "tessdata")
  end

  def self.options
    "--tessdata-dir #{self.tessdata_path} -l digits --oem 3"
  end

  def self.command(input_path, output_path)
    "tesseract #{input_path} stdout #{self.options} >> #{output_path}"
  end

  def self.solve(image_path)
    logger = Logger.new(STDOUT)
    logger.debug("Solving captcha for image: #{image_path}")

    solution = ''

    Tempfile.create("tessout") do |f|
      logger.debug("Using this file for tesseract output: #{f.path}")

      cmd = self.command(image_path, f.path)
      logger.debug("Running: #{cmd}")
      system(self.command(image_path, f.path))

      solution = f.read.gsub!(/[^0-9A-Za-z]/, '')
      logger.debug("Solution: #{solution}")
    end

    logger.debug("Terminating")
    solution
  end
end
