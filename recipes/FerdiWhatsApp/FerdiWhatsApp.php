<?php

namespace FerdiWhatsApp;

use RiceCooker\RiceCooker;

class FerdiWhatsApp
{
    /**
     * Acts as a pre-hook for the install and/or uninstall hooks.
     *
     * @param  \RiceCooker\RiceCooker  $cooker
     * @param  string  $hook  install|uninstall
     * @return void
     */
    public function setup(RiceCooker $cooker, $hook): void
    {
        if ($hook === RiceCooker::INSTALL) {
            $cooker->cache->create(__CLASS__);
        }
    }

    /**
     * Define the pipes that shall run on installation.
     *
     * @return array
     */
    public function install(): array
    {
        return [
            \FerdiWhatsApp\Pipes\DarkWhatsApp\DownloadRepository::class,
            \FerdiWhatsApp\Pipes\DarkWhatsApp\SubstituteVariables::class,
            // \FerdiWhatsApp\Pipes\DarkWhatsApp\FerdiConverter::class,
            // \FerdiWhatsApp\Pipes\DarkWhatsApp\Publish::class,
        ];
    }

    /**
     * Define the pipes that shall run on uninstallation.
     *
     * @return array
     */
    public function uninstall(): array
    {
        return [
            \FerdiWhatsApp\Pipes\DarkWhatsApp\Unpublish::class,
        ];
    }

    /**
     * Acts as a post-hook for the install and/or uninstall hooks.
     *
     * @param  \RiceCooker\RiceCooker  $cooker
     * @param  string  $hook  install|uninstall
     * @return void
     */
    public function cooldown(RiceCooker $cooker, $hook): void
    {
        if ($hook === RiceCooker::INSTALL) {
            $cooker->cache->destroy(__CLASS__);
        }
    }
}
