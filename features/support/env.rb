require 'aruba/cucumber'
require 'aruba/in_process'
require 'fourchan/kit/cli'
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.hook_into :webmock
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true 
end

# Magic by http://georgemcintosh.com/vcr-and-aruba/
class VcrFriendlyMain
  def initialize(argv, stdin, stdout, stderr, kernel)
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
  end

  def execute!
    $stdin = @stdin
    $stdout = @stdout
    Fourchan::Kit::CLI.start(@argv)
  end
end

Before('@vcr') do
  Aruba::InProcess.main_class = VcrFriendlyMain
  Aruba.process = Aruba::InProcess
end

After('@vcr') do
  Aruba.process = Aruba::SpawnProcess
  VCR.eject_cassette
  $stdin = STDIN
  $stdout = STDOUT
end
