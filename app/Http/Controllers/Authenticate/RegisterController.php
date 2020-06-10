<?php

namespace App\Http\Controllers\Authenticate;

use Carbon\Carbon;
use App\Models\Admin;
use App\Models\Partner;
use App\Models\Shop\Role;
use App\Models\Shop\Shop;
use Illuminate\Http\Request;
use App\Models\Customer\Customer;
use App\Models\Shop\Shop_manager;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class RegisterController extends Controller
{
    /**
     * Register Customers.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function customerRegister(Request $request)
    {
        $request->validate([
            'first_name' => 'required|string',
            'last_name' => 'required|string',
            'email' => 'required|string|email',
            'number' => 'required|string',
            'password' => 'required|string',
        ]);

        $inputValues = $request->only(['email', 'password', 'first_name', 'last_name', 'number']);

        // Check if email is unique
        $email = strtolower(trim($inputValues['email']));

        $uniqueEmail = Customer::where('email', $email)->get()->count();

        if ($uniqueEmail != 0) {
            return response(['success' => false, "error" => "Email address already in use, try again",
            ], Response::HTTP_CREATED);
        }

        $username = username($inputValues['first_name']. ' '.$inputValues['last_name'], 'customer');
        if($username == ""){
            return response(['success' => false, "error" => "Failed to generate your username, try again"], Response::HTTP_CREATED);
        }

        $account = new Customer;
        $account->first_name = $inputValues['first_name'];
        $account->last_name = $inputValues['last_name'];
        $account->email = $email;
        $account->number = $inputValues['number'];
        $account->username = $username;
        $account->password = Hash::make($inputValues['password']);
        $account->save();

        $autoLogin = autoLogin([
            'email' => $email,
            'password' => $inputValues['password'],
        ], 'customer');

        if (!$autoLogin['success']) {
            return response(['success' => false, 'error' => 'Email or Password doesn\'t exist'], Response::HTTP_CREATED);
        }

        unset($autoLogin['success']);

        return response([
            'success' => true,
            'data' => [
                'msg' => "Welcome to Shrulk",
                'session' => $autoLogin
            ]
        ], Response::HTTP_CREATED);

    }

    /**
     * Register Shop Owners.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    private function managerRegister(Request $request){

        $request->validate([
            'first_name' => 'required|string',
            'last_name' => 'required|string',
            'email' => 'required|string|email',
            'number' => 'required|string',
            'role' => 'required|string',
            'password' => 'required|string',
        ]);

        $inputValues = $request->only(['email', 'password', 'first_name', 'last_name', 'role', 'number']);

        // Check if email is unique
        $email = strtolower(trim($inputValues['email']));

        $uniqueEmail = Shop_manager::where('email', $email)->get()->count();

        if ($uniqueEmail != 0) {
            return response(['success' => false, "error" => "Email address already in use, try again",
            ], Response::HTTP_CREATED);
        }

        $username = username($inputValues['first_name']. ' '.$inputValues['last_name'], 'manager');
        if($username == ""){
            return response(['success' => false, "error" => "Failed to generate your username"], Response::HTTP_CREATED);
        }

        // Find the selected role
        $myRole = 2;
        $role = Role::where('name', strtolower(trim($inputValues['role'])))->get();
        if(sizeof($role) != 0){
            $myRole = (int) $role[0]->id;
        }

        $account = new Shop_manager;
        $account->first_name = $inputValues['first_name'];
        $account->last_name = $inputValues['last_name'];
        $account->email = $email;
        $account->number = $inputValues['number'];
        $account->username = $username;
        $account->role = $myRole;
        $account->password = Hash::make($inputValues['password']);
        $account->save();

        $autoLogin = autoLogin([
            'email' => $email,
            'password' => $inputValues['password'],
        ], 'manager');

        if (!$autoLogin['success']) {
            return response(['success' => false, 'error' => 'Email or Password doesn\'t exist'], Response::HTTP_CREATED);
        }

        unset($autoLogin['success']);

        return response([
            'success' => true,
            'data' => [
                'msg' => "Welcome to Shrulk",
                'session' => $autoLogin
            ]
        ], Response::HTTP_CREATED);
    }

    /**
     * Register Admin.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function adminRegister(Request $request){

        $request->validate([
            'first_name' => 'required|string',
            'last_name' => 'required|string',
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $inputValues = $request->only(['email', 'password', 'first_name', 'last_name']);

        // Check if email is unique
        $email = strtolower(trim($inputValues['email']));

        $uniqueEmail = Admin::where('email', $email)->get()->count();

        if ($uniqueEmail != 0) {
            return response(['success' => false, "error" => "Email address already in use, try again",
            ], Response::HTTP_CREATED);
        }

        $username = username($inputValues['first_name']. ' '.$inputValues['last_name'], 'admin');
        if($username == ""){
            return response(['success' => false, "error" => "Failed to generate your username"], Response::HTTP_CREATED);
        }

        $account = new Admin;
        $account->first_name = $inputValues['first_name'];
        $account->last_name = $inputValues['last_name'];
        $account->email = $email;
        $account->username = $username;
        $account->password = Hash::make($inputValues['password']);
        $account->save();

        // $autoLogin = autoLogin([
        //     'email' => $email,
        //     'password' => $inputValues['password'],
        // ], 'admin');

        // if (!$autoLogin['success']) {
        //     return response(['success' => false, 'error' => 'Email or Password doesn\'t exist'], Response::HTTP_CREATED);
        // }

        // unset($autoLogin['success']);

        return response([
            'success' => true,
            'data' => [
                'msg' => "Welcome to Shrulk",
                // 'session' => $autoLogin
            ]
        ], Response::HTTP_CREATED);
    }

    public function becomePartner(Request $request){

        $request->validate([
            'full_name' => 'required|string',
            'email' => 'required|string|email',
            'number' => 'required|string',
            'shop_name' => 'required|string',
            'shop_location' => 'required|string',
            'note' => 'required|string',
        ]);

        $inputValues = $request->only(['email', 'full_name', 'note', 'number', 'shop_location', 'shop_name']);

        // Check if email is unique
        $email = strtolower(trim($inputValues['email']));

        $uniqueEmail = Shop_manager::where('email', $email)->get()->count();

        if ($uniqueEmail != 0) {
            return response(['success' => false, "error" => "email_exists",
            ], Response::HTTP_CREATED);
        }

        $username = username($inputValues['full_name'], 'manager');
        if($username == ""){
            return response(['success' => false, "error" => "username_failed"], Response::HTTP_CREATED);
        }

        // Check if shop is already created
        $shops = Shop::all();
        $shop_exist = false;
        if($shops != null){
            foreach($shops as $shop){
                if(strtolower(trim($shop->name)) == strtolower(trim($inputValues['shop_name']))){
                    $shop_exist = true;
                }
            }
        }

        if($shop_exist){
            return response(['success' => false, "error" => "shop_exists"], Response::HTTP_CREATED);
        }

        $name_split = explode(' ', trim($inputValues['full_name']));
        $partner = new Partner;
        $partner->request_data = json_encode([
            'first_name' => $name_split[0],
            'last_name' => $name_split[1],
            'email' => $inputValues['email'],
            'number' => $inputValues['number'],
            'note' => $inputValues['note'],
            'shop_name' => $inputValues['shop_name'],
            'shop_location' => $inputValues['shop_location']
        ]);
        $partner->save();

        return response([
            'success' => true,
            'message' => 'Request has been sent'
        ], Response::HTTP_CREATED);
    }

}
