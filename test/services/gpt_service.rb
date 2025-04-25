require "openai"

class ChatGPTService
  def initialize
    @api_key = ENV["OPENAI_API_KEY"]
    @client = OpenAI::Client.new(access_token: @api_key)
  end

  def chat(prompt)
    response = @client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: "あなたは海外旅行初心者に役立つ優秀な旅行アシスタントです。ユーザーの質問に対して、日本語で明確かつ簡潔な旅行アドバイスを提供してください。300字以内で書いてください。リストや重要なポイントを箇条書きで改行してください。各ポイントには具体例や説明を加えてください。記号やマークダウン形式（**など）は使用しないでください。" },
          { role: "user", content: prompt }
        ],
        max_tokens: 500,
        temperature: 0.7
      }
    )

    if response["choices"] && response["choices"][0] && response["choices"][0]["message"]
      @answer = response["choices"][0]["message"]["content"]
    else
      @answer = "申し訳ありませんが、回答を生成できませんでした。もう一度お試しください。"
    end
  end
end


if __FILE__ == $0
  service = ChatGPTService.new
  prompt = "海外旅行の際に気をつけるべきことは何ですか？"
  puts service.chat(prompt)
end
