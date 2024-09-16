module Kp
  class HttpResponseParser
    def initialize(code:, body: '')
      @response =
        "HTTP/1.1 #{code}\r\n" +
        "Content-Length: #{body.size}\r\n" +
        "\r\n" +
        "#{body}\r\n"
    end

    def send(client)
      client.write(@response)
    end
  end  
end

