require "payplug_rails/version"

module PayplugRails
  # Your code goes here...
  mattr_accessor :baseurl
  mattr_accessor :private_key
  mattr_accessor :payplug_public_key

  def self.hello
    puts "hello, payment"
  end
end
