require 'aruba/cucumber'
require 'aruba/in_process'
require 'fourchan/kit/runner'
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.hook_into :webmock
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true 
end

Aruba::InProcess.main_class = Fourchan::Kit::Runner
Aruba.process = Aruba::InProcess
