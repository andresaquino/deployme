# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{termios}
  s.version = "0.9.4"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.autorequire = %q{termios}
  s.cert_chain = nil
  s.date = %q{2004-09-24}
  s.email = %q{akira@ruby-lang.org}
  s.extensions = ["extconf.rb"]
  s.extra_rdoc_files = ["README", "termios.rd"]
  s.files = ["ChangeLog", "extconf.rb", "README", "TODO.ja", "termios.c", "termios.rd", "MANIFEST", "test/test0.rb", "examples/modem_check0.rb", "examples/modem_check1.rb", "examples/modem_check2.rb", "examples/secret_input1.rb", "examples/secret_input2.rb"]
  s.homepage = %q{http://arika.org/ruby/termios}
  s.require_paths = ["lib", "."]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Termios module are simple wrapper for termios(3). It can be included into IO-family classes and can extend IO-family objects. In addition, the methods can use as module function.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
