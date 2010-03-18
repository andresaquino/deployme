#!/usr/bin/env perl 
# vim: set ts=2 sw=2 sts=2 et si ai: 

# deployme.pl -- Do you want to deploy your components automagically?
# ----------------------------------------------------------------------------
# (c) 2010 StrategyLabs!
# Andres Aquino <andres.aquino@gmail.com>
# 

# 
use IO::File;
use File::Copy;
use File::Basename;
use Time::localtime;
use Getopt::Long;
use Pod::Usage;
use strict;

# options:
#   start,    start daemon in memory
#   stop,     stop daemon and all pending deployment process
#   version,  shows deployme version
#   report,   report of (all) deployed components 
#   commit,   execute 
#   rollback, rollback to previous version
#   help,     shows help of deployme application
my %option;

# configuration setup
my %config;

my ($apname, $appath, $apsuffix);

#
# FUNCTIONS

# read config file
sub configfile
{
  my $cfgfile = new IO::File;
  my $data;

  # get name and path of application 
  ($apname, $appath, $apsuffix) = fileparse($0,".pl");

  # validar que exista el archivo de configuracion o
  # incluir una conf por defecto...
  $cfgfile->open("$appath/$apname.rc", O_RDONLY);
  while ( $data = $cfgfile->getline() )
  {
    chomp($data);
    $data =~ s/^\s+//;
    $data =~ s/\s+$//;

    if ( $data !~ /^#/ && length($data) > 10 )
    {
      my ($var, $value) = split(/\s*=\s*/, $data, 2);
      $config{$var} = $value;
    }
  }
  #while( my ($k, $v) = each %config ) {
  #  print "$k = $v\n";
  #}
  $cfgfile->close();

}


#
# MAIN

# read config
configfile();

# read user options
GetOptions( 'start'         => \$option{'start'},
            'stop'          => \$option{'stop'},
            'version'       => \$option{'version'},
            'report=s@'     => \$option{'report'},
            'commit=s@'     => \$option{'commit'},
            'rollback=s@'   => \$option{'rollback'},
            'manual'        => \$option{'manual'},
            'help'          => \$option{'help'})
  or pod2usage(-verbose=>0);

pod2usage(-verbose=>1) if ($option{'help'});

pod2usage(-verbose=>2) if ($option{'manual'});

# 
#
# mostrar la version de la aplicacion
if ($option{'version'} )
{
   my $appversion="0.2rc";
   print "deployme $appversion\n";
   exit(0);
}


__END__

=head1 NAME

  deployme -- Do you want to deploy your components automagically?

=head1 SYNOPSIS

  deployme [ --start | --stop ]

  deployme [ --report | --report pendings | --report currents ]

  deployme [ --report id=ID ]

  deployme [ --commit id=ID | --commit pendings ]

  deployme [ --rollback id=ID ]

=head1 OPTIONS

=over 4

=item B<--version>

  Shows version.

=item B<--help>

  Shows help.

=item B<--report>

  Report.
  $ deployme --report
   ID   | RFC       | HOST     | COMPONENT           | FINGER
   -----+-----------+----------+---------------------+-------------
   0031 | 1002C0090 | mexhpoe1 | ServiciosOEix.ear   | e2fd..61c4
   0038 | 1004C0080 | mexhpsdf | PUC.war             | c998..2059
   ...

  $ deployme --report pendings
   ID   | RFC       | HOST     | COMPONENT           | FINGER       | STATUS
   -----+-----------+----------+---------------------+--------------+-------------
   0040 | 1002C0090 | mexhpssd | ServiciosOEix.ear   | e2fd..61c4   | DEPLOYING
   0042 | 1004C0080 | mxhpdst2 | PUC.war             | c998..2059   | TOAPPROVE
   0045 | 1008C0040 | mexhpty2 | CCIe.ear            | c989..ab46   | TOAPPROVE
   ...

  $ deployme --report currents
   ID   | RFC       | HOST     | COMPONENT           | FINGER       | STATUS
   -----+-----------+----------+---------------------+--------------+-------------
   0050 | 1002C0090 | mexhpddf | ServiciosOEix.ear   | e2fd..61c4   | SUCCESSFULL
   0053 | 1004C0080 | mxhpsdf3 | PUC.war             | c998..2059   | FAILED
   ...

  $ deployme --report id=0045
   Report of commit 0045 order
   Id           | 0045
   RFC          | 1002C0090
   Approved by  | Diego Ubach <diego.ubach@nextel.com.mx>
   Required by  | Joel Reyes <joel.reyes@nextel.com.mx>
   -------------+--------------------------------------------------------------------
   Time         | 20100219-1645
   Host         | mexhpdds
   Address      | 10.103.138.157
   Workdir      | /opt/web8sp6/bea/user_projects/nxtcomp/wlinxt
   Status       | SUCCESS
   Link         | CCIe.ear -> CCIe.ear.CURRENT
   -------------+
   Link         | CCIe.CURRENT
   Source       | 20091002/CCIe.ear
   Fingerprint  | e2fd5b9cb3a5678848e9ade4ecff61c4
   Filesize     | 12,600Kb
   -------------+ 
   Link         | CCIe.PREVIOUS
   Source       | 20090928/CCIe.ear
   Fingerprint  | 21b3dfe72ce3b7f4f4a81aed9ff0ca6c
   Filesize     | 11,469Kb


=item B<--commit>

  Commit.
  $ deployme --commit id=0045
   Great!, commit over 0045 order in progress.
   Id           | 0045
   RFC          | 1002C0090
   Approved by  | Diego Ubach <diego.ubach@nextel.com.mx>
   Required by  | Joel Reyes <joel.reyes@nextel.com.mx>
   -------------+--------------------------------------------------------------------
   Host         | mexhpdds
   Address      | 10.103.138.157
   Workdir      | /opt/web8sp6/bea/user_projects/nxtcomp/wlinxt
   Status       | CCIe.ear -> CCIe.ear.CURRENT
   -------------+
   Source       | 20091109/CCIe.ear
   Fingerprint  | c998aa118ac78a6946d8337e27be2059
   -------------+
   Link         | CCIe.CURRENT
   Source       | 20091002/CCIe.ear
   Fingerprint  | e2fd5b9cb3a5678848e9ade4ecff61c4
   -------------+ 
   Link         | CCIe.PREVIOUS
   Source       | 20090928/CCIe.ear
   Fingerprint  | 21b3dfe72ce3b7f4f4a81aed9ff0ca6c

=item B<--rollback>

  Rollback

  $ deployme --rollback id=0046
   Dawm!, rollback over 0046 order in progress.
   Id           | 0046
   RFC          | 1002C0110
   Approved by  | Daniel Valdivia <daniel.valdivia@nextel.com.mx>
   Required by  | Israel Barranco <israel.barranco@nextel.com.mx>
   -------------+--------------------------------------------------------------------
   Workdir      | /opt/web8sp6/bea/user_projects/nxtcomp/wlinxt
   Status       | CCIe.ear -> CCIe.ear.PREVIOUS
   -------------+
   Link         | CCIe.CURRENT
   Source       | 20091002/CCIe.ear
   Fingerprint  | e2fd5b9cb3a5678848e9ade4ecff61c4
   -------------+ 
   Link         | CCIe.PREVIOUS
   Source       | 20090928/CCIe.ear
   Fingerprint  | 21b3dfe72ce3b7f4f4a81aed9ff0ca6c


=pod OSNAMES

   Linux, OSX, HPUX

=pod SCRIPT CATEGORIES

   Shell, bash, sh

=cut

