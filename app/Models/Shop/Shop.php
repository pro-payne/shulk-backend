<?php

namespace App\Models\Shop;

use App\Models\Shop\Product;
use App\Models\Shop\Category;
use Illuminate\Database\Eloquent\Model;

class Shop extends Model
{
   /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'username',
    ];

    public function category(){
        return $this->belongsTo(Category::class);
    }

    public function products(){
        return $this->hasMany(Product::class);
    }
}
