<?php

namespace App\Http\Controllers\Shop;

use App\Http\Controllers\Controller;
use App\Models\Shop\Category;
use App\Models\Shop\Product;
use App\Models\Shop\Shop;
use App\Models\Shop\Shop_manager;
use App\Models\Shop\Subcategory_product;
use App\Models\Shop\Sub_category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

class ProductController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:manager-api')->except('getProducts');
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function getProducts(Request $request)
    {
        $shop = $request->shop;
        $getSubCategory = $request->category;
        $productId = $request->id;

        // Check if we are looking for a single product
        if ($productId != null && $shop == null) {

            $data = $this->getProduct((int) $productId);
            if (empty($data)) {
                return \response([
                    'error' => 'no_product',
                ], Response::HTTP_NOT_FOUND);
            }

            return response([
                'product' => $data['product'],
                'navigation' => [
                    [
                        'value' => $data['category'],
                        'link' => 'category/' . strtolower($data['category']),
                        'current' => false,
                    ],
                    [
                        'value' => $data['subcategory'],
                        'link' => 'category/' . strtolower($data['category']) . "/products/" . $data['subcategory'],
                        'current' => true,
                    ],
                ],
            ], Response::HTTP_CREATED);
        }

        if ($shop == null) {
            return response([
                'error' => 'Please provide required information',
            ], Response::HTTP_BAD_REQUEST);
        }

        $shop = (int) $shop;
        $results = [];
        $data = [];
        $category = 0;

        $getAll = false;

        if ($getSubCategory == null) {
            $getAll = true;
        } else {
            if (strtolower(trim($getSubCategory)) == 'all') {
                $getAll = true;
            }
        }

        $getShop = Shop::find($shop);
        if ($getShop == null) {
            return response(['error' => "Shop not found"], Response::HTTP_NOT_FOUND);
        }

        $category_id = $getShop->category_id;
        $sub_category_name = '';

        $sub_categories = Sub_category::where('category_id', (int) $category_id)->get();
        if ($getAll) {
            $getProducts = Product::where([
                ['shop_id', $shop],
            ])->get();
        } else {
            $sub_category_id = 0;
            foreach ($sub_categories as $_sub_category) {
                if (\strtolower(trim($_sub_category->name)) == \strtolower(trim($getSubCategory)) && $category_id == (int) $_sub_category->category_id) {
                    $sub_category_id = (int) $_sub_category->id;
                    $sub_category_name = $_sub_category->name;
                }
            }

            $getProducts = Product::where([
                ['shop_id', $shop],
                ['sub_category_id', $sub_category_id],
            ])->get();
        }

        $category_name = '';

        $getCategory = Category::find($category_id);
        if ($getCategory != null) {
            $category_name = $getCategory->name;
        }

        if (sizeof($getProducts) != 0) {
            if (!$getAll) {
                foreach ($getProducts as $product) {
                    $results[] = $this->productCollection($product, $getShop);
                }
            } else {
                foreach ($sub_categories as $sub_category) {
                    $info = $this->collection($sub_category->id, $getShop);
                    if (empty($info)) {
                        continue;
                    }
                    $results[] = [
                        'info' => [
                            'sub_category' => $sub_category->name,
                            'category' => $category_name,
                        ],
                        'collection' => $info,
                    ];
                }
            }
        }

        $data['collection'] = $results;
        $nav_categories = nav_categories($category_name);
        if (!empty($nav_categories)) {
            $data['nav_categories'] = $nav_categories;
        }

        $filterCategories = categories($category_id, $sub_category_name);
        if (!empty($filterCategories)) {
            $data['categories'] = $filterCategories;
        }

        return response($data, Response::HTTP_CREATED);
    }

    private function collection($sub_category, $shop)
    {
        $getProducts = Product::where([
            ['shop_id', $shop->id],
            ['sub_category_id', $sub_category],
        ])->get();

        $data = [];
        foreach ($getProducts as $product) {
            $data[] = $this->productCollection($product, $shop);
        }
        return $data;
    }

    private function productCollection($product, $shop)
    {
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
            'brand' => '',
            'pictures' => (array) \json_decode($product->picture),
            'description' => $product->description,
            'favorite' => false,
        ];
    }

    private function getProduct($id)
    {
        $product = Product::find($id);
        if ($product == null) {
            return [];
        }

        $shop = Shop::find($product->shop_id);
        if ($shop == null) {
            return [];
        }
        $category = DB::table('categories')
            ->join('sub_categories', 'categories.id', '=', 'sub_categories.category_id')
            ->select('categories.name')
            ->where('sub_categories.id', $product->sub_category_id)
            ->get();

        $subCategory = Sub_category::find((int) $product->sub_category_id);

        $categoryName = '';
        $subCategoryName = '';
        if (sizeof($category) != 0) {
            $categoryName = $category[0]->name;
        }

        if ($subCategory != null) {
            $subCategoryName = $subCategory->name;
        }

        return [
            'product' => [
                'owner' => [
                    'identity' => $shop->username,
                    'name' => $shop->name,
                ],
                'id' => $product->id,
                'name' => $product->name,
                'price' => $product->price,
                'brand' => '',
                'pictures' => (array) \json_decode($product->picture),
                'description' => $product->description,
                'favorite' => false,
            ],
            'category' => $categoryName,
            'subcategory' => $subCategoryName,
        ];
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Shop_manager $manager, Shop $shop, Request $request)
    {
        checkUser(auth()->user(), $manager);
        if ($manager->shop_id != $shop->id) {
            return response(['success' => false, 'message' => 'forbidden'], Response::HTTP_FORBIDDEN);
        }

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Shop_manager $manager, Shop $shop, Request $request)
    {
        checkUser(auth()->user(), $manager);
        if ($manager->shop_id != $shop->id) {
            return response(['success' => false, 'message' => 'forbidden'], Response::HTTP_FORBIDDEN);
        }

        $request->validate([
            'category' => 'required|integer',
            'sub_category' => 'required|integer',
            'items' => 'required',
        ]);

        $input = $request->only(['category', 'sub_category', 'items']);

        // Verify product group
        $checkSubcategory = Subcategory_product::where([
            ['id', '=', $input['sub_category']],
            ['subcategory_id', '=', $input['category']]
        ])->get();

        if (is_null($checkSubcategory)) {
            return response(['success' => false, 'message' => 'Product category group not found']);
        }

        $haveItems = true;
        if(!is_array($input['items'])){
            $haveItems = false;
        }else{
            if(empty($input['items'])){
                $haveItems = false;
            }
        }

        if(!$haveItems){
            return response(['success' => false, 'message' => 'Please add at least 1 item']);
        }

        foreach($input['items'] as $item){
            $new = new Product;
            $new->name = trim($item['name']);
            $new->brand_name = trim($item['brand']);
            $new->price = $item['price'];
            $new->description = trim($item['description']);
            $new->picture = \json_encode([]);
            $new->shop_id = $shop->id;
            $new->sub_category_id = $input['category'];
            $new->save();
        }
        return response(['success' => true]);

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Shop\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function show(Product $product)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Shop\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Product $product)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Shop\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function destroy(Product $product)
    {
        //
    }
}
