<?php

namespace RiceCooker;

class RecipeManager
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
     * Retrieve the recipe path.
     * 
     * @param  string  $relativePath  null
     * @return string|null
     */
    public function path($relativePath = null): ?string
    {
        return $this->cooker->handleFilepath($relativePath, 'RECIPE/');
    }

    /**
     * Retrieve the published recipe path.
     * 
     * @param  string  $relativePath  null
     * @return string|null
     */
    public function publishedPath($relativePath = null): ?string
    {
        return $this->cooker->handleFilepath($relativePath, 'DIST/');
    }
}
