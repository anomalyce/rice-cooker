<?php

namespace RiceCooker;

use Closure;
use League\Flysystem\Filesystem;
use Symfony\Component\Process\Process;
use League\Flysystem\Local\LocalFilesystemAdapter;
use Symfony\Component\Process\Exception\ProcessFailedException;

class FileManager
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
     * Whether the commands & their outputs should be printed.
     * 
     * @var boolean
     */
    protected $silent = false;

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
        
        $this->filesystem = new Filesystem(
            new LocalFilesystemAdapter($this->basepath)
        );
    }

    /**
     * Silence any commands and their outputs.
     * 
     * @param  \Closure  $callback
     * @return mixed
     */
    public function silent(Closure $callback)
    {
        $this->silent = true;

        $response = $callback($this);

        $this->silent = false;

        return $response;
    }

    /**
     * Execute a command and return it's output.
     * 
     * @param  array  $parameters
     * @return mixed
     */
    public function run(array $parameters)
    {
        if (! $this->silent) {
            $this->cooker->command($command = implode(' ', $parameters));
        }

        $process = new Process($parameters);

        $process->run(function ($type, $buffer) {
            if ($this->silent) {
                return;
            }

            $this->cooker->commandOutput($buffer);
        });

        if (! $process->isSuccessful()) {
            throw new ProcessFailedException($process);
        }

        $this->cooker->commandResponse($process->getExitCode());

        return $process;
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
        $response = $this->run(['git', 'clone', $repository, $destination]);

        return $response->getExitCode();
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
        $response = $this->run("patch ${target} ${patch} > ${destination}");

        return $response->getExitCode();
    }

    /**
     * Change directory.
     * 
     * @param  string  $path
     * @return integer
     */
    public function cd($path): int
    {
        $response = $this->run("cd ${path}");

        return $response->getExitCode();
    }

    /**
     * Create a directory.
     * 
     * @param  string  $path
     * @return integer
     */
    public function mkdir($path): int
    {
        $response = $this->run(['mkdir', '-p', $path]);

        return $response->getExitCode();
    }

    /**
     * Remove a directory.
     * 
     * @param  string  $path
     * @return integer
     */
    public function rmdir($path): int
    {
        $response = $this->run(['rm', '-r', $path]);

        return $response->getExitCode();
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
        $response = $this->run("cp ${source} ${destination}");

        return $response->getExitCode();
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

        $response = $this->run("chmod${flags} ${permissions} ${path}");

        return $response->getExitCode();
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

        $response = $this->run("chmod${flags} ${ownership} ${path}");

        return $response->getExitCode();
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
        $response = $this->run("ln -s ${source} ${target}");

        return $response->getExitCode();
    }
}
