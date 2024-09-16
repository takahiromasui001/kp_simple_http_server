require 'minitest/autorun'
require 'net/http'
require_relative '../server'
require 'debug'

class HttpServerTest < Minitest::Test
  def setup
    @server_thread = Thread.new do
      puts "Starting server..."
      server.start
    end
    sleep 2 # サーバーが起動するのを待つ
  end

  def teardown
    puts "Server stopped."
    sleep 1 # サーバーが停止するのを待つ
  end

  def server
    @server ||= Kp::HttpServer.new(9293)
  end

  def test_ok_response
    puts "Running test_ok_response..."
    uri = URI('http://localhost:9293/index.html')
    response = Net::HTTP.get_response(uri)
    assert_equal '200', response.code
    assert_match /Hello World html/, response.body
  end

  def test_not_found_response
    puts "Running test_not_found_response..."
    uri = URI('http://localhost:9293/non_existent.html')
    response = Net::HTTP.get_response(uri)
    assert_equal '404', response.code
  end
end