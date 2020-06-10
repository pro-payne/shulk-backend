<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Shop\Shop;
use App\Models\Shop\Product;
use Faker\Generator as Faker;
use App\Models\Shop\Sub_category;

$factory->define(Product::class, function (Faker $faker) {
    return [
        'name'=> $faker->company,
        'description' => $faker->paragraph(3, true),
        'price' => $faker->numberBetween(10, 2000),
        'quantity' => $faker->randomDigitNotNull,
        'shop_id'=> function(){
            return Shop::all()->random();
        },
        'sub_category_id'=> function(){
            return Sub_category::all()->random();
        },
        'picture' => json_encode([$faker->imageUrl(300, 300)])
    ];
});
