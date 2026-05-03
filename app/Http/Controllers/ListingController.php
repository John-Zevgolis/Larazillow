<?php

namespace App\Http\Controllers;

use App\Models\Listing;
use Illuminate\Http\Request;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;

class ListingController extends Controller
{
    // public static function middleware(): array {
    //     return [
    //         new Middleware('auth', except: ['index', 'show'])
    //     ];
    // }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        Gate::authorize('viewAny', Listing::class);

        $filters = $request-> only('priceFrom', 'priceTo', 'beds', 'baths', 'areaFrom', 'areaTo');

        return inertia('Listing/Index', ['filters' => $filters, 'listings' => Listing::mostRecent()->filter($filters)->withoutSold()->paginate(10)->withQueryString()]);
    }

    public function show(Listing $listing)
    {
        // if(Auth::user()->cannot('view', $listing)) {
        //     abort(403);
        // }

        Gate::authorize('view', $listing);

        $listing->load('images');
        $offer = !Auth::user() ? null : $listing->offers()->byMe()->first();

        return inertia('Listing/Show', ['listing' => $listing, 'offerMade' => $offer]);
    }
}
