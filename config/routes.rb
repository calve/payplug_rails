PayplugRails.Engine.routes.draw do
  get '/ipn' => 'payplug_ipns#ipn'
  post '/ipn' => 'payplug_ipns#ipn'
end
