<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Account;
use App\Models\Shade;
use Carbon\Carbon;

class ShadeController extends Controller
{
    public function index(Request $req){

        $data = array(
            'title'     => 'Farm',
            'shade' => Shade::latest()->get(),
        );
        
        return view('admin.shade.add_shade')->with($data);

    }


    public function store(Request $req){


        if(check_empty($req->shade_id)){
            $shade = Shade::findOrFail(hashids_decode($req->shade_id));
            $msg      = 'Farm udpated successfully';
        }else{
            $shade = new Shade();
            $msg      = 'Farm added successfully';
        }

        $shade->date              = $req->date;
        $shade->name              = $req->name;
        $shade->status            = $req->status;
        $shade->address           = $req->address;
        $shade->save();

        return response()->json([
            'success'   => $msg,
            'reload'    => true
        ]);

    }

    public function edit($id){

        $data = array(
            'title'     => 'Edit Farm',
            'shade' => Shade::latest()->get(),
            'edit_shade' => Shade::findOrFail(hashids_decode($id)),
            'is_update'     => true
        );
        return view('admin.shade.add_shade')->with($data);
    }

    public function delete($id){

        Shade::destroy(hashids_decode($id));
        return response()->json([
            'success'   => 'Shade deleted successfully',
            'reload'    => true
        ]);
    }

    public function getActiveFlock($shadeId)
    {
        $flock = Flock::where('shade_id', $shadeId)
                    ->where('status', 'active') // or ->where('is_active', 1)
                    ->first();

        return response()->json($flock);
    }



}
