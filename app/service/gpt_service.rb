require "openai"

class ChatGPTService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY", nil))
  end

  def chat(prompt)
    response = @client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: "あなたはツイッターのユーザーです。ポストに対し、100字以内で返信のツイートをしてください。必ずしも敬語である必要はありません。記号やマークダウン形式（**など）は使用しないでください。" },
          { role: "user", content: prompt }
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

if __FILE__ == $PROGRAM_NAME
  service = ChatGPTService.new
  prompt = "railsにクリーンアーキテクチャ拒絶された…"
  Rails.logger.info service.chat(prompt)
end
