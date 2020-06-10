<?php

namespace App\Models\Customer;

use App\Models\Customer\Customer;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    protected $table = "cart";

    public function customer(){
        return $this->belongsTo(Customer::class);
    }
}
