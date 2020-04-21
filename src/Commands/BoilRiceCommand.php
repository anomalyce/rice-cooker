<?php

namespace RiceCooker\Commands;

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
    protected $signature = '
        boil
        {--dist-directory=}
        {--cache-directory=}
        {--config=}
    ';

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
        $pipeline = new Pipeline($this->laravel);

        $cooker = $this->laravel->make('rice-cooker');
        $cooker->setConsoleCommand($this);

        $cooker->writeGreeting();

        $cooker->writeOptions([
            'Publishing assets to' => $this->option('dist-directory'),
            'Storing cache in' => $this->option('cache-directory'),
            'Reading configuration from' => $this->option('config'),
        ]);

        foreach ($this->getRecipes() as $data) {
            list ($recipe, $hook) = $data;

            $cooker->writeRecipe($recipe, $hook);

            $pipeline->send($cooker)->through((new $recipe)->$hook())->thenReturn();

            $cooker->writeSeparator();
        }

        $cooker->writeFarewell();
    }

    /**
     * Retrieve all of the recipes that are supposed to be installed.
     * 
     * @return array
     */
    protected function getRecipes(): array
    {
        return [
            [ \FerdiWhatsApp\FerdiWhatsApp::class, 'install' ],
            [ \FerdiWhatsApp\FerdiWhatsApp::class, 'uninstall' ],
        ];
    }
}
