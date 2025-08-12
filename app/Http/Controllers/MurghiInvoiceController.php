<?php

namespace App\Http\Controllers;

use App\Models\MurghiInvoice;
use App\Models\Account;
use App\Models\Item;
use App\Models\Shade;
use Illuminate\Support\Facades\DB;
use App\Models\AccountLedger;
use App\Models\WeightData;
use App\Traits\GeneratePdfTrait;
use Illuminate\Http\Request;
use App\Traits\SendsWhatsAppMessages;
use Mpdf\Mpdf;

class MurghiInvoiceController extends Controller
{

    use SendsWhatsAppMessages;
    use GeneratePdfTrait;
    protected $MurghiInvoice;

    public function __construct(MurghiInvoice $MurghiInvoice)
    {
        $this->MurghiInvoice = $MurghiInvoice;
    }

    public function createPurchase(Request $req)
    {
        $title = "Sale Murghi";
        $invoice_no = generateUniqueID(new MurghiInvoice, 'Sale', 'invoice_no');
        $accounts = Account::with(['grand_parent', 'parent'])->latest()->orderBy('name')->get();
        $shade = Shade::latest()->get();
        $products = Item::where('category_id', 8)->get();
        $weight_data = WeightData::latest('srno')->get();

        $purchase_Murghi = MurghiInvoice::with('account', 'item')
            ->where('type', 'Sale')
            ->when(isset($req->account_id), function ($query) use ($req) {
                $query->where('account_id', hashids_decode($req->account_id));
            })
            ->when(isset($req->invoice_no), function ($query) use ($req) {
                $query->where('invoice_no', $req->invoice_no);
            })
            ->when(isset($req->item_id), function ($query) use ($req) {
                $query->where('item_id', hashids_decode($req->item_id));
            })
            ->when(isset($req->from_date, $req->to_date), function ($query) use ($req) {
                $query->whereBetween('date', [$req->from_date, $req->to_date]);
            })
            ->latest()
            ->get();

        $pending_Murghi = MurghiInvoice::with('account', 'item')
            ->where('type', 'Sale')
            ->where('net_amount', 0)
            ->latest()
            ->get();

        return view('admin.murghi.purchase_murghi', compact(['title', 'shade', 'pending_Murghi', 'invoice_no', 'accounts', 'products', 'purchase_Murghi', 'weight_data']));
    }

    public function editPurchase($invoice_no)
    {
        $title = "Edit Sale Murghi";
        $accounts = Account::with(['grand_parent', 'parent'])->latest()->orderBy('name')->get();
        $products = Item::where('category_id', 8)->get();
        $shade = Shade::latest()->get();
        $MurghiInvoice = MurghiInvoice::where('invoice_no', $invoice_no)
            ->where('type', 'Sale')
            ->with('account', 'item')
            ->get();

        return view('admin.murghi.edit_purchase_murghi', compact(['title', 'shade', 'accounts', 'products', 'MurghiInvoice']));
    }

    /**
     * Store a newly created resource in storage.
     */

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'invoice_no' =>  'required',
            'date' => 'required|date',
            'shade' => 'required|exists:shades,id',
            'account' => 'required|exists:accounts,id',
            'ref_no' => 'nullable|string|max:255',
            'description' => 'nullable|string',
            'item_id.*' => 'required|exists:items,id',
            'id.*' => 'nullable',
            'purchase_price.*' => 'required|numeric',
            'qty.*' => 'required|numeric',
            'no_of_carats.*' => 'required|numeric',
            'sale_price.*' => 'required|numeric',
            'weight.*' => 'required|numeric',
            'weight_detection.*' => 'required|numeric',
            'extra_detection.*' => 'required|numeric',
            'quantity.*' => 'required|numeric',
            'amount.*' => 'required|numeric',
            'discount_in_rs.*' => 'nullable|numeric',
            'discount_in_percent.*' => 'nullable|numeric',
            'expiry_date.*' => 'nullable|date',
            'whatsapp_status' => 'nullable|boolean',
        ]);

        $date = $request->input('date');

        // if ($request->type == 'Sale' || $request->type == 'Adjust Out') {
        //     $stockErrors = $this->validateStockQuantities($validatedData);

        //     if (!empty($stockErrors)) {
        //         return response()->json(['errors' => $stockErrors], 422);
        //     }
        // }

        DB::beginTransaction();
        if ($request->has('editMode')) {
            $invoiceNumber = $request->invoice_no;
            $MurghiInvoices = MurghiInvoice::where('invoice_no', $invoiceNumber)
                ->where('type', 'Sale')
                ->get();
            $MurghiInvoiceIds = $MurghiInvoices->pluck('id');
            MurghiInvoice::whereIn('id', $MurghiInvoiceIds)->delete();
            AccountLedger::whereIn('murghi_invoice_id', $MurghiInvoiceIds)
                ->where('type', 'Sale')
                ->delete();
        } else {
            $invoiceNumber = generateUniqueID(new MurghiInvoice, $request->type, 'invoice_no');
        }

        try {

            $items = $validatedData['item_id'];
            foreach ($items as $index => $itemId) {

                $price =  $validatedData['purchase_price'][$index];
                $netAmount = ($price * $validatedData['quantity'][$index]) - ($validatedData['discount_in_rs'][$index] ?? 0);


                $MurghiInvoice = MurghiInvoice::create([
                    'date' => $date,
                    'shade_id' => $validatedData['shade'],
                    'account_id' => $validatedData['account'],
                    'ref_no' => $validatedData['ref_no'],
                    'description' => $validatedData['description'],
                    'invoice_no' => $invoiceNumber,
                    'type' => 'Sale',
                    'stock_type' =>  'Out',
                    'item_id' => $itemId,
                    'qty' => $validatedData['qty'][$index],
                    'no_of_carats' => $validatedData['no_of_carats'][$index],
                    'purchase_price' => $validatedData['sale_price'][$index],
                    'sale_price' => $validatedData['purchase_price'][$index],
                    'weight' => $validatedData['weight'][$index],
                    'weight_detection' => $validatedData['weight_detection'][$index],
                    'extra_detection' => $validatedData['extra_detection'][$index],
                    'quantity' =>  -$validatedData['quantity'][$index],
                    'amount' => $validatedData['amount'][$index],
                    'discount_in_rs' => $validatedData['discount_in_rs'][$index] ?? 0,
                    'discount_in_percent' => $validatedData['discount_in_percent'][$index] ?? 0,
                    'total_cost' =>  $netAmount,
                    'net_amount' => $netAmount,
                    'expiry_date' => $validatedData['expiry_date'][$index] ?? null,
                    'whatsapp_status' => $validatedData['whatsapp_status'] ?? 'Not Sent',
                ]);
                $item = Item::find($itemId);

                AccountLedger::create([
                    'murghi_invoice_id' => $MurghiInvoice->id,
                    'shade_id' => $validatedData['shade'],
                    'type'  => $request->type,
                    'date' => $date,
                    'account_id' => $validatedData['account'],
                    'description' => 'Invoice #: ' . $invoiceNumber . ', ' . 'Item: ' . $item->name . ', Qty: ' . $validatedData['quantity'][$index] . ', Rate: ' . $price,
                    'debit' => in_array($request->type, ['Sale', 'Adjust Out']) ? $netAmount : 0,
                    'credit' => in_array($request->type, ['Purchase', 'Adjust In']) ? $netAmount : 0,
                ]);
            }

            DB::commit();

            return response()->json(['success' => true], 201);
        } catch (\Exception $e) {
            info($e);
            DB::rollBack();
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    private function validateStockQuantities($validatedData)
    {
        $products = $this->MurghiInvoice->getStockInfo();

        $stockErrors = [];
        $stockQuantities = [];

        foreach ($validatedData['id'] as $index => $item_id) {
            $quantity = $validatedData['quantity'][$index];
            $stockQuantities[$item_id] = isset($stockQuantities[$item_id]) ? $stockQuantities[$item_id] + $quantity : $quantity;
        }

        foreach ($stockQuantities as $item_id => $summedQuantity) {
            $filteredProducts = $products->filter(function ($product) use ($item_id) {
                return $product->id == $item_id;
            });

            if ($filteredProducts->isEmpty()) {
                $stockErrors["item_id.$item_id"] = ['Product not found'];
            } else {
                $totalStockQuantity = $filteredProducts->sum('quantity');
                if ($totalStockQuantity < $summedQuantity) {
                    $itemName = $filteredProducts->first()->name;
                    $stockErrors["item_id.$item_id"] = ['Insufficient stock for item ' . $itemName];
                }
            }
        }

        return $stockErrors;
    }

    public function singleReturn(Request $request)
    {
        $validatedData = $request->validate([
            'Murghi_invoice_id' => 'required|exists:Murghi_invoices,id',
            'quantity' => 'required|integer|min:1',
            'description' => 'nullable|string',
            'type' => 'required',
        ]);
        $type = $validatedData['type'];

        $originalInvoice = $this->MurghiInvoice->findOrFail($validatedData['Murghi_invoice_id']);

        $stockInfo = $this->MurghiInvoice->getStockInfo();

        $stock = $stockInfo->first(function ($item) use ($originalInvoice) {
            return $item->item_id == $originalInvoice->item_id
                && $item->expiry_date == $originalInvoice->expiry_date;
        });

        if (!$stock) {
            return response()->json(['error' => 'Stock not found for the given item and expiry date'], 422);
        }

        if ($type == 'Purchase Return') {
            $price = $originalInvoice->purchase_price;
            if ($stock->quantity < $validatedData['quantity']) {
                return response()->json(['error' => 'Insufficient stock for the return. (' . $stock->quantity . ')'], 422);
            }
        } else {
            $price = $originalInvoice->sale_price;
        }


        DB::beginTransaction();
        try {
            $invoiceNumber = generateUniqueID(new MurghiInvoice, $type, 'invoice_no');
            $amount =  $price * $validatedData['quantity'];
            $netAmount = $amount - $originalInvoice->discount_in_rs;


            $MurghiInvoice = MurghiInvoice::create([
                'date' => now(),
                'account_id' => $originalInvoice->account_id,
                'ref_no' => $validatedData['Murghi_invoice_id'],
                'description' => $validatedData['description'],
                'invoice_no' => $invoiceNumber,
                'type' => $validatedData['type'],
                'stock_type' => ($type == 'Purchase Return') ? 'Out' : 'In',
                'item_id' => $originalInvoice->item_id,
                'purchase_price' => $originalInvoice->purchase_price,
                'sale_price' =>  $originalInvoice->sale_price,
                'weight' =>  $originalInvoice->weight,
                'weight_detection' =>  $originalInvoice->weight_detection,
                'quantity' => ($type == 'Purchase Return') ?  -$validatedData['quantity'] : $validatedData['quantity'],
                'amount' => $amount,
                'discount_in_rs' => $originalInvoice->discount_in_rs,
                'discount_in_percent' => $originalInvoice->discount_in_percent,
                'total_cost' => (($type == 'Purchase Return') ? -$netAmount : $amount),
                'net_amount' => $netAmount,
                'expiry_date' => $originalInvoice->expiry_date,
                'whatsapp_status' => 'Not Sent',
            ]);

            $debit = 0;
            $credit = 0;


            if ($type === 'Sale Return') {
                $credit = $netAmount;
            } else {
                $debit = $netAmount;
            }
            $items = Item::find($originalInvoice->item_id);
            AccountLedger::create([
                'murghi_invoice_id' => $MurghiInvoice->id,
                'type'  => $type,
                'date' => now(),
                'account_id' => $originalInvoice->account_id,
                'description' => 'Return #: ' . $invoiceNumber . ', ' . 'Item: ' . $items->name . ', Qty: ' . $validatedData['quantity'] . ', Rate: ' . $price,
                'debit' => $debit,
                'credit' => $credit,

            ]);
            if ($request->type == 'Sale') {
                $MurghiInvoice = MurghiInvoice::where('invoice_no', $MurghiInvoice->invoice_no)
                    ->where('type', $request->type)
                    ->with('account', 'item')
                    ->get();
                $previous_balance = $MurghiInvoice[0]->account->getBalance($MurghiInvoice[0]->date);
                $htmlContent = view('admin.medicine.invoice_pdf', compact('MurghiInvoice', 'previous_balance'))->render();
                $pdfPath = $this->generatePdf($htmlContent, 'MurghiSale-' . $MurghiInvoice[0]->invoice_no);
                $result = $this->sendWhatsAppMessage($MurghiInvoice[0]->account->phone_no, 'Sale Invoice', $pdfPath);
            }
            DB::commit();

            return response()->json(['success' => true], 201);
        } catch (\Exception $e) {
            info($e);
            DB::rollBack();
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    /**
     * Display the specified resource.
     */

    public function show($invoice_no)
    {

        $url = request()->url();
        preg_match('/\/(\w+)(?=\/\d+)/', $url, $matches);
        $type = isset($matches[1]) ? ucfirst($matches[1]) : 'Purchase';

        $MurghiInvoice = MurghiInvoice::where('invoice_no', $invoice_no)
            ->where('type', $type)
            ->with('account', 'item')
            ->get();

        if ($MurghiInvoice->isEmpty()) {
            abort(404, 'Murghi Invoice not found');
        }

        $MurghiInvoiceIds = $MurghiInvoice->pluck('id');
        $returnType = $type . ' Return';

        $previous_balance = $MurghiInvoice[0]->account->getBalance($MurghiInvoice[0]->date);

        $returnedQuantities = MurghiInvoice::whereIn('ref_no', $MurghiInvoiceIds)
            ->where('type', $returnType)
            ->groupBy('ref_no')
            ->select('ref_no', DB::raw('SUM(quantity) as total_returned'))
            ->pluck('total_returned', 'ref_no');

        $MurghiInvoice = $MurghiInvoice->map(function ($item) use ($returnedQuantities) {
            $item->total_returned = $returnedQuantities->get($item->id, 0);
            return $item;
        });

        if (request()->has('generate_pdf')) {
            $html = view('admin.murghi.invoice_pdf', compact('MurghiInvoice', 'type', 'previous_balance'))->render();
            $mpdf = new Mpdf([
                'format' => 'A4-P',
                'margin_top' => 10,
                'margin_bottom' => 2,
                'margin_left' => 2,
                'margin_right' => 2,
            ]);
            $mpdf->SetAutoPageBreak(true, 15);
            $mpdf->SetHTMLFooter('<div style="text-align: right;">Page {PAGENO} of {nbpg}</div>');
            return generatePDFResponse($html, $mpdf);
        } else {
            return view('admin.murghi.show_murghi', compact('MurghiInvoice', 'type'));
        }
    }
}
