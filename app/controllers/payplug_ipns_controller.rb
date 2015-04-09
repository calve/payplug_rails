require 'payplug_rails'

class PayplugIpnsController < ApplicationController
  protect_from_forgery :except => :ipn

  def ipn
    puts "IPN : "  + request.raw_post
    valid = PayplugRails::Payplug.verify(request)
    render :text => request.method+ " : "  + request.raw_post + "///" + payplug_ipn_params.to_s
    if valid
      send(PayplugRails.ipn_callback, JSON.parse(request.raw_post))
    end
  end

  private
  def payplug_ipn_params
    params.permit(:id_transaction, :is_test, :custom_datas, :origin, :last_name, :amount, :order, :state, :email, :first_name, :status, :customer)
  end
end
