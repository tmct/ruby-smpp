# encoding: UTF-8

class Smpp::OptionalParameter

  #SMPP Optional Parameter Tag definitions
  DEST_ADDR_SUBUNIT           = 0x0005
  DEST_NETWORK_TYPE           = 0x0006
  DEST_BEARER_TYPE            = 0x0007
  DEST_TELEMATICS_ID          = 0x0008
  SOURCE_ADDR_SUBUNIT         = 0x000D
  SOURCE_NETWORK_TYPE         = 0x000E
  SOURCE_BEARER_TYPE          = 0x000F
  SOURCE_TELEMATICS_ID        = 0x0010
  QOS_TIME_TO_LIVE            = 0x0017
  PAYLOAD_TYPE                = 0x0019
  ADDITIONAL_STATUS_INFO_TEXT = 0x001D
  RECEIPTED_MESSAGE_ID        = 0x001E
  MS_MSG_WAIT_FACILITIES      = 0x0030
  PRIVACY_INDICATOR           = 0x0201
  SOURCE_SUBADDRESS           = 0x0202
  DEST_SUBADDRESS             = 0x0203
  USER_MESSAGE_REFERENCE      = 0x0204
  USER_RESPONSE_CODE          = 0x0205
  SOURCE_PORT                 = 0x020A
  DESTINATION_PORT            = 0x020B
  SAR_MSG_REF_NUM             = 0x020C
  LANGUAGE_INDICATOR          = 0x020D
  SAR_TOTAL_SEGMENTS          = 0x020E
  SAR_SEGMENT_SEQNUM          = 0x020F
  SC_INTERFACE_VERSION        = 0x0210
  CALLBACK_NUM_PRES_IND       = 0x0302
  CALLBACK_NUM_ATAG           = 0x0303
  NUMBER_OF_MESSAGES          = 0x0304
  CALLBACK_NUM                = 0x0381
  DPF_RESULT                  = 0x0420
  SET_DPF                     = 0x0421
  MS_AVAILABILITY_STATUS      = 0x0422
  NETWORK_ERROR_CODE          = 0x0423
  MESSAGE_PAYLOAD             = 0x0424
  DELIVERY_FAILURE_REASON     = 0x0425
  MORE_MESSAGES_TO_SEND       = 0x0426
  MESSAGE_STATE               = 0x0427
  USSD_SERVICE_OP             = 0x0501
  DISPLAY_TIME                = 0x1201
  SMS_SIGNAL                  = 0x1203
  MS_VALIDITY                 = 0x1204
  ALERT_ON_MESSAGE_DELIVERY   = 0x130C
  ITS_REPLY_TYPE              = 0x1380
  ITS_SESSION_INFO            = 0x1383

  OPTIONAL_PARAMETER_TAG_DEFINITIONS = {
    DEST_ADDR_SUBUNIT           => "DEST_ADDR_SUBUNIT",
    DEST_NETWORK_TYPE           => "DEST_NETWORK_TYPE",
    DEST_BEARER_TYPE            => "DEST_BEARER_TYPE",
    DEST_TELEMATICS_ID          => "DEST_TELEMATICS_ID",
    SOURCE_ADDR_SUBUNIT         => "SOURCE_ADDR_SUBUNIT",
    SOURCE_NETWORK_TYPE         => "SOURCE_NETWORK_TYPE",
    SOURCE_BEARER_TYPE          => "SOURCE_BEARER_TYPE",
    SOURCE_TELEMATICS_ID        => "SOURCE_TELEMATICS_ID",
    QOS_TIME_TO_LIVE            => "QOS_TIME_TO_LIVE",
    PAYLOAD_TYPE                => "PAYLOAD_TYPE",
    ADDITIONAL_STATUS_INFO_TEXT => "ADDITIONAL_STATUS_INFO_TEXT",
    RECEIPTED_MESSAGE_ID        => "RECEIPTED_MESSAGE_ID",
    MS_MSG_WAIT_FACILITIES      => "MS_MSG_WAIT_FACILITIES",
    PRIVACY_INDICATOR           => "PRIVACY_INDICATOR",
    SOURCE_SUBADDRESS           => "SOURCE_SUBADDRESS",
    DEST_SUBADDRESS             => "DEST_SUBADDRESS",
    USER_MESSAGE_REFERENCE      => "USER_MESSAGE_REFERENCE",
    USER_RESPONSE_CODE          => "USER_RESPONSE_CODE",
    SOURCE_PORT                 => "SOURCE_PORT",
    DESTINATION_PORT            => "DESTINATION_PORT",
    SAR_MSG_REF_NUM             => "SAR_MSG_REF_NUM",
    LANGUAGE_INDICATOR          => "LANGUAGE_INDICATOR",
    SAR_TOTAL_SEGMENTS          => "SAR_TOTAL_SEGMENTS",
    SAR_SEGMENT_SEQNUM          => "SAR_SEGMENT_SEQNUM",
    SC_INTERFACE_VERSION        => "SC_INTERFACE_VERSION",
    CALLBACK_NUM_PRES_IND       => "CALLBACK_NUM_PRES_IND",
    CALLBACK_NUM_ATAG           => "CALLBACK_NUM_ATAG",
    NUMBER_OF_MESSAGES          => "NUMBER_OF_MESSAGES",
    CALLBACK_NUM                => "CALLBACK_NUM",
    DPF_RESULT                  => "DPF_RESULT",
    SET_DPF                     => "SET_DPF",
    MS_AVAILABILITY_STATUS      => "MS_AVAILABILITY_STATUS",
    NETWORK_ERROR_CODE          => "NETWORK_ERROR_CODE",
    MESSAGE_PAYLOAD             => "MESSAGE_PAYLOAD",
    DELIVERY_FAILURE_REASON     => "DELIVERY_FAILURE_REASON",
    MORE_MESSAGES_TO_SEND       => "MORE_MESSAGES_TO_SEND",
    MESSAGE_STATE               => "MESSAGE_STATE",
    USSD_SERVICE_OP             => "USSD_SERVICE_OP",
    DISPLAY_TIME                => "DISPLAY_TIME",
    SMS_SIGNAL                  => "SMS_SIGNAL",
    MS_VALIDITY                 => "MS_VALIDITY",
    ALERT_ON_MESSAGE_DELIVERY   => "ALERT_ON_MESSAGE_DELIVERY",
    ITS_REPLY_TYPE              => "ITS_REPLY_TYPE",
    ITS_SESSION_INFO            => "ITS_SESSION_INFO"
  }

  attr_reader :tag, :value

  def initialize(tag, value)
    @tag = tag
    @value = value
  end

  def [](symbol)
    self.send symbol
  end

  def to_s
    self.inspect
  end

  def pp_opt_param
    type = OPTIONAL_PARAMETER_TAG_DEFINITIONS[self.tag]
    if type.nil?
      type = "(unrecognised type)"
    end
    out = ""
    out << "  Optional parameter:\n"
    out << "    Type:     #{type}\n"
    out << "    Value:    #{self.value.dump}\n" #todo output value to hex instead of dumping, e.g. 0xabcd
    out
  end

  #class methods
  class << self
    def from_wire_data(data)

      return nil if data.nil?
      tag, length, remaining_bytes = data.unpack('H4na*')
      tag = tag.hex

      raise "invalid data, cannot parse optional parameters" if tag == 0 or length.nil?

      value = remaining_bytes.slice!(0...length)

      return new(tag, value), remaining_bytes
    end

  end

end
