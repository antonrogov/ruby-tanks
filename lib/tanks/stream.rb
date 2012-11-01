module Tanks
  class Stream
    def initialize(host, port)
      @socket = TCPSocket.new host, port
    end

    def write_string(value)
      if value
        encoded = value.encode 'utf-8'
        write_int encoded.size
        write_bytes encoded
      else
        write_int -1
      end
    end

    def read_string
      length = read_int
      if length == -1
        nil
      else
        read_bytes(length).encode('utf-8')
      end
    end

    def write_bool(value)
      write_bytes [value ? 1 : 0].pack('c')
    end

    def read_bool
      read_bytes(1).unpack('c')[0] == 1
    end

    def write_byte(value)
      write_bytes [value].pack('c')
    end

    def read_byte
      read_bytes(1).unpack('c')[0]
    end

    def write_int(value)
      write_bytes [value].pack('l')
    end

    def read_int
      read_bytes(4).unpack('l')[0]
    end

    def write_long(value)
      write_bytes [value].pack('q')
    end

    def read_long
      read_bytes(8).unpack('q')[0]
    end

    def write_double(value)
      write_bytes [value].pack('d')
    end

    def read_double
      read_bytes(8).unpack('d')[0]
    end

    def write_bytes(bytes)
      @socket.write bytes
    end

    def read_bytes(length)
      bytes = ''
      bytes << @socket.read(length - bytes.size) while bytes.size < length
      bytes
    end

    def close
      @socket.close
    end
  end
end
