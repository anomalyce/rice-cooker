<?php

namespace RiceCooker\Commands;

use Closure;
use Throwable;
use RiceCooker\RiceCooker;
use Illuminate\Console\Command;
use Illuminate\Pipeline\Pipeline;

class BoilRiceCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'boil {--uninstall} {--dist=} {--cache=} {--config=}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Runs all of the given recipes.';

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $cooker = $this->prepareMeal();

        $cooker->writeGreeting();
        $cooker->writeOptions([
            'Publishing assets to' => $this->option('dist'),
            'Storing cache in' => $this->option('cache'),
            'Reading configuration from' => $this->option('config'),
        ]);

        $this->ingredient(function ($recipe, $hook) use ($cooker) {
            $cooker->writeRecipe($recipe, $hook);
        });

        $this->boil($cooker);

        $cooker->writeFarewell();
    }

    /**
     * Prepare the rice cooker.
     * 
     * @return \RiceCooker\RiceCooker
     */
    protected function prepareMeal()
    {
        $cooker = $this->laravel->make('rice-cooker');

        $cooker->setConsoleCommand($this);

        $cooker->files->setBasePath($this->option('dist'));
        $cooker->cache->setBasePath($this->option('cache'));
        $cooker->config->setFile($this->option('config'));

        return $cooker;
    }

    /**
     * Check if the boiler is supposed to install.
     * 
     * @return boolean
     */
    protected function isInstalling()
    {
        return ! $this->isUninstalling();
    }

    /**
     * Check if the boiler is supposed to uninstall.
     * 
     * @return boolean
     */
    protected function isUninstalling()
    {
        return $this->option('uninstall');
    }

    /**
     * Set the ingredient callback.
     * 
     * @param  \Closure  $callback
     * @return void
     */
    protected function ingredient(Closure $callback)
    {
        $this->ingredient = $callback;
    }

    /**
     * Boil the rice.
     * 
     * @param  \RiceCooker\RiceCooker  $cooker
     * @return void
     */
    protected function boil(RiceCooker $cooker)
    {
        $pipeline = new Pipeline($this->laravel);

        $hook = $this->isInstalling() ? RiceCooker::INSTALL : RiceCooker::UNINSTALL;

        foreach ($this->getRecipes() as $identifier) {
            $recipe = new $identifier;

            $recipe->setup($cooker, $hook);

            try {
                call_user_func_array($this->ingredient, [$identifier, $hook]);

                $pipeline->send($cooker)->through($recipe->$hook())->thenReturn();
            } catch (Throwable $e) {
                //
            }

            $recipe->cooldown($cooker, $hook);
        }

        $cooker->writeSeparator();
    }

    /**
     * Retrieve all of the recipes that are supposed to be installed.
     * 
     * @return array
     */
    protected function getRecipes(): array
    {
        return [
            \FerdiWhatsApp\FerdiWhatsApp::class,
        ];
    }
}
