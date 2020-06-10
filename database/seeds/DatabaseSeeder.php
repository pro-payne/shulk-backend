<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // factory(App\Models\Shop\Category::class, 8)->create();
        // factory(App\Models\Shop\Sub_category::class, 30)->create();
        factory(App\Models\Shop\Shop::class, 20)->create();
        // factory(App\Models\Shop\Product::class, 50)->create();
        // factory(App\Models\Customer\Customer::class, 5)->create();
        // factory(App\Models\Shop\Role::class, 1)->create();

    }
}
