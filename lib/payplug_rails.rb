require "payplug_rails/version"
require 'openssl'
require 'base64'
require 'json'
require 'cgi'

module PayplugRails

  mattr_accessor :url
  mattr_accessor :private_key
  mattr_accessor :payplug_public_key

  class Payplug

    def self.create_payment(amount, ipn_url, customer_hash={})
      data = {
        currency: 'EUR',
        amount: amount,
        ipn_url: ipn_url,

      }.merge(customer_hash).to_query
      key = OpenSSL::PKey::RSA.new PayplugRails.private_key
      raw_sign = key.sign(OpenSSL::Digest::SHA1.new, data)
      http_sign = CGI.escape(Base64.encode64(raw_sign))
      http_data = CGI.escape(Base64.encode64(data))
      puts data
      return PayplugRails.url+"?data="+http_data+"&sign="+http_sign
    end

  end
end
