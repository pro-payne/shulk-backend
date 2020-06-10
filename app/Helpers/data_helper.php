<?php

use Carbon\Carbon;
use App\Models\Shop\Category;
use App\Models\Shop\Sub_category;
use App\Models\Shop\Subcategory_product;

if (!function_exists('nav_categories')) {
    /**
     * Returns all available shop types, if possible mark currently active shop type
     *
     * @param category
     *
     * @return array , shop categories
     */

    function nav_categories($input_category = '')
    {
        $categories = Category::all();
        $results = [];
        foreach($categories as $category){
            $active = false;
            if(strtolower(trim($category->name)) == strtolower(trim($input_category))){
                $active = true;
            }

            $results[] = [
                'name' => $category->name,
                'active' => $active
            ];
        }
        return $results;
    }
}


if (!function_exists('categories')) {
    /**
     * Returns all available shop types, if possible mark currently active shop type
     *
     * @param category
     *
     * @return array shop categories
     */

    function categories($category, $input_category = '')
    {
        $categories = Sub_category::where('category_id', $category)->get();

        $results = [];
        foreach($categories as $category){
            $active = false;
            if(strtolower(trim($category->name)) == strtolower(trim($input_category))){
                $active = true;
                $getSubCategories = Subcategory_product::where('subcategory_id', '=', $category->id)->get();
                if(sizeof($getSubCategories) != 0){
                    foreach($getSubCategories as $subcategory){
                        $results['sub_categories'][] = [
                            'value' => $subcategory->name,
                            'active' => false
                        ];
                    }
                }
            }

            $results['categories'][] = [
                'value' => $category->name,
                'active' => $active
            ];
        }
        return $results;
    }
}