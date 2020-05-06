<?php

namespace FerdiWhatsApp\Pipes\DarkWhatsApp;

use Closure;

class SubstituteVariables
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
        $cooker->log('Substituting theme variables');

        $cooker->files->patch(
            $cooker->cache->path('./wa.user.css'),
            $cooker->recipe->path('./patches/variables.patch'),
            null
        );

        return $next($cooker);
    }
}
