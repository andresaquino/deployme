#  $Id$
#  $Source$
#
#  Author: Jim Freeze
#  Copyright (c) 2005 Jim Freeze
#
# =DESCRIPTION
# A very flexible commandline parser
#
# =Revision History
#  Jim.Freeze 04/01/2005 Birthday
#
#

module CommandLine

#
# Data resulting from parsing a command line (Array)
# using a particular OptionParser object
#
class OptionData
  attr_reader :argv, :unknown_options, :args, :not_parsed, :cmd

  class OptionDataError < StandardError; end
  class UnknownOptionError < OptionDataError; end

  def initialize(argv, opts, unknown_options, args, not_parsed, cmd)
    @opts = {}
    opts.each { |k,v| 
      @opts[k] = 
        begin
          Marshal.load(Marshal.dump(v))
        rescue
          v
        end
    }
    @unknown_options = Marshal.load(Marshal.dump(unknown_options))
    @not_parsed = Marshal.load(Marshal.dump(not_parsed))
    @argv = Marshal.load(Marshal.dump(argv))
    @args = Marshal.load(Marshal.dump(args))
    @cmd  = Marshal.load(Marshal.dump(cmd))
  end

  def [](key)
    if @opts.has_key?(key)
      @opts[key]
    else
      raise(UnknownOptionError, "Unknown option '#{key}'.")
    end
  end

end#class OptionData

end#module CommandLine
