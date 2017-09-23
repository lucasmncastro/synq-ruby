Gem::Specification.new do |s|
  s.name        = 'synq'
  s.version     = '0.0.1'
  s.date        = '2017-09-22'
  s.summary     = "Ruby SDK for SYNQ Api"
  s.authors     = ["Lucas Castro"]
  s.email       = 'castro.lucas@gmail.com'
  s.files       = ["lib/synq.rb", 
                   "lib/synq/resources/video.rb", 
                   "lib/synq/parser.rb", 
                   "lib/synq/api.rb"]
  s.homepage    = 'https://github.com/SYNQfm/SYNQ-Ruby'
  s.license     = 'MIT'
  s.add_runtime_dependency 'httparty', '~> 0.15'
end
