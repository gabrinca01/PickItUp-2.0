 require 'uri'
 require 'net/http'
 require 'openssl'
 require 'json'
class ApplicationController < ActionController::Base
    include Pundit::Authorization
end
