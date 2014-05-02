$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fourchan/kit'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true

  c.before do  # Globally quiet puts for tests
    IO.any_instance.stub(:puts)
  end
end
