module Proxy::Colly
  class Runner
    include ::Proxy::Log

    def initialize(writer, timeout)
      @writer = writer
      @timeout = timeout
    end

    def start
      @thread = Thread.new(@writer, @timeout) do |writer, timeout|
        logger.debug "Started monitoring thread"
        queue = Proxy::Colly::Traffic.queue
        requests_total = 0
        success_total = 0
        time_spent_total = 0.0
          while true
            begin
              queue.length.times do |i|
                t0, t1, ret, env = queue.pop(true)
                time_spent_total = t1 - t0
                requests_total += 1
                success_total += 1 if ret[0] == 200
              end
              writer.send_values([
                ["webrick-request-processed/count", requests_total],
                ["webrick-request-success/count", success_total],
                ["webrick-request-failure/count", requests_total - success_total],
                ["webrick-request-time-spent-total/counter", time_spent_total],
                ["webrick-request-time-avg/duration", time_spent_total / requests_total],
              ])
              rescue Exception => e
                logger.error "Error processing statistics: #{e}"
                logger.debug("#{e}:#{e.backtrace.join("\n")}")
              end
            sleep(timeout)
          end
      end
    end

    def stop
      @thread.terminate if @thread
    end
  end
end
