<?php

namespace App\Http\Controllers\Admin;

use App\Models\Shop\Shop;
use App\Models\Admin\Admin;
use Illuminate\Http\Request;
use App\Models\Admin\Partner;
use App\Models\Shop\Shop_manager;
use App\Http\Controllers\Controller;
use Symfony\Component\HttpFoundation\Response;

class PartnerController extends Controller
{
    public function __construct(){
        // $this->middleware('auth:admin');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Admin $admin)
    {
        // checkUser(auth()->user(), $admin);

        $show = Partner::all();
        $results = [];
        if($show != null){
            foreach($show as $info){
                $results[] = [
                    'id' => $info->id,
                    'data' => (array) json_decode($info->request_data),
                    'status' => $info->request_status,
                    'requested_at' => $info->created_at
                ];
            }
        }
        return response(['requests' => $results], Response::HTTP_CREATED);
    }

    public function approve(Admin $admin, Partner $partner_request, Request $request){
        $response = $request->response;
        if($response == null){
            return response(['success' => false, "error" => "request_incomplete"]);
        }

        $response = strtolower(trim($response));
        if($response != 'declined' && $response != 'approved'){
            return response(['success' => false, "error" => 'parameters_not_allowed']);
        }

        if($response == 'declined'){
            $partner_request->request_status = $response;
            $partner_request->save();

            return response(['success' => true, 'token' => ""]);
        }

        // If approved, create an account for the shop owner
        $user_data = (array) json_decode($partner_request->request_data);

        // Create and check if shop is already created
        $shops = Shop::all();
        $shop_exist = false;
        if($shops != null){
            foreach($shops as $shop){
                if(strtolower(trim($shop->name)) == strtolower(trim($user_data['shop_name']))){
                    $shop_exist = true;
                }
            }
        }

        if($shop_exist){
            return response(['success' => false, "error" => "shop_exists"]);
        }

        // Send email to shop owner
        $create_token = md5(now());

        $partner_request->request_token = $create_token;
        $partner_request->save();

        $shop_username = username($user_data['shop_name'], 'shop');
        $new_shop = new Shop;
        $new_shop->name = trim($user_data['shop_name']);
        $new_shop->username = $shop_username;
        $new_shop->location = $user_data['shop_location'];
        $new_shop->save();

        // Get recently created shop
        $recentShop = Shop::where('username', '=', $shop_username)->get();
        if(sizeof($recentShop) == 0){
            return response(['success' => false, "error" => "went_wrong"]);
        }

        $username = username($user_data['first_name'] .' '.$user_data['last_name'], 'manager');
        $shop_owner = new Shop_manager;
        $shop_owner->first_name = $user_data['first_name'];
        $shop_owner->last_name = $user_data['last_name'];
        $shop_owner->email = $user_data['email'];
        $shop_owner->username = $username;
        $shop_owner->number = $user_data['number'];
        $shop_owner->shop_id = $recentShop[0]->id;
        $shop_owner->role = 1;
        $shop_owner->save();

        return response(['success' => true, 'token' => $create_token]);

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Partner  $partner
     * @return \Illuminate\Http\Response
     */
    public function show(Partner $partner)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Partner  $partner
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Partner $partner)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Partner  $partner
     * @return \Illuminate\Http\Response
     */
    public function destroy(Partner $partner)
    {
        //
    }
}
