<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Shop\Category;
use Faker\Generator as Faker;
use App\Models\Shop\Shop_category;

$factory->define(Category::class, function (Faker $faker) {
    return [
        'name' => $faker->word,
        'picture' => $faker->imageUrl(300, 300)
    ];
});
