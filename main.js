"use strict";


$( document ).ready( function() {



  // Lit l’heure de la dernière mise à jour des fichiers
  // (pull de Github avec Webhook)
  ( function() {
    var last_update = $( 'p#last-update' );
    // On ne fait la requête que si p#last-update existe sur la page
    if( last_update.length > 0 )
    {
      $.getJSON( "/github-webhook-log.json", function( data ) {
        last_update.html( "Dernière mise à jour<br/>" + data.github_webhook_last_pull_time );
      });
    }
  })();



});
