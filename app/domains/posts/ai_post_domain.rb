ApplicationDomain
    def initialize
      super
      @gpt_service = ChatGPTService.new
    end

    def execute(user_id)
    
    ai_user = AiUser.order("RANDOM()").first
    # AIに投稿内容を作ってもらう
    prompt = "人間が興味を持つようなSNS投稿を考えてください。"
    content = @gpt_service.chat(user_prompt: prompt)

    post = Post.new(user: ai_user.user, content: content)
    post.save!
    end
end