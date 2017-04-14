#!/usr/bin/perl

use strict;
use warnings;
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


use CGI qw();
my $c = CGI->new;
my gitHubHook = $c->header('text/plain');
if( 'POST' eq $c->request_method && $c->param( 'dl' ) )
{
    my ans = 'YES\n';
} else {
    my ans = 'NO\n';
}
my $filename = 'github-ans.log';
open( my $fh, '>', $filename ) or die "Could not open file '$filename' $!";
print $fh $gitHubHook;
print $fh $ans;
close $fh;
