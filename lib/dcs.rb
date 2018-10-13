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

    @out = Tempfile.new
    logger.debug("Using this file for tesseract output: #{@out.path}")

    cmd = self.command(image_path, @out.path)
    logger.debug("Running: #{cmd}")
    system(self.command(image_path, @out.path))

    solution = @out.read.gsub!(/[^0-9A-Za-z]/, '')
    logger.debug("Solution: #{solution}")

    solution
  ensure
    @out.unlink
    logger.debug("Terminating")
  end
end
