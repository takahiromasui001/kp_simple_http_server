require 'socket'
require 'debug'
require_relative 'http_request_parser'
require_relative 'http_response_parser'

SERVER_ROOT_PATH = File.expand_path('src', __dir__)

class Kp::HttpServer
  def initialize(port)
    @port = port
  end

  def start
    server = TCPServer.new('localhost', @port)

    loop do
      socket = server.accept
      request = socket.readpartial(2048)
      parsed_request = Kp::HttpRequestParser.new(request).parse
    
      STDERR.puts parsed_request
    
      response = prepare(parsed_request)
      response.send(socket)
    
      socket.close
    end
  end

  def prepare(parsed_request)
    path = parsed_request[:path]
    if path == '/'
      respond_with(SERVER_ROOT_PATH + '/index.html')
    else
      respond_with(SERVER_ROOT_PATH + path)
    end
  end
  
  def respond_with(path)
    if File.exist?(path)
      ok_response(File.binread(path))
    else
      not_found_response
    end
  end
  
  def ok_response(body)
    Kp::HttpResponseParser.new(code: 200, body:)
  end
  
  def not_found_response
    Kp::HttpResponseParser.new(code: 404)
  end
end

Kp::HttpServer.new(9292).start