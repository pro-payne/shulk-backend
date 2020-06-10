<?php

namespace App\Http\Controllers\Authenticate;

use Carbon\Carbon;
use Lcobucci\JWT\Parser;
use App\Models\Shop\Role;
use App\Models\Shop\Shop;
use App\Models\Shop\Product;
use Illuminate\Http\Request;
use App\Models\Customer\Cart;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class LoginController extends Controller
{
    /**
     * Authenticate Customer.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function customerLogin(Request $request)
    {
        $guard = 'customer';
        $this->middleware('guest:'. $guard .'-api');

        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only(['email', 'password']);

        if (!Auth::guard($guard)->attempt($credentials)) {
            return response(['success' => false, 'error' => 'Email or Password doesn\'t exist'], Response::HTTP_CREATED);
        }

        $user_details = Auth::guard($guard)->user();

        // Create token
        $tokenResult = $user_details->createToken('Personal Access Token');

        $token = $tokenResult->token;

        // Remember me option

        $token->expires_at = Carbon::now()->addWeeks(1);
        $token->save();

        $saved_cart = $this->getCart($user_details->id);

        return \response([
            'success' => true,
            'access_token' => $tokenResult->accessToken,
            'token_type' => 'Bearer',
            'expires_at' => Carbon::parse(
                $tokenResult->token->expires_at
            )->toDateTimeString(),
            'user' => [
                'identity' => $user_details->id,
                'first_name' => $user_details->first_name,
                'last_name' => $user_details->last_name,
                'email' => $user_details->email,
                'picture' => "",
                'user_type' => 'customer',
                'verified' => ((int) $user_details->verified == 0) ? false : true,
                'registered' => $user_details->created_at
            ],
            'cart' => $saved_cart
        ], Response::HTTP_CREATED);
    }

    private function getCart($customer_id)
    {
        $cart = Cart::where('customer_id', '=', $customer_id)->get();
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

        return $results;
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
     * Authenticate Shop Owners.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function managerLogin(Request $request)
    {
        $guard = 'manager';

        $this->middleware('guest:'. $guard .'-api');

        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only(['email', 'password']);

        if (!Auth::guard($guard)->attempt($credentials)) {
            return response(['success' => false, 'error' => 'Email or Password doesn\'t exist'], Response::HTTP_CREATED);
        }

        $user_details = Auth::guard($guard)->user();

        // Create token
        $tokenResult = $user_details->createToken('Personal Access Token');

        $token = $tokenResult->token;

        // Remember me option

        $token->expires_at = Carbon::now()->addWeeks(1);
        $token->save();

        // Get role
        $role = 'editor';
        $getRole = Role::where('id', $user_details->role)->get();
        if(sizeof($getRole) != 0){
            $role = $getRole[0]->name;
        }

        // Get shop info
        $shop = Shop::find($user_details->shop_id);
        $shopData = [];
        if($shop != null){
            $shopData = [
                'id' => $shop->id,
                'name' => $shop->name,
                'category' => $shop->category_id,
                'username' => $shop->username
            ];
        }
        return \response([
            'success' => true,
            'access_token' => $tokenResult->accessToken,
            'token_type' => 'Bearer',
            'expires_at' => Carbon::parse(
                $tokenResult->token->expires_at
            )->toDateTimeString(),
            'user' => [
                'identity' => $user_details->id,
                'first_name' => $user_details->first_name,
                'last_name' => $user_details->last_name,
                'email' => $user_details->email,
                'shop' => $shopData,
                'picture' => "",
                'role' => $role,
                'user_type' => 'manager',
                'verified' => ((int) $user_details->verified == 0) ? false : true,
                'registered' => $user_details->created_at
            ]
        ], Response::HTTP_CREATED);
    }

    /**
     * Authenticate Admins.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function adminLogin(Request $request)
    {
        $guard = 'admin';

        $this->middleware('guest:'. $guard .'-api');

        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only(['email', 'password']);

        if (!Auth::guard($guard)->attempt($credentials)) {
            return response(['success' => false, 'error' => 'Email or Password doesn\'t exist'], Response::HTTP_CREATED);
        }

        $user_details = Auth::guard($guard)->user();

        // Create token
        $tokenResult = $user_details->createToken('Personal Access Token');

        $token = $tokenResult->token;

        // Remember me option

        $token->expires_at = Carbon::now()->addWeeks(1);
        $token->save();

        return \response([
            'success' => true,
            'access_token' => $tokenResult->accessToken,
            'token_type' => 'Bearer',
            'expires_at' => Carbon::parse(
                $tokenResult->token->expires_at
            )->toDateTimeString(),
            'user' => [
                'identity' => $user_details->id,
                'first_name' => $user_details->first_name,
                'last_name' => $user_details->last_name,
                'email' => $user_details->email,
                'user_type' => 'admin',
                'picture' => "",
                'registered' => $user_details->created_at
            ]
        ], Response::HTTP_CREATED);
    }

    /**
     * Log out user
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function logout(Request $request)
    {
        $value = $request->bearerToken();
        $id = (new Parser())->parse($value)->getHeader('jti');

        DB::table('oauth_access_tokens')
            ->where('id', $id)
            ->update([
                'revoked' => true,
            ]);
        return response([
            'success' => true,
            'message' => "Successfully signed out"
        ]);
    }

}
