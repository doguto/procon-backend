<<<<<<< HEAD:test/services/gpt_service.rb
class ChatGPTService
  def initialize
    @api_key = ENV.fetch("OPENAI_API_KEY", nil)
    
    if @api_key.nil?
      raise "APIキーが設定されていません"
    end

    begin
      @client = OpenAI::Client.new(access_token: @api_key)
    rescue => e
      raise "クライアントの初期化に失敗しました: #{e.message}"
    end
=======
require "openai"
require "logger"

class ChatGPTService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY", nil))
>>>>>>> 02b015b62b4f1b39c8ee8e65c58d19b3bbce4f25:app/services/gpt_service.rb
  end

  def chat(user_prompt, system_prompt = "あなたはツイッターのユーザーです。ポストに対し、100字以内で返信のツイートをしてください。関西弁で。記号やマークダウン形式（**など）は使用しないでください。")
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: system_prompt },
          { role: "user", content: user_prompt }
        ],
        max_tokens: 500,
        temperature: 0.7
      }
    )

    @answer = if response["choices"] && response["choices"][0] && response["choices"][0]["message"]
                response["choices"][0]["message"]["content"]
              else
                "申し訳ありませんが、回答を生成できませんでした。もう一度お試しください。"
              end
  end
end
<<<<<<< HEAD:test/services/gpt_service.rb
=======


if __FILE__ == $PROGRAM_NAME
  service = ChatGPTService.new
  prompt = "railsにクリーンアーキテクチャ拒絶された…"
  Rails.logger.info service.chat(prompt)
end
>>>>>>> 02b015b62b4f1b39c8ee8e65c58d19b3bbce4f25:app/services/gpt_service.rb
