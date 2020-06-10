<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Shop\Role;
use App\Models\Shop\Shop;
use App\Models\Shop\Shop_manager;
use Faker\Generator as Faker;

$factory->define(Shop_manager::class, function (Faker $faker) {
    return [
        'first_name'=> $faker->firstName,
        'last_name'=> $faker->lastName,
        'email' => $faker->unique()->safeEmail,
        'email_verified_at' => now(),
        'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
        // 'remember_token' => Str::random(10),
        'number' => $faker->phoneNumber,
        'role' => function(){
            return Role::first();
        },
        'shop_id' => function(){
            return Shop::all()->random();
        }
    ];
});
