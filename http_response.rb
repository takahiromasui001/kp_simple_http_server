module Kp
  class HttpResponse
    attr_reader :formatted_response

    def initialize(code:, body: '')
      @formatted_response =
        "HTTP/1.1 #{code}\r\n" +
        "Content-Length: #{body.size}\r\n" +
        "\r\n" +
        "#{body}\r\n"
    end
  end  
end

