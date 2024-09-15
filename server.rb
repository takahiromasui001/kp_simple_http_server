require 'socket'

server = TCPServer.new('localhost', 9292)

def parse(request_string)
  method, path, version = request_string.lines[0].split

  {
    method:,
    path:,
    headers: parse_headers(request_string)
  }
end

def parse_headers(request)
  headers = {}
  request.lines[1..-1].each do |line|
    return headers if line == "\r\n"
    header, value = line.split
    header = normalize(header)
    headers[header] = value
  end
end

def normalize(header)
  header.gsub(':', "").downcase.to_sym
end

loop do
  socket = server.accept
  request = socket.readpartial(2048)

  STDERR.puts parse(request)
end

