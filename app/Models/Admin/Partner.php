<?php

namespace App\Models\Admin;

use App\Models\Admin\Admin;
use Illuminate\Database\Eloquent\Model;

class Partner extends Model
{
    //
    public function admin(){
        return $this->belongsTo(Admin::class);
    }
}
