<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Account;
use App\Models\Flock;
use Carbon\Carbon;
use App\Models\Shade;

class FlockController extends Controller
{
    public function index(Request $req){


        $data = array(
            'title'     => 'Flock',
            'flock' => Flock::with(['shade'])->latest()->get(),
            'shade' => Shade::latest()->get(),
        );

        return view('admin.flock.add_flock')->with($data);

    }


    public function store(Request $req){


        if(check_empty($req->flock_id)){

            $Flock = Flock::findOrFail($req->flock_id);
            $msg      = 'Flock udpated successfully';
        }else{

            $Flock = new Flock();
            $msg      = 'Flock added successfully';
        }

        $Flock->start_date       = $req->start_date;
        $Flock->shade_id         = $req->shade;
        $Flock->name              = $req->name;
        $Flock->status            = $req->status;
        $Flock->save();

        return response()->json([
            'success'   => $msg,
            'reload'    => true
        ]);

    }

    public function edit($id){

        $data = array(
            'title'     => 'Edit Flock',
            'flock' => Flock::latest()->get(),
            'shade' => Shade::latest()->get(),
            'edit_flock' => Flock::findOrFail(hashids_decode($id)),
            'is_update'     => true
        );
        return view('admin.Flock.add_Flock')->with($data);
    }

    public function delete($id){

        Flock::destroy(hashids_decode($id));
        return response()->json([
            'success'   => 'Flock deleted successfully',
            'reload'    => true
        ]);
    }


}
