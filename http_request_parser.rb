module Kp
  class HttpRequestParser
    attr_reader :request
  
    def initialize(request)
      @request = request
    end
  
    def parse
      method, path, version = request.lines[0].split
    
      {
        method:,
        path:,
        headers: parse_headers
      }
    end
    
    def parse_headers
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
  end  
end

