<?php

namespace FerdiWhatsApp\Pipes\DarkWhatsApp;

use Closure;

class Unpublish
{
    /**
     * Substitute certain variables to adjust for our own theme.
     * 
     * @param  \RiceCooker\RiceCooker  $cooker
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($cooker, Closure $next)
    {
        $cooker->log('Unpublishing the Dark WhatsApp changes');

        // $cooker->files->removeDirectory($cooker->recipe->publishedPath());

        return $next($cooker);
    }
}
