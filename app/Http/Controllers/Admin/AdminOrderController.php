<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Admin\Admin;
use App\Models\Customer\Customer;
use App\Models\Customer\Order;
use App\Models\Shop\Product;
use App\Models\Shop\Shop;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class AdminOrderController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:admin-api');
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Admin $admin, Request $request)
    {
        checkUser(auth()->user(), $admin);
        $status = 'pending';
        $sort = 'desc';
        if (!is_null($request->status)) {
            $status = strtolower(trim($request->status));
        }

        if (!is_null($request->sort)) {
            $sort = strtolower(trim($request->sort));
        }

        $orders = Order::where('order_status', $status)->orderBy('created_at', $sort)->get();
        $results = [];
        if (sizeof($orders) != 0) {
            foreach ($orders as $order) {
                $results[] = $this->order_data($order);
            }
        }

        // Orders stats
        $stats = Order::all();
        $statuses = [
            'pending' => 0,
            'processing' => 0,
            'canceled' => 0,
            'completed' => 0,
        ];

        foreach($stats as $stat){
            if(isset($statuses[strtolower($stat->order_status)])){
                $statuses[strtolower($stat->order_status)]++;
            }
        }

        return response(['orders' => $results, 'stats' => $statuses], Response::HTTP_CREATED);

    }

    private function order_data($order)
    {
        $products = [];
        $subtotal = 0;
        $delivery_cost = 50;
        $data = (array) json_decode($order->order_data);
        $quantity_count = 0;
        foreach ($data['products'] as $product) {
            $prod = Product::find($product->product);

            if (!is_null($prod)) {
                $image = (array) \json_decode($prod->picture);
                $shop = Shop::find($prod->shop_id);
                if (is_null($shop)) {
                    continue;
                }

                $products[] = [
                    'name' => $prod->name,
                    'price' => 'R ' . $prod->price,
                    'picture' => (sizeof($image) != 0) ? $image[0] : '',
                    'quantity' => $product->quantity,
                    'note' => $product->note,
                    'owner' => [
                        'identity' => $shop->username,
                        'name' => $shop->name,
                    ],
                ];
                $quantity_count += $product->quantity;
                $subtotal += $prod->price * $product->quantity;
            }
        }

        $street = $data['delivery_address']->street;
        if ($data['delivery_address']->address2 != '') {
            $street .= ', ' . $data['delivery_address']->address2;
        }

        $customer = Customer::find($order->customer_id);
        $full_name = 'Customer';
        $number = '';
        if (!\is_null($customer)) {
            $full_name = $customer->first_name . ' ' . $customer->last_name;
            $number = $customer->number;
        }

        return [
            'id' => $order->id,
            'reference' => $order->reference,
            'ordered_by' => [
                'name' => $full_name,
                'number' => $number,
            ],
            'status' => \ucfirst(strtolower($order->order_status)),
            'delivery_address' => [
                'street' => $street,
                'city' => $data['delivery_address']->city,
                'zip' => $data['delivery_address']->zip,
            ],
            'summary' => [
                'items' => $products,
                'delivery_cost' => 'R ' . $delivery_cost,
                'total' => 'R ' . ($subtotal + $delivery_cost),
            ],
            'ordered_at' => $order->created_at,
        ];
    }

    public function status(Admin $admin, Order $order, Request $request)
    {
        checkUser(auth()->user(), $admin);
        $status = "";
        if (!is_null($request->status)) {
            $status = strtolower(trim($request->status));
        }

        $cont = false;
        switch ($status) {
            case 'pending':
            case 'processing':
            case 'canceled':
            case 'completed':
                $cont = true;
                break;
            default:
                $cont = false;
                break;
        }

        if (!$cont) {
            return response([
                'success' => false,
                'message' => 'Unknown status, please try again',
            ], Response::HTTP_CREATED);
        }

        $order->order_status = $status;
        $order->save();

        return \response(['success' => true]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Customer\Order  $order
     * @return \Illuminate\Http\Response
     */
    public function show(Order $order)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Customer\Order  $order
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Order $order)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Customer\Order  $order
     * @return \Illuminate\Http\Response
     */
    public function destroy(Order $order)
    {
        //
    }
}
