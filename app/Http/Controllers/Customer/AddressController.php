<?php

namespace App\Http\Controllers\Customer;

use Illuminate\Http\Request;
use App\Models\Customer\Address;
use App\Models\Customer\Customer;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class AddressController extends Controller
{
    public function __construct(){
        $this->middleware('auth:customer-api')->except('shipping');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Customer $customer)
    {
        checkUser(auth()->user(), $customer);

        $get_addresses = Address::where([
            ['customer_id', '=', $customer->id]
        ])->get();

        $data = [];
        foreach($get_addresses as $get_address){
            $lastAddress2 = "";
            $address2 = $get_address->address2;
            if($address2 != ''){
                $lastAddress2 = $address2 . ", ";
            }

            $lastAddress2 .= $get_address->town . ", " . $get_address->zip_code;
            $data[] = [
                'selected' => false,
                'id' => $get_address->id,
                'street' => $get_address->street,
                'zip' => $get_address->zip_code,
                'city' => $get_address->town,
                'address' => $get_address->address2,
                'address2' => $lastAddress2
            ];
        }
        return response(['data'=> $data]);
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

        $request->validate([
            'street' => 'required|string',
            'city' => 'required|string',
            'zip' => 'required|digits_between:4,5',
        ]);

        $address2 = ($request->address2 != null) ? $request->address2 : '';

        // Check if address is already added
        $check_address = Address::where([
            ['customer_id', '=', $customer->id],
            ['street', '=', $request->street],
            ['town', '=', $request->city],
            ['address2', '=', $address2],
            ['zip_code', '=', $request->zip]
        ])->get();

        if (sizeof($check_address) != 0) {
            return \response([
                'success' => false,
                'message' => 'Address is already saved'
            ], Response::HTTP_CREATED);
        }

        $address = new Address;
        $address->customer_id = $customer->id;
        $address->street = $request->street;
        $address->address2 = $address2;
        $address->town = $request->city;
        $address->zip_code = $request->zip;
        $address->save();

        // Get currently added address
        $currently_added = Address::where([
            ['customer_id', '=', $customer->id],
            ['street', '=', $request->street],
            ['town', '=', $request->city],
            ['address2', '=', $address2],
            ['zip_code', '=', $request->zip],
        ])->get();

        $lastAddress2 = "";
        if($address2 != ''){
            $lastAddress2 = $address2 . ", ";
        }

        $lastAddress2 .= $request->city . ", " . $request->zip;


        return \response([
            'success' => true,
            'message' => 'address_added',
            'address' => [
                'selected' => true,
                'id' => $currently_added[0]->id,
                'street' => $request->street,
                'zip' => $request->zip,
                'city' => $request->city,
                'address' => $address2,
                'address2' => $lastAddress2
            ]
        ], Response::HTTP_CREATED);
    }

    /**
     * Store and create user account if email address doesn't exist.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function shipping(Request $request)
    {
        $request->validate([
            'first_name' => 'required|string',
            'last_name' => 'required|string',
            'email' => 'required|string|email',
            'password' => 'required|string',
            'number' => 'required|string',
            'street' => 'required|string',
            'city' => 'required|string',
            'zip' => 'required|digits_between:4,5',
        ]);

        $accountValues = $request->only(['email', 'first_name', 'password', 'last_name', 'number']);
        $email = strtolower(trim($accountValues['email']));

        // Check if email exist
        $checkEmail = Customer::where('email', $email)->get()->count();
        if ($checkEmail != 0) {
            return response(['success' => false, 'type' => 'email_exist', 'message' => "Email address is already registered on the system, simply log in to continue"], Response::HTTP_CREATED);
        }

        $username = username($accountValues['first_name'] . ' ' . $accountValues['last_name'], 'customer');
        if ($username == "") {
            return response(['success' => false, 'type' => 'username', "message" => "Failed to generate your username, try again"], Response::HTTP_CREATED);
        }

        // if not exist, automatically create an account for the user
        $account = new Customer;
        $account->first_name = $accountValues['first_name'];
        $account->last_name = $accountValues['last_name'];
        $account->email = $email;
        $account->number = $accountValues['number'];
        $account->username = $username;
        $account->password = Hash::make($accountValues['password']);
        $account->save();

        $autoLogin = autoLogin([
            'email' => $email,
            'password' => $accountValues['password'],
        ], 'customer');

        if (!$autoLogin['success']) {
            return response(['success' => false, 'type' => '', 'message' => 'Email or Password doesn\'t exist'], Response::HTTP_CREATED);
        }

        unset($autoLogin['success']);

        $user = $autoLogin['user']['identity'];
        $address2 = ($request->address2 != null) ? $request->address2 : '';

        // then use that account info to save the delivery address
        $address = new Address;
        $address->customer_id = $user;
        $address->street = $request->street;
        $address->address2 = $address2;
        $address->town = $request->city;
        $address->zip_code = $request->zip;
        $address->save();

        // Get currently added address
        $currently_added = Address::where([
            ['customer_id', '=', $user],
            ['street', '=', $request->street],
            ['town', '=', $request->city],
            ['address2', '=', $address2],
            ['zip_code', '=', $request->zip],
        ])->get();

        $lastAddress2 = "";
        if($address2 != ''){
            $lastAddress2 = $address2 . ", ";
        }

        $lastAddress2 .= $request->city . ", " . $request->zip;

        return response([
            'success' => true,
            'data' => [
                'msg' => "Welcome to Shrulk",
                'address' =>  [
                    'selected' => true,
                    'id' => $currently_added[0]->id,
                    'street' => $request->street,
                    'address2' => $lastAddress2
                ],
                'session' => $autoLogin
            ]
        ], Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Address  $address
     * @return \Illuminate\Http\Response
     */
    public function show(Addresses $addresses)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Address  $address
     * @return \Illuminate\Http\Response
     */
    public function update(Customer $customer, Request $request, Address $address)
    {
        checkUser(auth()->user(), $customer);

        if($customer->id != $address->customer_id){
            return response(['success' => false, 'message' => "Request is not allowed"]);
        }

        $address2 = ($request->address2 != null) ? $request->address2 : '';

        $address->street = trim($request->street);
        $address->address2 = $address2;
        $address->town = $request->city;
        $address->zip_code = $request->zip;
        $address->save();

        return \response([
            'success' => true
        ], Response::HTTP_CREATED);

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Address  $address
     * @return \Illuminate\Http\Response
     */
    public function destroy(Customer $customer, Address $address)
    {
        checkUser(auth()->user(), $customer);
        if($customer->id != $address->customer_id){
            return response(['success' => false, 'message' => "Request is not allowed"]);
        }

        $address->delete();

        return \response([
            'success' => true
        ], Response::HTTP_CREATED);
    }
}
