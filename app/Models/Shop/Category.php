<?php

namespace App\Models\Shop;

use App\Models\Shop\Sub_category;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    public function sub_category(){
        return $this->hasMany(Sub_category::class);
    }
}
