# encoding: UTF-8

class Smpp::Pdu::DeliverSmResponse < Smpp::Pdu::Base
  handles_cmd DELIVER_SM_RESP

  attr_accessor :message_id

  def initialize(seq, status=ESME_ROK, message_id)
    seq ||= next_sequence_number
    @message_id = message_id
    super(DELIVER_SM_RESP, status, seq, "\000") # body must be NULL..!
  end

  def self.from_wire_data(seq, status, body)
  	message_id, remaining_bytes = body.unpack("Z*a*")
    new(seq, status, message_id)
  end

  def pp_body
    out = ''
    out << "Body:\n"
    out << "  Message ID: #{message_id}\n"
    out
  end
end
