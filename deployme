#!/usr/bin/env perl 
# vim: set ts=2 sw=2 sts=2 et si ai: 

# deployme.pl - Do you want to deploy your components automagically?
# =-=
# (c) 2010 StrategyLabs!
# Andres Aquino <andres.aquino@gmail.com>
# 

# 
package Deployme;

use warnings;
use strict;

use Log::Log4perl;
use Proc::Daemon;
use Proc::PID::File;
use Getopt::Long;

# configuration setup
my %config;
my %option;

my $setup;
my $appversion="1.0";

my ($apname, $appath, $apsuffix);

# log4perl
my $log;

# FUNCTIONS
#

# read user options
# options:
#   start,    start daemon in memory
#   stop,     stop daemon and all pending deployment process
#   version,  shows deployme version
#   report,   report of (all) deployed components 
#   commit,   execute 
#   rollback, rollback to previous version
#   help,     shows help of deployme application
GetOptions( 
  'start'         => \$option{'start'},
  'stop'          => \$option{'stop'},
  'version'       => \$option{'version'},
  'status=s'      => \$option{'status'},
  'report=s'      => \$option{'report'},
  'commit=s'      => \$option{'commit'},
  'rollback=s'    => \$option{'rollback'},
  'manual'        => \$option{'manual'},
  'help'          => \$option{'help'})
or pod2usage(-verbose=>0);

if($option{'help'})
{
  pod2usage(-verbose=>1);
}

if($option{'manual'})
{
  pod2usage(-verbose=>2);
}

# mostrar la version de la aplicacion
#
if ($option{'version'})
{
  print "deployme $appversion\n";
  exit(0);
}

# initilize environment
#
Log::Log4perl->init_and_watch("log4perl.conf", 10);
$log = Log::Log4perl->get_logger(__PACKAGE__);
$log->info("Deployme v$appversion");

# main section
#
#MAIN:
#{
  # daemonize
  $log->debug("Running in background mode");
  Proc::Daemon::Init;

  # if already running, then exit
  if(Proc::PID::File->running() && $option{'start'})
  {
    # include log lines
    $log->debug("Running in forefront mode");
    #exit(0);
  }

  while (1)
  {
    $log->info("Send message");
    sleep(5);
  }
#}

