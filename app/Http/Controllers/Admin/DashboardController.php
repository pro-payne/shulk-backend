<?php

namespace App\Http\Controllers\Admin;

use App\Models\Shop\Shop;
use App\Models\Admin\Admin;
use Illuminate\Http\Request;
use App\Models\Customer\Order;
use App\Models\Customer\Customer;
use App\Http\Controllers\Controller;
use Symfony\Component\HttpFoundation\Response;

class DashboardController extends Controller
{
    public function __construct(){
        $this->middleware('auth:admin-api');
    }

    public function system_stats(Admin $admin, Request $request){

        $results = [];
        // Get number of all users
        $results['users'] = [
            'customers' => Customer::all()->count(),
            'shops' => Shop::all()->count()
        ];

        // Get Orders
        $orders = Order::all();
        $order_statuses = [
            'pending' => 0,
            'processing' => 0,
            'canceled' => 0,
            'completed' => 0
        ];
        foreach($orders as $order){
            $order_statuses[$order->order_status]++;
        }

        $results['orders'] = $order_statuses;

        // Get refund requests
        $results['refunds'] = [
            'refund_requests' => 0
        ];

        return response(['stats' => $results], Response::HTTP_CREATED);
    }
}
