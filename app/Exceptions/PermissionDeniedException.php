<?php

namespace App\Exceptions;

use Exception;
use Symfony\Component\HttpFoundation\Response;

class PermissionDeniedException extends Exception
{
    public function render(){
    	return response(['message'=> 'Unauthenticated.'], Response::HTTP_UNAUTHORIZED);
    }
}
