class ApplicationDomain
    def initialize
      super
      @gpt_service = ChatGPTService.new
    end
  
    def execute(user_id)
      begin
        ai_user = AiUser.order("RANDOM()").first
        prompt = "人間が興味を持つようなSNS投稿を考えてください。"
        content = @gpt_service.chat(user_prompt: prompt)
        post = Post.new(user: ai_user.user, content: content)
        if post.save
          Rails.logger.info "AIポストが成功しました: #{post.content}"
        else
          Rails.logger.error "AIポストの保存に失敗しました: #{post.errors.full_messages.join(', ')}"
        end
      rescue => e
        Rails.logger.error "AIポストの作成中にエラーが発生しました: #{e.message}"
      end
    end
  end