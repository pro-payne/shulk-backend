<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Shop\Shop;
use App\Models\Shop\Category;
use Faker\Generator as Faker;

$factory->define(Shop::class, function (Faker $faker) {
    $company = $faker->company;
    $username = username($company, 'shop');
    return [
        'name'=> $company,
        'description' => $faker->paragraph(3, true),
        'number' => $faker->e164PhoneNumber,
        'username' => $username,
        'location' => $faker->address,
        'category_id'=> function(){
            return Category::all()->random();
        },
        'picture' => $faker->imageUrl(300, 300, 'cats'),
        'cover' => $faker->imageUrl(800, 600)
    ];
});
