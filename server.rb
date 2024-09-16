require 'socket'
require_relative 'http_request_parser'
require_relative 'http_response'
require_relative 'http_response_builder'

class Kp::HttpServer
  def initialize(port)
    @port = port
  end

  def start
    server = TCPServer.new('localhost', @port)

    STDERR.puts "Waiting for request... port: #{@port}"
    loop do
      socket = server.accept
      request = socket.readpartial(2048)

      parsed_request = Kp::HttpRequestParser.new(request).parse
    
      STDERR.puts parsed_request
    
      response = Kp::HttpResponseBuilder.new(parsed_request).build

      socket.write(response.formatted_response)
      socket.close
    end
  end
end
