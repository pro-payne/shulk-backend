<?php

namespace App\Http\Controllers\Shop;

use App\Models\Shop\Shop;
use Illuminate\Http\Request;
use App\Models\Shop\Category;
use App\Models\Shop\Shop_manager;
use App\Models\Shop\Sub_category;
use App\Http\Controllers\Controller;
use Symfony\Component\HttpFoundation\Response;

class ShopController extends Controller
{
    public function __construct(){
        $this->middleware('auth:manager-api')->except('shops');
    }

    /**
     * Display shop details
     *
     * @return \Illuminate\Http\Response
     */
    public function shops(Request $request)
    {
        $shop_identity = $request->identity;

        if($shop_identity == NULL){
            return response([
                'error' => 'Please provide shop identity'
            ], Response::HTTP_BAD_REQUEST);

        }

        $data = $this->shop(['username', strtolower($shop_identity)]);
        if(empty($data)){
            return response([
                'error' => 'Provided shop is not found'
            ], Response::HTTP_NOT_FOUND);
        }

        return response(['shop' => $data], Response::HTTP_CREATED);
    }

    private function shop($params){
        $data = [];

        // Show a single shop with all of it's products and product categories
        $getShop = Shop::where([$params])->get();
        if(sizeof($getShop) == 0){
            return [];
        }

        foreach($getShop as $shop){
            $data = $this->shopCollection($shop);
        }

        return $data;
    }

    /**
     * Get all shops
     */
    private function getAllShops(){
        $shops = Shop::all();
        $shopInfo = [];
        foreach($shops as $shop){
            $category = Sub_category::find($shop->shop_category);
            $shopInfo[$category->name][] = $this->shopCollection($shop, $category->name);
        }

        $results = [];
        foreach($shopInfo as $categoryKey => $info){
            $limit = 0;
            foreach($info as $data){
                $results[$categoryKey][] = $data;
                if($limit >= 12){
                     break;
                }
                $limit++;
            }
        }

        return $results;
    }

    private function shopCollection($shop){
        $category = Category::find($shop->category_id);
        return [
                'id' => $shop->id,
                'identity' => $shop->username,
                'name' => $shop->name,
                'description' => $shop->description,
                'category' => $category->name,
                'location' => $shop->location,
                'number' => $shop->number,
                'cover' => $shop->cover,
                'logo' => $shop->picture
            ];
    }

    /**
     * Display a listing of shops
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Shop_manager $manager, Request $request){
        checkUser(auth()->user(), $manager);
        $data = $this->shop(['id', $manager->shop_id]);
        if(empty($data)){
            return response([
                'error' => 'Provided shop is not found'
            ], Response::HTTP_NOT_FOUND);
        }

        return response(['shop' => $data], Response::HTTP_CREATED);
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
     * @param  \App\Models\Shop  $shop
     * @return \Illuminate\Http\Response
     */
    public function show(Shop_manager $manager, Shop $shop)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Shop  $shop
     * @return \Illuminate\Http\Response
     */
    public function update(Shop_manager $manager, Request $request, Shop $shop)
    {
        checkUser(auth()->user(), $manager);
        if($manager->shop_id != $shop->id){
            return response([
                'success' => false,
                'message' => "Don't have right to make such request"
            ], Response::HTTP_CREATED);
        }

        $request->validate([
            'shop_name' => 'required|string',
            'description' => 'required|string',
            'location' => 'required|string',
            'number' => 'required|string|min:10',
        ]);

        $username = username($request->shop_name, 'shop');
        if($username == ""){
            return response(['success' => false, "message" => "Failed to generate your username"], Response::HTTP_CREATED);
        }

        $shop->name = trim($request->shop_name);
        $shop->description = $request->description;
        $shop->location = $request->location;
        $shop->number = $request->number;
        $shop->username = $username;
        $shop->save();

        return response(['success' => true], Response::HTTP_CREATED);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Shop  $shop
     * @return \Illuminate\Http\Response
     */
    public function destroy(Shop $shop)
    {
        //
    }
}
