<?php

namespace App\Models\Shop;

use App\Models\Shop\Shop;
use App\Models\Shop\Sub_category;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    public function shop(){
        return $this->belongsTo(Shop::class);
    }

    public function sub_category(){
        return $this->belongsTo(Sub_category::class);
    }
}
