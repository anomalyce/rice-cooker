<?php

namespace RiceCooker;

use Illuminate\Console\Command;
use Illuminate\Events\Dispatcher;
use Illuminate\Console\Application;
use Illuminate\Container\Container;
use Illuminate\Filesystem\FilesystemServiceProvider;

final class RiceCooker
{
    /**
     * Holds the application name.
     * 
     * @var string
     */
    protected $name;

    /**
     * Holds the application version.
     * 
     * @var string
     */
    protected $version;

    /**
     * Holds the application path.
     * 
     * @var string
     */
    protected $path;

    /**
     * Holds the Laravel Console Application object.
     * 
     * @var \Illuminate\Console\Application
     */
    public $console;

    /**
     * Holds the console output channel.
     * 
     * @var \Illuminate\Console\Command
     */
    public $output;

    /**
     * Holds the file manager.
     * 
     * @var \RiceCooker\FileManager
     */
    public $files;

    /**
     * Holds the cache manager.
     * 
     * @var \RiceCooker\CacheManager
     */
    public $cache;

    /**
     * Holds the config manager.
     * 
     * @var \RiceCooker\ConfigManager
     */
    public $config;

    /**
     * Holds the recipe manager.
     * 
     * @var \RiceCooker\RecipeManager
     */
    public $recipe;

    /**
     * Holds the installing state.
     * 
     * @var string
     */
    public const INSTALL = 'install';

    /**
     * Holds the uninstalling state.
     * 
     * @var string
     */
    public const UNINSTALL = 'uninstall';

    /**
     * Instantiate a new RiceCooker object.
     * 
     * @param  string  $name
     * @param  string  $version
     * @param  string  $path
     * @return void
     */
    final public function __construct($name, $version, $path)
    {
        $this->name = $name;
        $this->version = $version;
        $this->path = $path;

        $this->files = new FileManager($this);
        $this->cache = new CacheManager($this);
        $this->config = new ConfigManager($this);
        $this->recipe = new RecipeManager($this);

        $this->bootstrap();
    }

    /**
     * Bootstrap the application.
     * 
     * @return void
     */
    final protected function bootstrap(): void
    {
        $this->setupLaravel();
    }

    /**
     * Setup Laravel components.
     * 
     * @return void
     */
    final protected function setupLaravel(): void
    {
        $container = new Container;
        
        $events = new Dispatcher($container);

        $this->console = new Application($container, $events, $this->version);

        $this->console->setName($this->name);

        $container->instance('rice-cooker', $this);

        // $this->console->register(FilesystemServiceProvider::class);
        // var_dump($this->console->make('files'));
    }

    /**
     * Set the console output channel.
     * 
     * @param  \Illuminate\Console\Command  $command
     * @return void
     */
    public function setConsoleCommand(Command $command)
    {
        $this->output = $command;
    }

    /**
     * Handle relative and absolute file paths.
     * 
     * @param  string  $path
     * @param  string  $baseDirectory
     * @return string
     */
    public function handleFilepath($path, $baseDirectory)
    {
        $baseDirectory = rtrim($baseDirectory, '/');

        if (is_null($path)) {
            return $baseDirectory;
        }

        $path = ltrim($path, './');

        return sprintf( '%s/%s', $baseDirectory, $path );
    }

    /**
     * Write a greeting message.
     * 
     * @return void
     */
    public function writeGreeting()
    {
        $message = '<fg=white;options=bold>Heating the boiler...</>';

        $this->output->line("");
        $this->output->line("<fg=black;options=bold>╭─[</> ${message} <fg=black;options=bold>]─╼</>");
    }

    /**
     * Write a recipe message.
     * 
     * @param  string  $recipe
     * @param  string  $hook  null
     * @return void
     */
    public function writeRecipe($recipe, $hook = null)
    {
        if (! is_null($hook)) {
            $hook = ":${hook}";
        }

        $message = "<fg=green>\\${recipe}</><fg=black;options=bold>${hook}</>";

        $this->output->line("<fg=black;options=bold>│</>");
        $this->output->line("<fg=black;options=bold>│  ╭─[</> ${message} <fg=black;options=bold>]</>");
        $this->output->line("<fg=black;options=bold>╰──┤</>");
    }

    /**
     * Write several option messages.
     * 
     * @param  array  $options
     * @return void
     */
    public function writeOptions(array $options)
    {
        $options = array_filter($options, function ($value) {
            return $value;
        });

        if (empty($options)) {
            return;
        }

        $this->output->line("<fg=black;options=bold>│</>");

        foreach ($options as $label => $value) {
            $this->output->line("<fg=black;options=bold>├─┈┈┈╼</> ${label} <fg=white;options=bold>${value}</>");
        }

        $this->output->line("<fg=black;options=bold>│</>");
    }

    /**
     * Write a pipe message.
     * 
     * @param  string  $message
     * @return void
     */
    public function log($message)
    {
        $this->output->line("   <fg=black;options=bold>╰─┈┈┈╼</> <fg=white>${message}</>");
    }

    /**
     * Write a command message.
     * 
     * @param  string  $command
     * @return void
     */
    public function command($command)
    {
        if (! $this->output->getOutput()->isVerbose()) {
            return;
        }

        $this->output->line("   <fg=black;options=bold>│    $</>  <fg=yellow>${command}</>");
    }

    /**
     * Write a command output message.
     * 
     * @param  string  $output
     * @return void
     */
    public function commandOutput($output)
    {
        if (! $this->output->getOutput()->isVeryVerbose()) {
            return;
        }

        foreach (explode(PHP_EOL, trim($output, PHP_EOL)) as $line) {
            $this->output->line("   <fg=black;options=bold>│       ${line}</>");
        }
    }

    /**
     * Write a command response code.
     * 
     * @param  string  $code
     * @return void
     */
    public function commandResponse($code)
    {
        if (! $this->output->getOutput()->isDebug()) {
            return;
        }

        $this->output->line("   <fg=black;options=bold>│    >  </><fg=yellow>${code}</>");
    }

    /**
     * Write a recipe separator message.
     * 
     * @return void
     */
    public function writeSeparator()
    {
        $this->output->line("<fg=black;options=bold>╭──╯</>");
    }

    /**
     * Write a farewell message.
     * 
     * @return void
     */
    public function writeFarewell()
    {
        $message = '<fg=white;options=bold>The rice was cooked, bon appétit!</>';

        $this->output->line("<fg=black;options=bold>│</>");
        $this->output->line("<fg=black;options=bold>╰─[</> ${message} <fg=black;options=bold>]─╼</>");
        $this->output->line("");
    }
}
