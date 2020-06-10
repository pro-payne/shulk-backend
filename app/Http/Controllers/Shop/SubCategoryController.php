<?php

namespace App\Http\Controllers\Shop;

use App\Models\Shop\Shop;
use App\Models\Shop\Product;
use Illuminate\Http\Request;
use App\Models\Shop\Category;
use App\Models\Shop\Sub_category;
use App\Http\Controllers\Controller;
use Symfony\Component\HttpFoundation\Response;

class SubCategoryController extends Controller
{

    /**
     * Display all products based on the query.
     *
     * @return \Illuminate\Http\Response
     */
    public function subcategory(Request $request)
    {
        $getCategory = $request->category;
        $getSubCategory = $request->sub_category;

        if($getCategory == NULL || $getSubCategory == NULL){
            return response([
                'error' => 'Specify your query',
            ], Response::HTTP_METHOD_NOT_ALLOWED);
        }

        // Find the category
        $category = 0;
        $data = [];
        $subcategory = 0;
        $categories = Category::all();
        foreach($categories as $_category){
            if(\strtolower(trim($_category->name)) == \strtolower(trim($getCategory))){
                $category = (int) $_category->id;
            }
        }

        $sub_categories = Sub_category::where('category_id', $category)->get();

        if(sizeof($sub_categories) != 0){
            foreach($sub_categories as $sub_category){
                $thisCategory = strtolower(trim($sub_category->name));
                $thatCategory = strtolower(trim($getSubCategory));

                $data['sub_categories'][] = [
                    'value' => $sub_category->name,
                    'active' => ($thisCategory == $thatCategory) ? true : false
                ];

                if($thisCategory == $thatCategory){
                    $subcategory = (int) $sub_category->id;
                }
            }
        }

        $found = true;
        if($subcategory == 0){
            $found = false;
        }

        $products = Product::where('sub_category_id', $subcategory)->get();

        if(sizeof($products) == 0 || !$found){
            return response([
                'error' => 'No products found',
            ], Response::HTTP_NOT_FOUND);
        }

        $collection = [];
        foreach($products as $info){
            $product = $this->productCollection($info);
            if (empty($product)) {
                continue;
            }

            $collection[] = $product;
        }

        $data['collection'] = $collection;

        $nav_categories = nav_categories($getCategory);
        if (!empty($nav_categories)) {
            $data['nav_categories'] = $nav_categories;
        }

        return response($data, Response::HTTP_CREATED);
    }

    private function productCollection($product)
    {
        $shop = Shop::find($product->shop_id);
        if ($shop == null) {
            return [];
        }

        return [
            'owner' => [
                'id' => $shop->id,
                'identity' => $shop->username,
                'name' => $shop->name,
                'logo' => $shop->picture,
            ],
            'id' => $product->id,
            'name' => $product->name,
            'price' => $product->price,
            'pictures' => (array) \json_decode($product->picture),
            'description' => $product->description,
            'favorite' => false
        ];
    }

    /**
     * Display all products based on the query.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
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
     * @param  \App\Models\Shop\Sub_category  $sub_category
     * @return \Illuminate\Http\Response
     */
    public function show(Sub_category $sub_category)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Shop\Sub_category  $sub_category
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Sub_category $sub_category)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Shop\Sub_category  $sub_category
     * @return \Illuminate\Http\Response
     */
    public function destroy(Sub_category $sub_category)
    {
        //
    }
}
