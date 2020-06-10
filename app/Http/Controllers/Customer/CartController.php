<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Models\Customer\Cart;
use App\Models\Customer\Customer;
use App\Models\Customer\Favorite;
use App\Models\Shop\Product;
use App\Models\Shop\Shop;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CartController extends Controller
{
    public function __construct(){
        $this->middleware('auth:customer-api');
    }

    /**
     * Display user's cart
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Customer $customer, Request $request)
    {
        $user = auth()->user();
        checkUser($user, $customer);

        $cart = Cart::where('customer_id', '=', $customer->id)->get();
        $results = [];
        if (sizeof($cart) != 0) {
            foreach ($cart as $data) {
                $product = $this->getProduct($data->product_id);
                $results[] = [
                    'id' => $data->product_id,
                    'name' => $product['name'],
                    'owner' => $product['owner'],
                    'pictures' => $product['pictures'],
                    'price' => $product['price'],
                    'quantity' => $data->quantity,
                ];
            }
        }

        return response($results, Response::HTTP_CREATED);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Customer $customer, Request $request)
    {
        $user = auth()->user();
        checkUser($user, $customer);
        // Check product if already added

        $check_product = Cart::where([
            ['customer_id', '=', $customer->id],
            ['product_id', '=', $request->id],
        ])->get();

        if (sizeof($check_product) != 0) {
            return $this->updateCart($check_product[0], $request);
        }

        $cart = new Cart;
        $cart->customer_id = $customer->id;
        $cart->product_id = $request->id;
        $cart->note = ($request->specialInfo != null) ? $request->specialInfo : '';
        $cart->quantity = $request->quantity;
        $cart->save();

        return \response(['success' => true], Response::HTTP_CREATED);
    }

    private function updateCart($cart, $request)
    {
        $update_cart = Cart::find($cart->id);

        $update_cart->note = ($request->specialInfo != null) ? $request->specialInfo : '';
        $update_cart->quantity = $request->quantity;
        $update_cart->save();

        return \response(['success' => true], Response::HTTP_CREATED);
    }

    private function getProduct($id)
    {
        $product = Product::find($id);
        if ($product == null) {
            return [];
        }

        $getOwner = Shop::find($product->shop_id);
        if ($getOwner == null) {
            return [];
        }

        return [
            'name' => $product->name,
            'owner' => [
                'id' => $getOwner->id,
                'identity' => $getOwner->username,
                'name' => $getOwner->name,
                'logo' => $getOwner->picture,
            ],
            'pictures' => (array) \json_decode($product->picture),
            'price' => $product->price,
        ];
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Cart  $cart
     * @return \Illuminate\Http\Response
     */
    public function show(Customer $customer, Cart $cart)
    {
        $user = auth()->user();
        checkUser($user, $customer);

        if ($customer->id != $cart->customer_id) {
            return response([], Response::HTTP_CREATED);
        }

        $getFavorite = Favorite::where([
            ['customer_id', '=', $cart->customer_id],
            ['product_id', '=', $cart->product_id],
        ])->get();

        $favorite = false;
        if (sizeof($getFavorite) != 0) {
            $favorite = true;
        }

        $results = [
            'id' => $cart->product_id,
            'quantity' => $cart->quantity,
            'specialInfo' => $cart->note,
            'favorite' => $favorite,
        ];

        return response($results, Response::HTTP_CREATED);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Customer\Cart  $cart
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Customer $customer, Cart $cart)
    {
        $user = auth()->user();
        checkUser($user, $customer);

        if ($customer->id != $cart->customer_id) {
            return response([
                'success' => false,
                'error' => 'Not allowed',
            ], Response::HTTP_NOT_ACCEPTABLE);
        }

        $cart->note = $request->specialInfo;
        $cart->quantity = $request->quantity;
        $cart->save();

        return response(['success' => true], Response::HTTP_CREATED);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Customer\Customer  $customer
     * @param  $product
     * @return \Illuminate\Http\Response
     */
    public function destroy(Customer $customer, $product = null)
    {
        $user = auth()->user();
        checkUser($user, $customer);

        if($product != null){
            $product = (int) $product;
            $cart = Cart::where([
                ['customer_id', '=', $customer->id],
                ['product_id', '=', $product]
            ])->get();
        }else{
            $cart = Cart::where([
                ['customer_id', '=', $customer->id]
            ])->get();
        }

        if(sizeof($cart) == 0){
            return response(['success' => false, 'error' => 'Product not found'], Response::HTTP_CREATED);
        }

        foreach($cart as $ct){
            $ct->delete();
        }

        return response(['success' => true], Response::HTTP_CREATED);
    }
}
