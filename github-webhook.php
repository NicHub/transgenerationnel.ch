<?php

date_default_timezone_set( 'Europe/Paris' );
$curDateTime = date( 'Y-m-d\<\b\r \/\>H:i:s' );

main();

function main()
{
    if( isset( $_POST[ 'payload' ] ) )
    {
        writeDateToJsonFile();
        gitPull();
    }
}

function writeDateToJsonFile()
{
    global $curDateTime;
    $myfile = fopen( "github-webhook-log.json", "w" ) or die ( "Impossible d’ouvrir “github-webhook.log” en écriture" );
    fwrite( $myfile, '{"github_webhook_last_pull_time":"' );
    fwrite( $myfile, $curDateTime );
    fwrite( $myfile, '"}' );
    fclose( $myfile );
}

function gitPull()
{
    chdir( '$HOME/web-transgenerationnel.ch/' );
    $cmd = "git pull > /dev/null &";
    exec( $cmd );
}

?>
