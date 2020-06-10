<?php

use App\Models\Admin;
use App\Models\Shop\Shop;
use App\Models\Customer\Customer;
use App\Models\Shop\Shop_manager;

if (!function_exists('username_generator')) {

    /**
     * Generate unique usernames for users
     *
     * username_generator() will return unique username.
     *
     * @access    public
     * @param    $user_type type of user, $name to generate username from, $length of the username, $lower_case whether to be lower case, $return is true then return generated username, else check if exists
     *
     * @return    return array
     */
    function username_generator($user_type, $name, $length, $lower_case = false, $start = 0, $replace = 0)
    {
        $name = str_replace(' ', '-', $name); // Replaces all spaces with hyphens.
        $name = preg_replace('/-+/', '-', $name);

        if ($lower_case) {
            $ucaseFirst = $name;
        } else {
            $ucaseFirst = ucfirst($name);
        }
        if ($replace != 0) {
            $length -= strlen($replace);
            $append = $replace;
        } else {
            $append = '';
        }
        $generated_username = substr($ucaseFirst, $start, $length) . $append;
        $generated_username = preg_replace('/[^A-Za-z0-9\-]/', '', strtolower($generated_username));

        $exist = false;
        $count = 0;
        switch ($user_type) {
            case 'admin':
                $usernames = Admin::all()->only('username');
                break;
            case 'manager':
                $usernames = Shop_manager::all()->only('username');
                break;
            case 'shop':
                $usernames = Shop::all()->only('username');
                break;
            case 'customer':
                $usernames = Customer::all()->only('username');
                break;
        }

        foreach ($usernames as $username) {
            if (strtolower($generated_username) == strtolower($username->username)) {
                $exist = true;
            }
        }
        return array(
            'username' => $generated_username,
            'exist' => $exist,
        );
    }

}

if (!function_exists('username')) {

    /**
     * Generating a unique username for different users,
     * user types: customer, manager, shop, admin
     */
    function username($name, $user_type, $length = 13)
    {
        $count = 0;
        $end = $length;
        $s = array(
            'username' => '',
            'exist' => true,
        );
        while ($s['exist']) {
            $s = username_generator($user_type, $name, $end, true, 0, $count);
            $count++;
        }
        return $s['username'];
    }
}
