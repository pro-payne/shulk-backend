<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Shop\Category;
use Faker\Generator as Faker;
use App\Models\Shop\Sub_category;

$factory->define(Sub_category::class, function (Faker $faker) {
    return [
        'name' => $faker->word,
        'category_id'=> function(){
            return Category::all()->random();
        },
    ];
});
