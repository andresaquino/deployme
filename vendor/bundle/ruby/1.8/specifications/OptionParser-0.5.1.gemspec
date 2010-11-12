# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{OptionParser}
  s.version = "0.5.1"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Jim Freeze"]
  s.autorequire = %q{commandline/optionparser}
  s.cert_chain = nil
  s.date = %q{2005-06-17}
  s.email = %q{optionparser@freeze.org}
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["docs/index.html", "lib/commandline", "lib/commandline.rb", "lib/commandline/optionparser", "lib/commandline/optionparser.rb", "lib/commandline/text", "lib/commandline/optionparser/option.rb", "lib/commandline/optionparser/optiondata.rb", "lib/commandline/optionparser/optionparser.rb", "lib/commandline/text/format.rb", "README", "LICENSE"]
  s.homepage = %q{http://rubyforge.org/projects/optionparser/}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A flexible command line option parser.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
