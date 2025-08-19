<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Account;
use App\Models\Mortality;
use App\Models\Item;
use App\Models\Shade;
use App\Models\ChickInvoice;

use Carbon\Carbon;


class MortalityController extends Controller
{
    public function index(Request $req){


        $data = array(
            'title'     => 'Shade Mortality',
            'shade' => Shade::latest()->get(),
            'mortality' => Mortality::with('shade')->latest()->get(),

        );
        return view('admin.mortality.add_mortality')->with($data);
    }

    public function store(Request $req)
    {
        
        $shadeId = hashids_decode($req->shade_id);
        
        $shade = Shade::with('chickInvoice')->find($shadeId);
        
        if (!$shade || !$shade->chickInvoice) {
            return response()->json([
                'error' => 'Chicks Are Not Available!.'
            ], 422);
        }

        // 2. Calculate already recorded mortality
        $totalMortality = Mortality::where('shade_id', $shadeId)->sum('quantity');

        // Get chick quantity from invoice
        $chickQty = ChickInvoice::where('shade_id',$shadeId)->sum('quantity');

        // Add new request mortality to existing ones
        $newTotal = $totalMortality + $req->quantity;

        if ($newTotal > $chickQty) {
            return response()->json([
                'error' => 'Mortality Quantity Exceeds Available Chicks. Available: ' . ($chickQty - $totalMortality)
            ], 422);
        }


        if (check_empty($req->flock_id)) {
            $mortality = Mortality::findOrFail(hashids_decode($req->flock_id));
            $msg = 'Shade Mortality updated successfully';
        } else {
            $mortality = new Mortality();
            $msg = 'Shade Mortality added successfully';
        }

        $mortality->date     = $req->date;
        $mortality->shade_id = $shadeId;
        $mortality->quantity = $req->quantity;
        $mortality->save();

        return response()->json([
            'success'  => $msg,
            'redirect' => route('admin.mortalitys.index')
        ]);
    }


    public function edit($id){

        $data = array(
            'title'     => 'Edit Shade Mortality',
            'shade' => Shade::latest()->get(),
            'mortality' => Mortality::latest()->get(),
            'edit_flock' => Mortality::with(['shade'])->findOrFail(hashids_decode($id)),
            'is_update'     => true
        );
        return view('admin.mortality.add_mortality')->with($data);
    }

    public function delete($id){
        Mortality::destroy(hashids_decode($id));
        return response()->json([
            'success'   => 'Mortality deleted successfully',
            'reload'    => true
        ]);
    }

}
