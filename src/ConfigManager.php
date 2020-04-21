<?php

namespace RiceCooker;

use Dotenv\Dotenv;

class ConfigManager
{
    /**
     * Holds the Rice Cooker object.
     * 
     * @var \RiceCooker\RiceCooker
     */
    protected $cooker;

    /**
     * Instantiate a new object.
     * 
     * @param  \RiceCooker\RiceCooker  $cooker
     * @return void
     */
    public function __construct(RiceCooker $cooker)
    {
        $this->cooker = $cooker;

        $dotenv = Dotenv::createImmutable($this->getConfigPaths(), $this->getConfigNames(), true);
        $dotenv->load();
    }

    /**
     * Retrieve all possible configuration directories.
     * 
     * @return array
     */
    protected function getConfigPaths(): array
    {
        return [
            '~/.config/rice-cooker/',
            '~/.config/',
            '~/',
            __DIR__.'/../',
        ];   
    }

    /**
     * Retrieve all possible configuration names.
     * 
     * @return array
     */
    protected function getConfigNames(): array
    {
        return [
            'rice-cooker.ini',
            'ricecooker.ini',
            '.rice-cooker',
            '.ricecooker',
            'rice-cooker',
            'ricecooker',
        ];   
    }
}
