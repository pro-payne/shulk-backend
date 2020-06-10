<?php

namespace App\Http\Controllers\Customer;

use App\Models\Shop\Shop;
use App\Models\Shop\Product;
use Illuminate\Http\Request;
use App\Models\Customer\Cart;
use App\Models\Customer\Customer;
use App\Models\Customer\Favorite;
use App\Http\Controllers\Controller;

class FavoriteController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:customer-api');
    }

    /**
     * Display wishlist
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Customer $customer)
    {
        checkUser(auth()->user(), $customer);

        $wishlist = Favorite::where('customer_id', $customer->id)->get();
        $results = [];
        foreach ($wishlist as $list) {
            $product = Product::find($list->product_id);
            if (!is_null($product)) {
                $images = (array) \json_decode($product->picture);
                $results[] = [
                    'id' => $product->id,
                    'title' => $product->name,
                    'image' => (sizeof($images) != 0) ? $images[0] : '',
                    'price' => 'R ' . $product->price,
                    'date_added' => $list->created_at,
                ];
            }
        }

        return response(['data' => $results]);

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
        $check = Favorite::where([
            ['customer_id', $customer->id],
            ['product_id', $request->product]
            ])->get();
        if (sizeof($check) != 0) {
            return response(['success' => false, 'message' => 'Already on the wish list']);
        }

        $fav = new Favorite;
        $fav->product_id = $request->product;
        $fav->customer_id = $customer->id;
        $fav->save();

        return \response(['success' => true]);

    }

    public function move_to_cart(Customer $customer, Request $request)
    {
        checkUser(auth()->user(), $customer);

        $request->validate([
            'items' => 'required|string'
        ]);

        $items = (array) \json_decode($request->items);
        $moved = [];
        foreach($items as $item){
            $product = Product::find($item);

            $wish = Favorite::where([
                ['product_id', '=', $item],
                ['customer_id', '=', $customer->id]
            ])->get();

            if(is_null($product) || sizeof($wish) == 0){
                continue;
            }

            $cart = new Cart;
            $cart->customer_id = $customer->id;
            $cart->product_id = $item;
            $cart->quantity = 1;
            $cart->note = '';
            $cart->save();

            $wish[0]->delete();

            $shop = Shop::find($product->shop_id);

            $moved[] = [
                'id' => $item,
                'name' => $product->name,
                'price' => $product->price,
                'pictures' => (array) json_decode($product->picture),
                'owner' => [
                    'id' => $shop->id,
                    'identity' => $shop->username,
                    'name' => $shop->name,
                    'logo' => $shop->picture,
                ],
            ];
        }

        return response(['moved' => $moved]);
    }

    public function remove_items(Customer $customer, Request $request)
    {
        checkUser(auth()->user(), $customer);
        $request->validate([
            'items' => 'required|string'
        ]);
        $items = (array) \json_decode($request->items);
        $removed = [];
        foreach($items as $item){
            $product = Product::find($item);

            $wish = Favorite::where([
                ['product_id', '=', $item],
                ['customer_id', '=', $customer->id]
            ])->get();

            if(is_null($product) || sizeof($wish) == 0){
                continue;
            }

            $wish[0]->delete();
            $removed[] = [
                'id' => $item
            ];
        }

        return response(['removed' => $removed]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Customer\Favorite  $favorite
     * @return \Illuminate\Http\Response
     */
    public function show(Favorite $favorite)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Customer\Favorite  $favorite
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Favorite $favorite)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Customer\Favorite  $favorite
     * @return \Illuminate\Http\Response
     */
    public function destroy(Favorite $favorite)
    {
        //
    }
}
