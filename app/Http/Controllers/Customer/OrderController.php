<?php

namespace App\Http\Controllers\Customer;

use App\Models\Shop\Product;
use Illuminate\Http\Request;
use App\Models\Customer\Card;
use App\Models\Customer\Cart;
use App\Models\Customer\Order;
use App\Models\Customer\Address;
use App\Models\Customer\Customer;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class OrderController extends Controller
{
    public function __construct(){
        $this->middleware('auth:customer-api');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Customer $customer)
    {
        checkUser(auth()->user(), $customer);
        $user = $customer->id;

        $orders = Order::where('customer_id', $user)->get();
        $results = [];
        if(sizeof($orders) != 0){
            $temp_results = [];
           foreach($orders as $order){
                $data = $this->order_data($order);
                $type = $data['type'];
                unset($data['type']);
                $temp_results[$type][] = $data;
           }

           foreach($temp_results as $key => $temp_result){
                $results[] = [
                    'type' => ucwords(\strtolower($key)),
                    'data' => $temp_result
                ];
           }
        }

        return response(['orders' => $results], Response::HTTP_CREATED);

    }

    private function order_data($order){
        $products = [];
        $subtotal = 0;
        $delivery_cost = 50;
        $data = (array) json_decode($order->order_data);
        $quantity_count = 0;
        foreach($data['products'] as $product){
            $prod = Product::find($product->product);
            if(!is_null($prod)){
                $products[] = [
                    'name' => $prod->name,
                    'price' => $prod->price,
                    'quantity' => $product->quantity,
                    'note' => $product->note
                ];
                $quantity_count += $product->quantity;
                $subtotal += $prod->price * $product->quantity;
            }
        }

        $status_type = '';
        $type = strtolower($order->order_status);
        // Status type: pending, processing, delivering, completed, cancled
        switch($type){
            case 'canceled':
            case 'completed':
                $status_type = 'previous';
            break;
            default:
                $status_type = 'active';
            break;
        }

        $street = $data['delivery_address']->street;
        if($data['delivery_address']->address2 != ''){
            $street .= ', ' . $data['delivery_address']->address2;
        }

        return [
                'id' => $order->id,
                'reference' => $order->reference,
                'status' => $order->order_status,
                'delivery_address' => [
                    'street' => $street,
                    'city' => $data['delivery_address']->city,
                    'zip' => $data['delivery_address']->zip,
                ],
                'summary' => [
                    'items' => [
                        'count' => $product->quantity,
                        'total' => $subtotal
                    ],
                    'delivery_cost' => $delivery_cost,
                    'total' => $subtotal + $delivery_cost
                ],
                'products' => $products,
                'ordered_at' => $order->created_at,
                'type' => $status_type
            ];
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Customer $customer, Request $request)
    {
        checkUser(auth()->user(), $customer);
        $user = $customer->id;

        // Get products that are added to cart
        $getCart = Cart::where('customer_id', '=', $user)->get();
        if(sizeof($getCart) == 0){
            return response([
                'success' => false,
                'message' => "Please add at least 1 product to cart"
            ], Response::HTTP_CREATED);
        }

        $products = [];
        foreach($getCart as $cart){
            $products[] = [
                'product' => $cart->product_id,
                'quantity' => $cart->quantity,
                'note' => $cart->note
            ];
        }

        // Check if address exist
        $address = ($request->address != null) ? (int) $request->address : 0;
        $checkAddress = Address::where([
            ['id', '=', $address],
            ['customer_id', '=', $user]
        ])->get();
        if(sizeof($checkAddress) == 0){
            return response([
                'success' => false,
                'message' => "Please add delivery address"
            ], Response::HTTP_CREATED);
        }

        $checkAddress = $checkAddress[0];

        // Save card
        if($request->save_card){
            $checkCard = Card::where([
                ['customer_id', '=', $user],
                ['holder', '=', $request->card_holder],
                ['number', '=', $request->card_number],
                ['cvv', '=', $request->cvv],
                ['expiry_date', '=', $request->expiry_date],
            ])->get()->count();

            if($checkCard == 0){
                $card = new Card;
                $card->customer_id = $user;
                $card->holder = $request->card_holder;
                $card->number = $request->card_number;
                $card->cvv = $request->cvv;
                $card->expiry_date = $request->expiry_date;
                $card->save();
            }
        }

        $data = [
            'delivery_address' => [
                'street' => $checkAddress->street,
                'address2' => $checkAddress->address2,
                'city' => $checkAddress->town,
                'zip' => $checkAddress->zip_code
            ],
            'products' => $products
        ];

        // Process Card using PayFast

        // Add data to order table
        $order = new Order;
        $order->customer_id = $user;
        $order->address_id = $address;
        $order->order_data = json_encode($data);
        $order->save();

        // Then clear user's cart
        $cart = Cart::where('customer_id', '=', $user)->get();
        if(sizeof($cart) != 0){
            foreach($cart as $ct){
                $ct->delete();
            }
        }

        return response([
            'success' => true,
            'message' => 'Thank you, we received your order'
        ], Response::HTTP_CREATED);

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Order  $order
     * @return \Illuminate\Http\Response
     */
    public function show(Customer $customer, Order $order)
    {
        checkUser(auth()->user(), $customer);
        $user = $customer->id;
        if($user != $order->customer_id){
            return response([
                'success' => false,
                'message' => "Not allowed to make this request"
            ], Response::HTTP_CREATED);
        }

        $data = $this->order_data($order);

        return response(['success' => true, 'order' => $data], Response::HTTP_CREATED);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Order  $order
     * @return \Illuminate\Http\Response
     */
    public function update(Customer $customer, Request $request, Order $order)
    {
        checkUser(auth()->user(), $customer);
        if($customer->id != $order->customer_id){
            return response([
                'success' => false,
                'message' => "Not allowed to make this request"
            ], Response::HTTP_CREATED);
        }

        $request->validate([
            'type' => 'required|string'
        ]);

        $request_type = '';
        switch($request->type){
            case 'cancel':
                $request_type = 'canceled';
            break;
            case 're-order':
                $request_type = 'pending';
            break;
        }

        if($request_type == ''){
            return response([
                'success' => false,
                'message' => 'Request type not allowed'
            ], Response::HTTP_CREATED);
        }

        $order->order_status = $request_type;
        $order->save();

        return response([
            'success' => true,
        ], Response::HTTP_CREATED);
    }

    /**
     * Cancelling order
     *
     * @param  \App\Models\Order  $order
     * @return \Illuminate\Http\Response
     */
    public function destroy(Customer $customer, Order $order)
    {
        checkUser(auth()->user(), $customer);

    }
}
