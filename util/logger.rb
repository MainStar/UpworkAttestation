class Logger

  @logger = Logger.new(STDOUT)
  @logger.level = Logger::INFO

  # Use for messages to STDOUT
  def self.message(message)
    @logger.info(message)
  end

  # Use for Error messages to STDOUT
  def self.error(message)
    @logger.fatal(message)
  end

end