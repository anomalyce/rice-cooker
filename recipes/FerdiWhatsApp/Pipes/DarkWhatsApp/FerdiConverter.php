<?php

namespace FerdiWhatsApp\Pipes\DarkWhatsApp;

use Closure;

class FerdiConverter
{
    /**
     * Run the included conversion tool for Ferdi.
     * 
     * @param  \RiceCooker\RiceCooker  $cooker
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($cooker, Closure $next)
    {
        $cooker->log('Converting from Stylus to Ferdi');

        $cooker->files->chmod(
            $cooker->cache->path('./whatsapp.sh'),
            '+x'
        );
        
        $cooker->files->run(
            $cooker->cache->path('./whatsapp.sh')
        );

        return $next($cooker);
    }
}
