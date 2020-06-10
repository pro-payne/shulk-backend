<?php

namespace App\Http\Controllers\Shop;

use Illuminate\Http\Request;
use App\Models\Shop\Shop_manager;
use App\Http\Controllers\Controller;
use Symfony\Component\HttpFoundation\Response;

class ShopManagerController extends Controller
{
    public function __construct(){
        $this->middleware('auth:manager-api');
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
     * @param  \App\Models\Shop_manager  $shop_manager
     * @return \Illuminate\Http\Response
     */
    public function show(Shop_manager $manager)
    {
        checkUser(auth()->user(), $manager);

        $data = [
            'first_name' => $manager->first_name,
            'last_name' => $manager->last_name,
            'email' => $manager->email,
            'number' => $manager->number
        ];

        return response(['success' => true, 'data' => $data], Response::HTTP_CREATED);

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Shop_manager  $shop_manager
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Shop_manager $manager)
    {
        checkUser(auth()->user(), $manager);

        $request->validate([
            'first_name' => 'required|string',
            'last_name' => 'required|string',
            'number' => 'required|string',
            'email' => 'required|string|email'
        ]);

        $inputValues = $request->only(['first_name', 'last_name', 'email', 'number']);

        $username = username($inputValues['first_name']. ' '.$inputValues['last_name'], 'manager');
        if($username == ""){
            return response(['success' => false, "message" => "Failed to generate your username"], Response::HTTP_CREATED);
        }

        $manager->first_name = $inputValues['first_name'];
        $manager->last_name = $inputValues['last_name'];
        $manager->username = $username;
        $manager->number = $inputValues['number'];
        $manager->save();

        return response(['success' => true], Response::HTTP_CREATED);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Shop_manager  $shop_manager
     * @return \Illuminate\Http\Response
     */
    public function destroy(Shop_manager $shop_manager)
    {
        //
    }
}
