<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('collector', 'Shop\CategoryController@collector')->name('data.collector');

Route::get('shops', 'Shop\ShopController@shops')->name('Shop info');
Route::get('products', 'Shop\ProductController@getProducts');
Route::get('sub_categories', 'Shop\SubCategoryController@subcategory');
Route::get('categories', 'Shop\CategoryController@categories');

Route::group(['prefix' => 'shops'], function(){
    Route::apiResource('/{shop}/categories', 'Shop\CategoryController');
});

Route::group(['prefix' => 'categories'], function(){
    Route::apiResource('/{category}/sub_categories', 'Shop\SubCategoryController');
});

// Customer Routes
Route::apiResource('customers', 'Customer\CustomerController');
Route::group(['prefix' => 'customer'], function(){
    Route::apiResource('/{customer}/cart', 'Customer\CartController');
    Route::delete('/{customer}/cart/{product?}', 'Customer\CartController@destroy');
    Route::apiResource('/{customer}/address', 'Customer\AddressController');
    Route::apiResource('/{customer}/orders', 'Customer\OrderController');
    Route::apiResource('/{customer}/wishlist', 'Customer\FavoriteController');
    Route::post('/{customer}/wishlist/move_to_cart', 'Customer\FavoriteController@move_to_cart');
    Route::post('/{customer}/wishlist/remove_items', 'Customer\FavoriteController@remove_items');
});

// Auth
Route::group(['prefix' => 'auth'], function(){
    Route::post('/customer/register', 'Authenticate\RegisterController@customerRegister')->name('customer.register');
    Route::post('/customer/login', 'Authenticate\LoginController@customerLogin')->name('customer.login');
    Route::post('/manager/register', 'Authenticate\RegisterController@managerRegister')->name('manager.register');
    Route::post('/manager/login', 'Authenticate\LoginController@managerLogin')->name('manager.login');
    Route::post('/manager/complete_profile', 'Authenticate\VerificationController@complete_profile')->name('manager.complete_profile');
    Route::get('/manager/check_profile', 'Authenticate\VerificationController@check_profile')->name('manager.check_profile');
    Route::post('/admin/register', 'Authenticate\RegisterController@adminRegister')->name('admin.register');
    Route::post('/admin/login', 'Authenticate\LoginController@adminLogin')->name('admin.login');
    Route::post('/logout', 'Authenticate\LoginController@logout')->name('logout');
});

Route::post('become-partner', 'Authenticate\RegisterController@becomePartner')->name('partner.request');

// Order
Route::group(['prefix' => 'order'], function(){
    Route::post('/shipping', 'Customer\AddressController@shipping')->name('order.shipping');
});

// Shop Manager
Route::apiResource('managers', 'Shop\ShopManagerController');
Route::group(['prefix' => 'manager'], function(){
    Route::apiResource('/{manager}/shops', 'Shop\ShopController');
    Route::apiResource('/{manager}/shops/{shop}/products', 'Shop\ProductController');
});

// Admin
Route::apiResource('admins', 'Admin\AdminController');

Route::group(['prefix' => 'admin'], function(){
    Route::apiResource('/{admin}/partners', 'Admin\PartnerController');
    Route::post('/{admin}/partners/{partner_request}/approve', 'Admin\PartnerController@approve')->name('partner.approve');
    Route::get('/{admin}/system_stats', 'Admin\DashboardController@system_stats');
    Route::apiResource('/{admin}/orders', 'Admin\AdminOrderController');
    Route::put('/{admin}/orders/{order}/status', 'Admin\AdminOrderController@status');
});

