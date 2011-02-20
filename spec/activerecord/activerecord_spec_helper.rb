require 'active_record'
require 'spec_helper'

Dir[File.expand_path('../../support/activerecord/*.rb', __FILE__)].each{|f| require f }

RSpec.configure do |c|
  c.before(:suite) do
    CreateSchema.suppress_messages{ CreateSchema.migrate(:up) }
  end
end

