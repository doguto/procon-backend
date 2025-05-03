require "logger"
Dir.glob(File.join(__dir__, "../services/", "*.rb")).each do |file|
  require file
end


class ApplicationDomain
  def initialize
    @logger_stdout = Logger.new($stdout)
  end

  def execute
    raise "implement this method in subclass"
  end
end
