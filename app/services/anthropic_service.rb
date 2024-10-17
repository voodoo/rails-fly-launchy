class AnthropicService
  include HTTParty
  base_uri 'https://api.anthropic.com'

  def initialize
    @api_key = ENV['ANTHROPIC_API_KEY']
  end

  def generate_response(user_message)
    response = self.class.post('/v1/messages', 
      headers: headers,
      body: {
        model: "claude-3-opus-20240229",
        max_tokens: 1024,
        messages: [
          { role: "user", content: user_message }
        ]
      }.to_json
    )

    if response.success?
      response.parsed_response['content'][0]['text']
    else
      Rails.logger.error("Anthropic API error: #{response.body}")
      raise "Failed to generate AI response: #{response['error']['message']}"
    end
  end

  private

  def headers
    {
      'Content-Type' => 'application/json',
      'X-Api-Key' => @api_key,
      'anthropic-version' => '2023-06-01'
    }
  end
end
