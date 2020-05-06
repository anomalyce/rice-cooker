<?php

namespace FerdiWhatsApp\Pipes\DarkWhatsApp;

use Closure;

class Publish
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
        $cooker->log('Publishing the Dark WhatsApp changes');

        $cooker->files->symlink(
            $cooker->cache->path('./darkmode.css'), 
            $cooker->recipe->publishedPath('./darkmode.css')
        );

        return $next($cooker);
    }
}
