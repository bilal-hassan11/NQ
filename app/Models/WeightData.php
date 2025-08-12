<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WeightData extends Model
{
    use HasFactory;

    protected $table = 'weightdata';

    protected $fillable = [
        'vno',
        'vtype',
        'vehicle_name',
        'party_id',
        'party_name',
        'material_id',
        'material_name',
        'container',
        'qty',
        'charges',
        'fwet',
        'fdate',
        'ftime',
        'fdatetime',
        'swet',
        'nwet',
        'sdate',
        'stime',
        'sdatetime',
        'munds',
        'munds2',
        'shift',
        'shift2',
        'status',
        'driver',
        'avg',
        'operator',
        'client_id',
        'client_name',
        'client_add',
        'MundsValue',
        'KgValue',
        'Narration',
        'Station',
        'whatsapp_no',
        'carrat_qty',
        'shade_no'
    ];
}