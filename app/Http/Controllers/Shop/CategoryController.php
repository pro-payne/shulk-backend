<?php

namespace App\Http\Controllers\Shop;

use App\Models\Shop\Shop;
use App\Models\Shop\Product;
use Illuminate\Http\Request;
use App\Models\Shop\Category;
use App\Models\Customer\Favorite;
use App\Models\Shop\Sub_category;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;
use App\Models\Shop\Subcategory_product;
use Symfony\Component\HttpFoundation\Response;

class CategoryController extends Controller
{

    private function fileContents($data){
        $results = [];
        $file = fopen(storage_path("app/". $data), "r");
        while(!feof($file) && ($content = fgets($file)) !== false) {
            $content = ucwords(strtolower(trim($content)));
            $results[] = $content;
        }

        fclose($file);

        return $results;
    }

    private function getCategories($data){
        $results = [];
         foreach($data as $info){
            $split = explode('/', $info);
            $sub_categories = Storage::files($info);
            if(empty($sub_categories)) continue;

            $file_data = [];
            foreach($sub_categories as $sub_category){
                $split_it = explode('/', $sub_category);
                $name = explode('.', $split_it[3]);

                $file_data[] = [
                    'name' => ucwords(strtolower(trim($name[0]))),
                    'products' => $this->fileContents($sub_category)
                ];
            }

            $results[] = [
                'name' => ucwords(strtolower(trim($split[2]))),
                'sub_categories' => $file_data
            ];
         }
        return $results;
    }

    /**
     * Collecting all item categories
     */
    public function collector()
    {

        // Fix usernames
        $shops = Shop::all();
        foreach($shops as $shop){
            $name = $shop->name;
            $shop->username = username($name, 'shop');
            $shop->save();
        }

        // Collect categories
        $directories = Storage::directories('data');
        $data = [];

        foreach($directories as $directory){
            $split = explode('/', $directory);
            $category = Storage::directories($directory);
            $categories = [];
            if(!empty($category)) {
                $categories = $this->getCategories($category);
            }

            $data[] = [
                'store_type' => ucwords(strtolower(trim($split[1]))),
                'categories' => $categories
            ];
        }

        // Now add this data in its places

        $shops = [];
        foreach($data as $getShopType){
            $shops[] = $getShopType['store_type'];
        }

        sort($shops);

        $count = 0;
        foreach ($shops as $shop) {
            $check = Category::where('name', trim($shop))->get();
            if (sizeof($check) != 0) {
                continue;
            }
            $add = new Category;
            $add->name = trim($shop);
            $add->save();
            $count++;
        }

        $results = ['Added ' . $count . ' / ' . sizeof($shops) . ' store type'];

        // $delete = Subcategory_product::all();
        // if($delete != null){
        //     foreach($delete as $d){
        //         $d->delete();
        //     }
        // }

        $count_sub_category = 0;
        $total_sub_category = 0;
        $count_subcategory_products = 0;
        $total_subcategory_products = 0;
        // Adding Subcategories
        foreach($data as $get){
            $check = Category::where('name', $get['store_type'])->get();
            if (sizeof($check) == 0) {
                continue;
            }
            $category_id = $check[0]->id;
            $total_sub_category += sizeof($get['categories']);
            foreach($get['categories'] as $category){
                $check = Sub_category::where('name', $category['name'])->get();
                if (sizeof($check) != 0) {
                    continue;
                }
                $add = new Sub_category;
                $add->name = $category['name'];
                $add->category_id = $category_id;
                $add->save();
                $count_sub_category++;
            }

            // Add subcategory products
            foreach($get['categories'] as $subcategory){
                $check = Sub_category::where('name', $subcategory['name'])->get();
                if (sizeof($check) == 0) {
                    continue;
                }
                $subcategory_id = $check[0]->id;
                $total_subcategory_products += sizeof($subcategory['sub_categories']);
                // dd( $subcategory['sub_categories']);
                foreach($subcategory['sub_categories'] as $sub_categories){
                    $json = json_encode($sub_categories['products']);
                    $check = Subcategory_product::where([
                        ['name', '=', $sub_categories['name']],
                        ['products', '=', $json],
                        ['subcategory_id', '=', $subcategory_id],
                    ])->get();
                    if (sizeof($check) != 0) {
                        continue;
                    }
                    $add = new Subcategory_product;
                    $add->name = $sub_categories['name'];
                    $add->products = $json;
                    $add->subcategory_id = $subcategory_id;
                    $add->save();
                    $count_subcategory_products++;
                }
            }
        }

        $results[] = 'Added ' . $count_sub_category . ' / ' . $total_sub_category . ' categories';
        $results[] = 'Added ' . $count_subcategory_products . ' / ' . $total_subcategory_products . ' sub categories';

        return $results;
    }

    public function categories(Request $request){
        $results = [];
        $data = [];
        $getCategory = $request->category;
        $categories = Category::all();

        if (sizeof($categories) == 0) {
            return response([
                'error' => 'No categories found',
            ], Response::HTTP_NOT_FOUND);
        }

        if ($getCategory != null) {
            foreach ($categories as $category) {
                if (strtolower(trim($category->name)) == strtolower(trim($getCategory))) {
                    $sub_categories = Sub_category::where('category_id', $category->id)->get();
                    if (sizeof($sub_categories) != 0) {
                        foreach ($sub_categories as $sub_category) {
                            $subResults = $this->getSubCategories($sub_category, $category->name);
                            if (!empty($subResults)) {
                                $results[] = $subResults;
                            }
                        }
                    }
                }
            }

            $nav_categories = nav_categories($getCategory);
            if (!empty($nav_categories)) {
                $data['nav_categories'] = $nav_categories;
            }
        } else {
            foreach($categories as  $category){
                $results[] = [
                    'id' => $category->id,
                    'name' => trim($category->name),
                    'picture' => $category->picture
                ];
            }
        }
        $data['collection'] = $results;
        return response($data);
    }

    /**
     * Display a listing of shop product categories.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Shop $shop, Request $request)
    {
        $results = [];
        $categories = Category::all();

        if (sizeof($categories) == 0) {
            return response([
                'error' => 'No categories found',
            ], Response::HTTP_NOT_FOUND);
        }

        $categories = Sub_category::where('category_id', '=', $shop->category_id)->get();
        foreach ($categories as $category) {
            $sub_categories = Subcategory_product::where('subcategory_id', '=', $category->id)->get();
            $subCategory = [];
            foreach($sub_categories as $sub_category){
                $subCategory[] = [
                    'id' => $sub_category->id,
                    'name' => $sub_category->name,
                    'active' => false
                ];
            }
            $results[] = [
                'id' => $category->id,
                'name' => trim($category->name),
                'active' => false,
                'sub_categories' => $subCategory
            ];
        }

        return response(['collection' => $results], Response::HTTP_CREATED);
    }

    /**
     * Get all sub categories
     */
    private function getSubCategories($sub_category, $category)
    {

        $products = Product::where('sub_category_id', $sub_category->id)->get();
        $results = [];
        $limit = 0;
        foreach ($products as $info) {
            $product = $this->productCollection($info);
            if (empty($product)) {
                continue;
            }

            $results[] = $product;
            if ($limit >= 12) {
                break;
            }
            $limit++;
        }

        if (empty($results)) {
            return [];
        }

        return [
            'info' => [
                'category' => $category,
                'sub_category' => $sub_category->name,
            ],
            'collection' => $results,
        ];
    }

    private function productCollection($product)
    {
        $shop = Shop::find($product->shop_id);
        if ($shop == null) {
            return [];
        }

        // $fav = Favorite::where('customer_id', )

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
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function show(Category $category)
    {
        $shop_category = $category->id;
        if ($shop_category == null) {
            return response([
                'error' => 'Please provide category',
            ], Response::HTTP_BAD_REQUEST);
        }

        $results = [];
        $productCategories = Category::where('category_id', $shop_category)->get();

        if (sizeof($productCategories) != 0) {
            foreach ($productCategories as $category) {
                $results[] = [
                    'id' => $category->id,
                    'name' => trim($category->name),
                    'picture' => $category->picture,
                ];
            }
        }

        return response([
            'data' => $results,
        ], Response::HTTP_CREATED);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function edit(Category $category)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Category $category)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function destroy(Category $category)
    {
        //
    }
}
