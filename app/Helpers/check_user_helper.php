<?php

use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Exceptions\PermissionDeniedException;

if (!function_exists('checkUser')) {
    /**
     * Validates user making the request
     *
     * @param user data
     * User data
     * @param account data
     * Account data
     *
     * @return throw error if not validated true
     */
    function checkUser($user, $account)
    {
        $allowed = true;
        if(is_null($account) || is_null($user)){
            $allowed = false;
        }

        if ($user->id !== $account->id) {
            $allowed = false;
        }

        if(!$allowed) throw new PermissionDeniedException;
    }
}

if (!function_exists('autoLogin')) {
    /**
     * Automatically login users
     * @param credentials, "email" and "password"
     * @param user_type
     *
     * @return array
     */
    function autoLogin($credentials, $user_type)
    {
        if (!Auth::guard($user_type)->attempt($credentials)) {
            return ['success' => false];
        }

        $user = Auth::guard($user_type)->user();

        // Create token
        $tokenResult = $user->createToken('Personal Access Token');

        $token = $tokenResult->token;

        // Remember me option

        $token->expires_at = Carbon::now()->addWeeks(1);

        $user_details = auth($user_type)->user();
        $token->save();

        // Determine user type
        $account_user = "unknown";
        switch($user_type){
            case 'customer':
                $account_user = 'customer';
            break;
            case 'manager':
                $account_user = 'manager';
            break;
        }

        return [
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
                'verified' => false,
                'user_type' => $account_user,
                'registered' => $user_details->created_at,
            ],
        ];
    }
}
