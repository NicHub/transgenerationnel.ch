#!/usr/bin/perl

use strict;
use warnings;
use POSIX       qw( strftime );

BEGIN {
  print "Content-type: text/plain\n\n";
}

my $pwd = `pwd`; chomp( $pwd );
my $now = strftime( '%Y-%m-%d %H:%M:%S', localtime );
print "$now\n";
my $filename = 'time.txt';
open( my $fh, '>', $filename ) or die "Could not open file '$filename' $!";
print $fh $now;
close $fh;

use Git;
my $msg = "";
my $repo = Git->repository( Directory => $pwd );
# $msg = $repo->command( "status" );
# print $msg;
$msg = $repo->command( "pull" );
print $msg;
print "END\n"
