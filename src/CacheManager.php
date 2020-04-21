<?php

namespace RiceCooker;

class CacheManager
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
    }
    
    /**
     * Retrieve the cache path.
     * 
     * @param  string  $relativePath  null
     * @return string|null
     */
    public function path($relativePath = null): ?string
    {
        return $this->cooker->handleFilepath($relativePath, 'CACHE/');
    }
}
