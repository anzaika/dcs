require "dcs/version"
require "logger"

module Dcs

  def self.options
    "--tessdata-dir lib/tessdata -l digits --oem 3"
  end

  def self.command(input_path, output_path)
    "tesseract #{input_path} stdout #{self.options} >> #{output_path}"
  end

  def self.solve(image_path)
    logger = Logger.new(STDOUT)
    logger.info("Solving captcha for image: #{image_path}")

    @out = Tempfile.new
    logger.info("Using this file for tesseract output: #{@out.path}")

    cmd = self.command(image_path, @out.path)
    logger.info("Running: #{cmd}")
    system(self.command(image_path, @out.path))

    solution = @out.read.gsub!(/[^0-9A-Za-z]/, '')
    logger.info("Solution: #{solution}")

    solution
  ensure
    @out.unlink
    logger.info("Terminating")
  end
end
