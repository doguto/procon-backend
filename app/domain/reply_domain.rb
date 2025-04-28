class ReplyDomain < ApplicationDomain
  def initialize
    super.initialize

    @gpt_service = ChatGPTService.new
  end
end
