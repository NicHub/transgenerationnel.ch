#!/usr/bin/perl

use strict;
use warnings;
use POSIX       qw( strftime );
use Git;

print "Content-type: text/plain\n\n";

# Enregistre l’heure de la dernière synchronisation dans un fichier texte.
my $now = strftime( '%Y-%m-%d %H:%M:%S', localtime );
my $filename = 'time.txt';
open( my $fh, '>', $filename ) or die "Could not open file '$filename' $!";
close $fh;

# Synchronisation du dépôt Git.
my $pwd = `pwd`; chomp( $pwd );
my $repo = Git->repository( Directory => $pwd );
my $msg = $repo->command( "pull" );
