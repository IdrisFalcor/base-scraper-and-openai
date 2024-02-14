require 'httparty'

class ChatGPTService
  include HTTParty
  base_uri 'https://api.openai.com/v1'

  def initialize(api_key)
    @api_key = api_key
  end

  def chat(prompt)
    self.class.post('/engines/chat-gpt-3.5-turbo/completions', {
      headers: {
        'Authorization' => "Bearer #{@api_key}",
        'Content-Type' => 'application/json'
      },
      body: {
        prompt: prompt,
        max_tokens: 150,
        temperature: 0.5,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0,
        stop: '\n'
      }.to_json
    })
  end
end