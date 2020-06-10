<?php

namespace App\Http\Controllers\Admin;

use App\Models\Admin\Admin;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Symfony\Component\HttpFoundation\Response;

class AdminController extends Controller
{
    public function __construct(){
        $this->middleware('auth:admin-api');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Admin $admin)
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
     * @param  \App\Models\Admin  $admin
     * @return \Illuminate\Http\Response
     */
    public function show(Admin $admin)
    {
        checkUser(auth()->user(), $admin);

        $data = [
            'first_name' => $admin->first_name,
            'last_name' => $admin->last_name,
            'email' => $admin->email,
            'number' => $admin->number
        ];

        return response(['success' => true, 'data' => $data], Response::HTTP_CREATED);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Admin  $admin
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Admin $admin)
    {
        checkUser(auth()->user(), $admin);

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

        $admin->first_name = $inputValues['first_name'];
        $admin->last_name = $inputValues['last_name'];
        $admin->username = $username;
        $admin->number = $inputValues['number'];
        $admin->save();

        return response(['success' => true], Response::HTTP_CREATED);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Admin  $admin
     * @return \Illuminate\Http\Response
     */
    public function destroy(Admin $admin)
    {
        //
    }
}
