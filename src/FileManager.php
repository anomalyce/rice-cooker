<?php

namespace RiceCooker;

class FileManager
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
     * Execute a command and return it's exit code.
     * 
     * @param  string  $command
     * @return integer
     */
    public function run($command): int
    {
        return 1;
    }

    /**
     * Git clone a repository.
     * 
     * @param  string  $repository
     * @param  string  $destination  .
     * @return integer
     */
    public function gitClone($repository, $destination = '.'): int
    {
        return $this->run("git clone ${repository} ${destination}");
    }

    /**
     * Patch a file.
     * 
     * @param  string  $target
     * @param  string  $patch
     * @param  string  $destination
     * @return integer
     */
    public function patch($target, $patch, $destination): int
    {
        // Create a backup of the file in case the destination is null.
        if (is_null($destination)) {
            $destination = $target;

            $this->copy($target, $destination.'.orig');
        }

        // return xdiff_file_patch($target, $patch, $destination);
        return $this->run("patch ${target} ${patch} > ${destination}");
    }

    /**
     * Change directory.
     * 
     * @param  string  $path
     * @return integer
     */
    public function cd($path): int
    {
        return $this->run("cd ${path}");
    }

    /**
     * Create a directory.
     * 
     * @param  string  $path
     * @return integer
     */
    public function mkdir($path): int
    {
        return $this->run("mkdir -p ${path}");
    }

    /**
     * Copy a file.
     * 
     * @param  string  $source
     * @param  string  $destination
     * @return integer
     */
    public function copy($source, $destination): int
    {
        return $this->run("cp ${source} ${destination}");
    }

    /**
     * Change the permissions of a path.
     * 
     * @param  string  $path
     * @param  string  $permissions
     * @param  boolean  $recursive  false
     * @return integer
     */
    public function chmod($path, $permissions, $recursive = false): int
    {
        $flags = $recursive ? ' -R' : null;

        return $this->run("chmod${flags} ${permissions} ${path}");
    }

    /**
     * Change the ownership of a path.
     * 
     * @param  string  $path
     * @param  string  $ownership
     * @param  boolean  $recursive  false
     * @return integer
     */
    public function chown($path, $ownership, $recursive = false): int
    {
        $flags = $recursive ? ' -R' : null;

        return $this->run("chmod${flags} ${ownership} ${path}");
    }

    /**
     * Create a symlink.
     * 
     * @param  string  $source
     * @param  string  $target
     * @return integer
     */
    public function symlink($source, $target): int
    {
        return $this->run("ln -s ${source} ${target}");
    }
}
