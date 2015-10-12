# encoding: UTF-8

require 'timeout'
require 'scanf'
require 'monitor'

module Smpp
  class InvalidStateException < Exception; end

  class Base
    include Smpp

    # :bound or :unbound
    attr_accessor :state

    def initialize(config, delegate)
      @state = :unbound
      @config = config
      @data = ""
      @delegate = delegate
    end

    # queries the state of the transmitter - is it bound?
    def unbound?
      @state == :unbound
    end

    def bound?
      @state == :bound
    end

    def Base.logger
      @@logger
    end

    def Base.logger=(logger)
      @@logger = logger
    end

    def logger
      @@logger
    end

    def send_unbind
      write_pdu Pdu::Unbind.new
      @state = :unbound
    end

    def run_callback(cb, *args)
      if @delegate.respond_to?(cb)
        @delegate.send(cb, *args)
      end
    end

    private
    def write_pdu(pdu)
      logger.debug "<- #{pdu.to_human}"
      hex_debug pdu.data, "<- "
      send_data pdu.data
    end

    def read_pdu(data)
      pdu = nil
      # we may either receive a new request or a response to a previous response.
      begin
        pdu = Pdu::Base.create(data)
        if !pdu
          logger.warn "Not able to parse PDU!"
        else
          logger.debug "-> " + pdu.to_human
        end
        hex_debug data, "-> "
      rescue Exception => ex
        logger.error "Exception while reading PDUs: #{ex} in #{ex.backtrace[0]}"
        raise
      end
      pdu
    end

    def hex_debug(data, prefix = "")
      Base.hex_debug(data, prefix)
    end

    def Base.hex_debug(data, prefix = "")
      logger.debug do
        message = "Hex dump follows:\n"
        hexdump(data).each_line do |line|
          message << (prefix + line.chomp + "\n")
        end
        message
      end
    end

    def Base.hexdump(target)
      width=16
      group=2

      output = ""
      n=0
      ascii=''
      target.each_byte { |b|
        if n%width == 0
          output << "%s\n%08x: "%[ascii,n]
          ascii='| '
        end
        output << "%02x"%b
        output << ' ' if (n+=1)%group==0
        ascii << "%s"%b.chr.tr('^ -~','.')
      }
      output << ' '*(((2+width-ascii.size)*(2*group+1))/group.to_f).ceil+ascii
      output[1..-1]
    end
  end
end
