PayplugRails::Engine.routes.draw do
  get '/' => 'payplug_ipns#ipn'
  post '/' => 'payplug_ipns#ipn'
end
