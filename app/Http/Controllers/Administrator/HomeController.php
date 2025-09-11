<?php

namespace App\Http\Controllers\Administrator;

use App\Http\Controllers\Administrator\AdminController;
use App\Models\Item;
use App\Models\Account;
use App\Models\Staff;
use App\Models\FeedInvoice;
use App\Models\Flock;
use App\Models\Shade;

use App\Models\ChickInvoice;
use App\Models\MurghiInvoice;
use App\Models\MedicineInvoice;
use App\Models\CashBook;
use App\Models\Expense;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HomeController extends AdminController
{   

    public function profitReportAjax(Request $request)
    {
        $month = $request->input('month', now()->format('Y-m'));

        $profits = DB::table('murghi_invoices')
            ->selectRaw('DATE(date) as invoice_date')
            ->selectRaw("SUM(CASE WHEN type = 'sale' THEN net_amount ELSE 0 END) as total_sale")
            ->selectRaw("SUM(CASE WHEN type = 'purchase' THEN net_amount ELSE 0 END) as total_purchase")
            ->selectRaw("
                SUM(CASE WHEN type = 'sale' THEN net_amount ELSE 0 END) -
                SUM(CASE WHEN type = 'purchase' THEN net_amount ELSE 0 END)
                as profit
            ")
            ->whereNull('deleted_at')
            ->whereRaw("DATE_FORMAT(date, '%Y-%m') = ?", [$month])
            ->groupByRaw('DATE(date)')
            ->orderBy('invoice_date', 'asc')
            ->get();

        return response()->json($profits);
    }

    public function profitReport(Request $request)
    {
        $month = $request->input('month', now()->format('Y-m')); // Default: current month

        $profits = DB::table('murghi_invoice')
            ->select(
                DB::raw('DATE(date) as invoice_date'),
                DB::raw("SUM(CASE WHEN type = 'sale' THEN net_amount ELSE 0 END) as total_sale"),
                DB::raw("SUM(CASE WHEN type = 'purchase' THEN net_amount ELSE 0 END) as total_purchase"),
                DB::raw("SUM(CASE WHEN type = 'sale' THEN net_amount ELSE 0 END) - SUM(CASE WHEN type = 'purchase' THEN net_amount ELSE 0 END) as profit")
            )
            ->whereNull('deleted_at')
            ->whereRaw("DATE_FORMAT(date, '%Y-%m') = ?", [$month]) // filter by month-year
            ->groupBy(DB::raw('DATE(date)'))
            ->orderBy('invoice_date', 'asc')
            ->get();

        return view('reports.profit', compact('profits', 'month'));
    }

    public function index()
    {
        $current_month = date('m');

        //Murghi 
        $tot_sale_murghi_qty = MurghiInvoice::where('type', 'Sale')->where('date', $current_month)->sum('quantity');
        $tot_sale_murghi_ammount = MurghiInvoice::where('type', 'Sale')->where('date', $current_month)->sum('net_amount');

        $tot_purchase_murghi_qty = MurghiInvoice::where('type', 'Purchase')->where('date', $current_month)->sum('quantity');
        $tot_purchase_murghi_ammount = MurghiInvoice::where('type', 'Purchase')->where('date', $current_month)->sum('net_amount');

        //Expense
        $tot_expense = Expense::where('date', $current_month)->sum('ammount');

        //CashBook
        $tot_credit = CashBook::where('entry_date', $current_month)->sum('receipt_ammount');
        $tot_debit = CashBook::where('entry_date', $current_month)->sum('payment_ammount');
        $tot_cash_in_hand = $tot_debit - $tot_credit;


        $newDateTime = Carbon::now()->addMonth(2);
        $d = $newDateTime->toDateString();

        
        $month = date('m');
        $data = array(
            "title"     => "Dashboad",
            
            'tot_sale_murghi_qty' => $tot_sale_murghi_qty,
            'tot_sale_murghi_ammount' => $tot_sale_murghi_ammount,
            'tot_purchase_murghi_qty' => $tot_purchase_murghi_qty,
            'tot_purchase_murghi_ammount' => $tot_purchase_murghi_ammount,

            'active_accounts'  => Account::where('status', '1')->latest()->get()->count(),
            'active_users'  => Staff::where('is_active', '1')->latest()->get()->count(),

        );
        //dd($data);
        return view('admin.home')->with($data);
    }

    public function web()
    {
        return view('admin.web');
    }
}
