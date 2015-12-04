require 'uxsock'

module Proxy::Colly
  class Writer
    include ::Proxy::Log

    def initialize(socket_name, hostname, interval)
      @socket_name = socket_name
      @hostname = hostname
      @interval = interval
    end

    def send_value id, value_list
      Uxsock::CollectdUnixSock.open(@socket_name) do |socket|
        logger.debug "VAL: #{id}: #{value_list.inspect}"
        socket.putval "#{@hostname}/#{id}", value_list, @interval
      end
    end

    def send_values array_id_valuelist
      Uxsock::CollectdUnixSock.open(@socket_name) do |socket|
        array_id_valuelist.each do |id_val|
          logger.debug "VAL: #{id_val[0]}: #{id_val[1].inspect}"
          socket.putval "#{@hostname}/#{id_val[0]}", id_val[1], @interval
        end
      end
    end

    def notify message, time = Time.now.utc, severity = :okay, options = {}
      Uxsock::CollectdUnixSock.open(@socket_name) do |socket|
        logger.debug "NTF: #{message}"
        socket.putnotif message, time, severity, @hostname, options
      end
    end
  end
end
