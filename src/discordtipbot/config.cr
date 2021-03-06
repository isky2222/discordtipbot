require "json"

class Webhook
  REGEX = /^https:\/\/discordapp\.com\/api\/webhooks\/(?<id>\d+)\/(?<token>\S+)/

  getter id : UInt64
  getter token : String

  def initialize(sth : String)
    m = sth.match(REGEX)
    @id = m.not_nil!["id"].to_u64
    @token = m.not_nil!["token"]
  end
end

module Webhook::Converter
  def self.from_json(value : JSON::PullParser) : Webhook
    Webhook.new(value.read_string)
  end
end

class Config
  JSON.mapping(
    database_url: String,

    discord_token: String,
    discord_client_id: UInt64,

    coin_api_type: String,

    blockio_api_key: String,

    rpc_url: String,
    rpc_username: String,
    rpc_password: String,
    confirmations: Int64,

    walletnotify_port: Int32,

    prefix: String,

    coinname_full: String,
    coinname_short: String,

    uri_scheme: String,

    txfee: BigDecimal,

    min_tip: BigDecimal,
    min_soak: BigDecimal,
    min_soak_total: BigDecimal,
    min_rain_total: BigDecimal,
    min_withdraw: BigDecimal,

    high_balance: Int32,

    admins: Array(UInt64),
    ignored_users: Set(UInt64),
    whitelisted_bots: Set(UInt64),

    general_webhook: {type: Webhook, converter: Webhook::Converter},
    admin_webhook: {type: Webhook, converter: Webhook::Converter}
  )
end
