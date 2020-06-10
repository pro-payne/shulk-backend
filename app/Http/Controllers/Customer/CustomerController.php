<?php

namespace App\Http\Controllers\Customer;

use Illuminate\Http\Request;
use App\Models\Customer\Customer;
use App\Http\Controllers\Controller;
use Symfony\Component\HttpFoundation\Response;

class CustomerController extends Controller
{
    public function __construct(){
        $this->middleware('auth:customer-api');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
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
     * @param  \App\customer  $customer
     * @return \Illuminate\Http\Response
     */
    public function show(Customer $customer)
    {
        checkUser(auth()->user(), $customer);

        $data = [
            'first_name' => $customer->first_name,
            'last_name' => $customer->last_name,
            'email' => $customer->email,
            'number' => $customer->number
        ];
        return response(['success' => true, 'data' => $data], Response::HTTP_CREATED);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Customer  $customer
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Customer $customer)
    {
        checkUser(auth()->user(), $customer);

        $request->validate([
            'first_name' => 'required|string',
            'last_name' => 'required|string',
            'number' => 'required|string',
            'email' => 'required|string|email'
        ]);

        $inputValues = $request->only(['first_name', 'last_name', 'email', 'number']);

        $username = username($inputValues['first_name']. ' '.$inputValues['last_name'], 'customer');
        if($username == ""){
            return response(['success' => false, "message" => "Failed to generate your username"], Response::HTTP_CREATED);
        }

        $customer->first_name = $inputValues['first_name'];
        $customer->last_name = $inputValues['last_name'];
        $customer->username = $username;
        $customer->number = $inputValues['number'];
        $customer->save();

        return response(['success' => true], Response::HTTP_CREATED);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\customer  $customer
     * @return \Illuminate\Http\Response
     */
    public function destroy(customer $customer)
    {
        //
    }
}
