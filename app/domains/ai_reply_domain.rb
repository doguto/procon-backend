class AIReplyDomain < ApplicationDomain
  def initialize
    super

    @gpt_service = ChatGPTService.new
  end

  def execute
    Rails.logger.info "temp"
  end
end
