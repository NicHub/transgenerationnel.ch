#!/usr/bin/perl

use strict;
# use warnings;
use POSIX       qw( strftime );
use Git;

print "Content-type: text/plain\n\n";

# Heure de l’appel de ce script
my $now = strftime( '{"github_webhook_last_pull_time":"%Y-%m-%d %H:%M:%S"}', localtime );

# On quitte si le POST est absent
use CGI qw();
my $c = CGI->new;
my $gitHubHook = $c->header('text/plain');
if( !($c->request_method eq 'POST' && $c->param( 'payload' )) )
{
  my $filename = 'error.log';
  open( my $fh, '>', $filename ) or die "Could not open file '$filename' $!";
  print $fh "Erreur\n$now";
  close $fh;
  exit;
}

# Enregistre l’heure de la dernière synchronisation dans un fichier texte.
my $filename = 'github-webhook-log.json';
open( my $fh, '>', $filename ) or die "Could not open file '$filename' $!";
print $fh $now;
close $fh;

# Synchronisation du dépôt Git.
my $pwd = `pwd`; chomp( $pwd );
my $repo = Git->repository( Directory => $pwd );
my $msg = $repo->command( "pull" );
