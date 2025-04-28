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
  end

  def chat(prompt)
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
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
