require 'socket'

server = TCPServer.new('localhost', 9292)

loop do
  socket = server.accept
  request = socket.gets

  STDERR.puts request
end

