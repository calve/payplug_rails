require "payplug_rails/version"
require "payplug_rails/engine"
require 'openssl'
require 'base64'
require 'json'
require 'cgi'

module PayplugRails

  mattr_accessor :url
  mattr_accessor :private_key
  mattr_accessor :payplug_public_key
  mattr_accessor :ipn_callback

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

      return PayplugRails.url+"?data="+http_data+"&sign="+http_sign
    end

    def self.verify(request)
      # Verify the IPN contained in the http request
      signature = Base64.decode64(request.headers['HTTP_PAYPLUG_SIGNATURE'])
      body = request.raw_post
      key = OpenSSL::PKey::RSA.new PayplugRails.payplug_public_key
      status = key.verify(OpenSSL::Digest::SHA1.new, signature, body)
      return status
    end
  end
end
