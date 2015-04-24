# PayplugRails

A Rails plugin to create payments using Payplug's solution

## Installation

Add this line to your application's Gemfile:

    gem 'payplug_rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payplug_rails

## Usage

Get your [Payplug autoconfig](https://www.payplug.fr/portal/ecommerce/autoconfig) and set the following values in ``initializer/payplugrails.rb``

    def ipn_callback(params)
      # Define what to do when an valid IPN is received
      #
      # params contains a json objet of the POST request sent by Payplug
      Order.find_by_id(params['order'])
      Order.status = 'paid'
      Order.save
    end

    # Mind the colomn to pass a function pointer
    PayplugRails.ipn_callback = :ipn_callback

    # The following parameters comes from your autoconfig
    PayplugRails.url = "https://www.payplug.fr/p/<your-url>"  # This is your url taken from autoconfig
    PayplugRails.payplug_public_key = "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtN4dpK368PEEYKeee7S5\n1m2a8GUFLDAZ/HgRI1H6diYt87gzDPftn1UyW96YuIBed0T0dtl0tuABaIgGeddR\nuo3zfMpkyYWM2D5UHUEMKzEY5WIyaaWoVYJaZU5DWzCiroKcnUJgKm41RL32/CHU\nSFoymxjOOzpvkazbaY+Ql2GYev2QwKAf7lkH91Wp3frjQYXEFIwYnt6ZET8wPUwX\nMdF0hRaZYlaDQrCB2S/+k4Djb8mXqVkJ0qqgItycL05zyysJw/IGMr2zZ5hQSnfN\nCJ+i33ywnoT/qctGgLW4bGuGdTdcbA7VzdxhXtHaAQjuJvrf+twNCQSLCMbZ6pnK\nzQIDAQAB\n-----END PUBLIC KEY-----\n"
    PayplugRails.private_key = "-----BEGIN RSA PRIVATE KEY-----\nrawprivatekey\n-----END RSA PRIVATE KEY-----""

Add the following to ``config/routes.rb``

    mount PayplugRails::Engine, at: "/ipn"

Then, in a controller, to get a payment url and redirect your user, require the module with

    require 'payplug_rails'

Then

    ipn_url = request.base_url + payplug_rails_engine_path # Create an ipn url relatives to the url used
    redirect_to PayplugRails::Payplug.create_payment(1200, ipn_url) # Create a payment for 12€00

You can also pass extra parameters :

    redirect_to PayplugRails::Payplug.create_payment(1200, ipn_url, {first_name: customer.first_name, last_name: customer.last_name, email: customer.email, order: order.id})


## Get IPN in development

Payplug expect your ipn_url to be reachable from the internet, which is typically not the case in a developement setup. However, you can set a [localtunnel](https://www.localtunnel.me) and access your application with the url provided.


## Disclosure

This plugin is not supported nor maintened by Payplug SAS.


## Contributing

1. Fork it ( https://github.com/calve/payplug_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
