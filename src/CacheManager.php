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
     * Holds the base path.
     * 
     * @var string
     */
    protected $basepath;

    /**
     * Holds all of the cache directories.
     * 
     * @var array
     */
    protected $caches = [];

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
     * Set the base path.
     * 
     * @param  string  $path
     * @return void
     */
    public function setBasePath($path)
    {
        $this->basepath = $path;
    }
    
    /**
     * Retrieve the cache path.
     * 
     * @param  string  $relativePath  null
     * @return string|null
     */
    public function path($relativePath = null): ?string
    {
        if (isset($this->caches[$relativePath])) {
            $relativePath = $this->caches[$relativePath];
        }

        return $this->cooker->handleFilepath($relativePath, $this->basepath);
    }

    /**
     * Create a new cache directory.
     * 
     * @param  string  $identifier
     * @return string
     */
    public function create($identifier)
    {
        $this->caches[$identifier] = ($cache = md5($identifier));

        return $this->cooker->files->silent(function ($files) use ($identifier) {
            $files->mkdir($path = $this->path($identifier));

            return $path;
        });
    }

    /**
     * Destroy the last cache directory.
     * 
     * @param  string  $identifier
     * @return string
     */
    public function destroy($identifier)
    {
        if (! isset($this->caches[$identifier])) {
            return;
        }

        $path = $this->cooker->files->silent(function ($files) use ($identifier) {
            $files->rmdir($path = $this->path($identifier));

            return $path;
        });

        unset($this->caches[$identifier]);

        return $path;
    }
}
