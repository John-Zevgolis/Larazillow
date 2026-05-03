<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Auth;

class IndexController extends Controller
{
    public function index() {
        // dd(Auth::user());
        // dd(Auth::check());

        return inertia('Index/Index', ['message' => 'Hello from laravel']);
    }
    public function show() {
        return inertia('Index/Show');
    }
}
