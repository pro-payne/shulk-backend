<?php

namespace App\Models\Shop;

use App\Models\Shop\Product;
use Illuminate\Database\Eloquent\Model;

class Sub_category extends Model
{
    public function products(){
        return $this->hasMany(Product::class);
    }
}
