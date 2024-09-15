require 'socket'

server = TCPServer.new('localhost', 9292)

loop do
  socket = server.accept
  request = socket.readpartial(2048)

  STDERR.puts request
end

