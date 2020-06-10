<?php

namespace App\Models\Customer;

use App\Models\Customer\Cart;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Contracts\Auth\MustVerifyEmail;

class Customer extends Authenticatable
{
    use HasApiTokens, Notifiable;

    protected $guard = 'customer';

    protected $fillable = [
        'first_name', 'last_name', 'number', 'email', 'password',
    ];

    protected $hidden = [
        'password', 'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function cart(){
        return $this->hasMany(Cart::class);
    }
}
