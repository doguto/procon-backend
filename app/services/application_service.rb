require "logger"
parent_dir = File.expand_path("../../", __dir__)
Dir.glob(File.join("#{parent_dir}/app/services/", "*.rb")).each do |file|
  require file
end

class ApplicationService
  def initialize
    @logger_stdout = Logger.new($stdout)
  end
end
