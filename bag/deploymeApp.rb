#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
#  
# deploymeApp.py
# =
#	Copyright (c) 2010
#	Andres Aquino <andres.aquino@gmail.com>
#
# Licensed under the BSD Licence:
# http://creativecommons.org/licenses/BSD/

# bundler gems encapsulated
require "rubygems"
require "bundler"
Bundler.setup


require "find" 

class Deployment
  attr_reader :



class Deployme
  NAME = "#{File.basename(__FILE__, ".rb")}"
  VERSION = "#{File.open(File.dirname(File.expand_path(__FILE__))+"/VERSION").read()}"
  
  attr_reader :options

  def initialize(arguments, stdin)
    @arguments = arguments
    @stdin = stdin
    
    # Set defaults
    @options = OpenStruct.new
    @options.verbose = false
    @options.quiet = false
    # TO DO - add additional defaults
  end

  # Parse options, check arguments, then process the command
  def run
    if parsed_options? && arguments_valid? 
      puts "Start at #{DateTime.now}\n\n" if @options.verbose
      output_options if @options.verbose # [Optional]
      process_arguments
      process_command
      puts "\nFinished at #{DateTime.now}" if @options.verbose
    else
      output_usage
    end
      
  end
  
  protected
  
    def parsed_options?
      # Specify options
      opts = OptionParser.new 
      opts.on('-v', '--version')      { output_version ; exit 0 }
      opts.on('-h', '--help')         { output_help }
      opts.on('-i', '--information')  { output_information }
      opts.on('-V', '--verbose')      { @options.verbose = true }  
      opts.on('-q', '--quiet')        { @options.quiet = true }
      opts.on('--show')               { @options.show = true }
      opts.on('--commit')             { @options.commit = true }
      opts.on('--rollback')           { @options.rollback = true }
      opts.on('--stop')               { @options.stop = true }
            
      opts.parse!(@arguments) rescue return false
      
      process_options
      true      
    end

    # Performs post-parse processing on options
    def process_options
      @options.verbose = false if @options.quiet
      puts "show me options" if @options.show
      exit 0
    end
    
    def output_options
      puts "Options:\n"
      
      @options.marshal_dump.each do |name, val|        
        puts "  #{name} = #{val}"
      end
    end

    # True if required arguments were provided
    def arguments_valid?
      # TO DO - implement your real logic here
      true if @arguments.length == 1 
    end
    
    # Setup the arguments
    def process_arguments
      # TO DO - place in local vars, etc
    end
    
    def output_help
      puts "Usage: #{NAME} [--options]"
      RDoc::usage('Options')
    end
    
    def output_information
      RDoc::usage()
    end

    def output_usage
      RDoc::usage('usage') # gets usage from comments above
    end
    
    def output_version
      config = ReadConfig.new('NOE')
      puts "#{NAME} #{VERSION}"
    end
    
    def process_command
      # TO DO - do whatever this app does
      
      #process_standard_input # [Optional]
    end

    def process_standard_input
      input = @stdin.read      
      # TO DO - process input
      
      # [Optional]
      # @stdin.each do |line| 
      #  # TO DO - process each line
      #end
    end
end


# TO DO - Add your Modules, Classes, etc


# Create and run the application
deployme = Deployme.new(ARGV, STDIN)
deployme.run

# vim: set ts=2 sw=2 sts=2 et si ai: 
