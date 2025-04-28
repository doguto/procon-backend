class AIReplyController < ApplicationController
  def initialize
    super

    @ai_reply_domain = AIReplyDomain.new
  end
end
