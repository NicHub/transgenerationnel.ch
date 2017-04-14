#!/usr/bin/perl

use strict;
# use warnings;
use POSIX       qw( strftime );
use Git;

print "Content-type: text/plain\n\n";

# Enregistre l’heure de la dernière synchronisation dans un fichier texte.
my $now = strftime( '{"github_webhook_last_pull_time":"%Y-%m-%d %H:%M:%S"}', localtime );
my $filename = 'github-webhook-log.json';
open( my $fh, '>', $filename ) or die "Could not open file '$filename' $!";
print $fh $now;
close $fh;

# Synchronisation du dépôt Git.
my $pwd = `pwd`; chomp( $pwd );
my $repo = Git->repository( Directory => $pwd );
my $msg = $repo->command( "pull" );

# Test si POST présent
use CGI qw();
my $c = CGI->new;
my $gitHubHook = $c->header('text/plain');
my $ans = '';
if( !($c->request_method eq 'POST' && $c->param( 'payload' )) )
{
    $ans = "NO\n";
} else {
	$ans = "YES\n";
}
my $filename = 'github-ans.log';
open( my $fh, '>', $filename ) or die "Could not open file '$filename' $!";
print $fh $ans;
print $fh $gitHubHook;
close $fh;
