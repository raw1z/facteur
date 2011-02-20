require 'mongoid'
require 'spec_helper'

Dir[File.expand_path('../../support/mongoid/*.rb', __FILE__)].each{|f| require f }

RSpec.configure do |c|
  c.before(:suite) do
    Database.connect
  end
end

