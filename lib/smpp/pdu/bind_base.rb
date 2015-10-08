# encoding: UTF-8
# this class serves as the base for all the bind* commands.
# since the command format remains the same for all bind commands,
# sub classes just change the @@command_id
class Smpp::Pdu::BindBase < Smpp::Pdu::Base
  class << self; attr_accessor :command_id ; end

  attr_reader :system_id, :password, :system_type, :addr_ton, :addr_npi, :address_range, :interface_version

  def initialize(system_id, password, system_type, addr_ton, addr_npi, address_range, seq = nil, interface_version)
    @system_id, @password, @system_type, @addr_ton, @addr_npi, @address_range, @interface_version =
      system_id, password, system_type, addr_ton, addr_npi, address_range, interface_version

    seq ||= next_sequence_number
    body = sprintf("%s\0%s\0%s\0%c%c%c%s\0", system_id, password,system_type, PROTOCOL_VERSION, addr_ton, addr_npi, address_range)
    super(self.class.command_id, 0, seq, body)
  end

  def self.from_wire_data(seq, status, body)
    #unpack the body
    system_id, password, system_type, interface_version, addr_ton,
    addr_npi, address_range = body.unpack("Z*Z*Z*CCCZ*")

    self.new(system_id, password, system_type, addr_ton, addr_npi, address_range, seq, interface_version)
  end

  def pp_body
    out = ''
    out << "Body:\n"
    out << "\tSystem ID: #{system_id}\n"
    out << "\tPassword: #{password}\n"
    out << "\tSystem Type: #{system_type}\n"
    out << "\tInterface version: #{interface_version}\n"
    out << "\tAddr TON: #{addr_ton}\n"
    out << "\tAddr NPI: #{addr_npi}\n"
    out << "\tAddress range: #{address_range}\n"
    out
  end
end
