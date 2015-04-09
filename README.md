# PayplugRails

A Rails plugin to create payment using Payplug's solution

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payplug_rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payplug_rails

## Usage

Get your [Payplug autoconfig](https://www.payplug.fr/portal/ecommerce/autoconfig) and set the following values in ``initializer/payplugrails.rb``

    PayplugRails.url = "https://www.payplug.fr/p/<you-url>"
    PayplugRails.payplug_public_key = "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtN4dpK368PEEYKeee7S5\n1m2a8GUFLDAZ/HgRI1H6diYt87gzDPftn1UyW96YuIBed0T0dtl0tuABaIgGeddR\nuo3zfMpkyYWM2D5UHUEMKzEY5WIyaaWoVYJaZU5DWzCiroKcnUJgKm41RL32/CHU\nSFoymxjOOzpvkazbaY+Ql2GYev2QwKAf7lkH91Wp3frjQYXEFIwYnt6ZET8wPUwX\nMdF0hRaZYlaDQrCB2S/+k4Djb8mXqVkJ0qqgItycL05zyysJw/IGMr2zZ5hQSnfN\nCJ+i33ywnoT/qctGgLW4bGuGdTdcbA7VzdxhXtHaAQjuJvrf+twNCQSLCMbZ6pnK\nzQIDAQAB\n-----END PUBLIC KEY-----\n"
    PayplugRails.private_key = "-----BEGIN RSA PRIVATE KEY-----\nrawprivatekey\n-----END RSA PRIVATE KEY-----""

To get a payment url, do

    PayplugRails::Payplug.create_payment(1200, ipn_url)

You can pass extra parameters :

    PayplugRails::Payplug.create_payment(1200, ipn_url, {first_name: customer.first_name, last_name: customer.last_name, email: customer.email})

## Contributing

1. Fork it ( https://github.com/[my-github-username]/payplug_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
