require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "generate and update gh-pages"
task :pages do
  system(" set -x; yard --tag internal:'Maintainer Notes' --hide-tag internal ") or abort
  system(" set -x; git checkout gh-pages ") or abort
  system(" set -x; mkdir remove; mv * remove; mv remove/doc .; rm -rf remove ") or abort
  system(" set -x; mv -v doc/* . ") or abort
  system(" set -x; git add . ") or abort
  system(" set -x; git commit --all -m 'Updating documentation' ") or abort 
  system(" set -x; git checkout develop ") or abort
  puts "don't forget to run: git push origin gh-pages"
end
