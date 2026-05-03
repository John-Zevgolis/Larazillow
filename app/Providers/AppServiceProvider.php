<?php

namespace App\Providers;

use App\Policies\NotificationPolicy;
use Gate;
use Illuminate\Notifications\DatabaseNotification;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\URL;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        if (app()->environment('production') || env('APP_ENV') === 'production') {
            URL::forceScheme('https');
        }

        Gate::policy(DatabaseNotification::class, NotificationPolicy::class);
    }
}
