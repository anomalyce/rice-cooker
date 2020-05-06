<?php

namespace FerdiWhatsApp\Pipes\DarkWhatsApp;

use Closure;
use FerdiWhatsApp\FerdiWhatsApp;

class DownloadRepository
{
    /**
     * Download the Dark WhatsApp git repository.
     * 
     * @param  \RiceCooker\RiceCooker  $cooker
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($cooker, Closure $next)
    {
        $cooker->log('Cloning the Dark WhatsApp repository');

        $cooker->files->gitClone(
            'https://github.com/vednoc/dark-whatsapp.git',
            $cooker->cache->path(FerdiWhatsApp::class)
        );

        return $next($cooker);
    }
}
