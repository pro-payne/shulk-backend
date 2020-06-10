<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Customer\Customer;
use Faker\Generator as Faker;

$factory->define(Customer::class, function (Faker $faker) {
    return [
        'first_name'=> $faker->firstName,
        'last_name'=> $faker->lastName,
        'email' => $faker->unique()->safeEmail,
        'username' => $faker->word(6),
        'email_verified_at' => now(),
        'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
        // 'remember_token' => Str::random(10),
        'number' => $faker->phoneNumber,
    ];
});
