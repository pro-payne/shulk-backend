<?php

namespace App\Http\Controllers\Authenticate;

use Illuminate\Http\Request;
use App\Models\Admin\Partner;
use App\Models\Shop\Shop_manager;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class VerificationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    public function check_profile(Request $request)
    {
        $token = $request->token;
        if($token == null){
            return response(['success' => false]);
        }

        $check_account = Partner::where('request_token', '=', $token)->get();
        if(sizeof($check_account) == 0){
            return response(['success' => false]);
        }

        $info = (array) json_decode($check_account[0]->request_data);

        return response(['success' => true, 'data' => [
            'name' => $info['first_name'] .' '.$info['last_name']
        ]]);
    }

    public function complete_profile(Request $request)
    {
        $request->validate([
            'token' => 'required|string',
            'password' => 'required|string'
        ]);

        $check_account = Partner::where('request_token', '=', $request->token)->get();
        if(sizeof($check_account) == 0){
            return response(['success' => false, 'message' => 'token_invalid']);
        }

        $info = (array) json_decode($check_account[0]->request_data);

        $find_account = Shop_manager::where([
            ['email', '=', $info['email']]
        ])->get();
        if(sizeof($find_account) == 0){
            return response(['success' => false, 'message' => 'account_not_found']);
        }

        $find_account[0]->password = Hash::make($request->password);
        $find_account[0]->save();

        // Auto login the user
        $autoLogin = autoLogin([
            'email' => $info['email'],
            'password' => $request->password,
        ], 'manager');

        if (!$autoLogin['success']) {
            return response(['success' => false, 'error' => 'Email or Password doesn\'t exist'], Response::HTTP_CREATED);
        }

        unset($autoLogin['success']);

        // Then delete the partnership request
        $check_account[0]->delete();

        return response([
            'success' => true,
            'data' => [
                'msg' => "Welcome to Shrulk",
                'session' => $autoLogin
            ]
        ], Response::HTTP_CREATED);

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
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
