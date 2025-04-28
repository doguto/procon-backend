class AIReplyDomain < ApplicationDomain
  def initialize
    super

    @gpt_service = ChatGPTService.new
  end
end
