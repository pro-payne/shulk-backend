<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Shop\Role;
use Faker\Generator as Faker;

$factory->define(Role::class, function (Faker $faker) {
    return [
        'name'=> 'admin',
    ];
});
