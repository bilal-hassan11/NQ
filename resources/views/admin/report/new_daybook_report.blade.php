@extends('layouts.admin')
@section('content')

<div class="main-content app-content mt-5">
  <div class="side-app">
    <!-- CONTAINER --> 
    <div class="main-container container-fluid">
        <!-- PAGE-HEADER --> 
        
       
       
        
        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-header">
                    <h3 class="card-title mb-0"> DayBook Filters</h3>
                </div>
                <div class="card-body">
                <form action="{{ route('admin.reports.newdaybook_report') }}" method="GET">
                              @csrf
                          <div class="row">
                            
                            <div class="col-md-8">
                              <input type="date" class="form-control" name="from_date" value="{{ (isset($is_update)) ? date('d-m-Y', strtotime($from_date)) : date('d-m-Y') }}" id="from_date">
                            </div>
                            
                            <div class="col-md-2">
                              <input type="submit" class="btn btn-primary" value="Search">
                               <button class="btn btn-danger" id="pdf">PDF</button>
                            </div>
                            
                          </div>
                        </form>
                
            </div>
              </div>
          </div>
          <!-- COL END --> 
        </div>
        <div class="row">
            <div class="col-12 col-sm-12">
                <div class="card ">
                  
                    <div class="card-body">
                        <center><h1 class="page-title text-primary">DayBook Report</h1><br /></center>
                    
                    </div>
                </div>
            </div>
          
        </div>
      
        <!-- Murghi -->
        <div class="row">
            <div class="col-12 col-sm-12">
                <div class="card ">
                  
                    <div class="card-body">
                        <center><h1 class="page-title text-primary">Murghi Report</h1><br /></center>
                    
                    </div>
                </div>
            </div>
          
        </div>
        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-header">
                    <h3 class="card-title mb-0">All Purchase Murghi Detail</h3>
                </div>
                <div class="card-body">
                <table id="example" class="text-fade table table-bordered" style="width:100%">
                        <thead>
                            <tr class="text-dark">
                                <th>ID</th>
                                <th>Account Name</th>
                                <th>Description</th>
                                <th>Purchase Ammount</th>
                                <th>Sale Ammount</th>
                                <th>Return Ammount</th>
                            </tr>
                        </thead>
                        <tbody>
                    
                            <?php @$tot_pmg_val = 0;  ?>
                            @foreach($purchase_murghi AS $pmg)
                                <tr class="text-dark">
                                    <th>{{ @$pmg->id }}</th>
                                    <td> {{ @$pmg->account->name }}</td>
                                    <td> <span class="waves-effect waves-light btn btn-danger-light"> Item Name : {{ @$pmg->item->name }} , Rate : {{ @$pmg->purchase_price }} , Quantity : {{ @$pmg->final_weight }} </span> </td>
                                    <?php @$tot_pmg_val += @$pmg->net_ammount;  ?>
                                    <td> {{ @$pmg->net_ammount }}</td>
                                    <td>0</td>
                                    <td> 0</td>
                                </tr>
                            @endforeach
                        </tbody>
                        <tr class="text-dark">
                            <th colspan="3">Total :</th>
                            <th>{{ @$tot_pmg_val }}</th>
                            <th> 0 </th>
                            <th> 0 </th>
                        </tr>
                </table>
                
            </div>
              </div>
          </div>
          <!-- COL END --> 
        </div>
        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-header">
                    <h3 class="card-title mb-0">All Sale Murghi Detail</h3>
                </div>
                <div class="card-body">
                <table id="example" class="text-fade table table-bordered" style="width:100%">
                <thead>
                        <tr class="text-dark">
                            <th>ID</th>
                            <th>Account Name</th>
                            <th>Description</th>
                            <th>Purchase Ammount</th>
                            <th>Sale Ammount</th>
                            <th>Return Ammount</th>
                        </tr>
                    </thead>
                    <tbody>
                
                        <?php  @$tot_sm_val = 0;  ?>
                        @foreach($sale_murghi AS $sm)
                            <tr class="text-dark">
                                <th>{{ @$sm->id }}</th>
                                <td> {{ @$sm->account->name }}</td>
                                <td> <span class="waves-effect waves-light btn btn-danger-light"> Item Name : {{ @$sm->item->name }} , Rate : {{ @$sm->rate }} , Quantity : {{ @$sm->net_weight }} </span> </td>
                                <td> 0</td>
                                <?php  @$tot_sm_val += @$sm->net_ammount;  ?>
                                <td> {{ @$sm->net_ammount }}</td>
                                <td>0</td>
                                
                            </tr>
                        @endforeach
                    </tbody>
                    <tr class="text-dark">
                        <th colspan="3">Total :</th>
                        <th>0</th>
                        <th> {{@$tot_sm_val }} </th>
                        <th>0</th>
                    </tr>
                </table>
                
            </div>
              </div>
          </div>
          <!-- COL END --> 
        </div>
        <div class="row">
            <div class="col-12 col-sm-12">
                <div class="card ">
                  
                    <div class="card-body">
                        <center><h1 class="page-title text-primary">CashBook Report</h1><br /></center>
                    
                    </div>
                </div>
            </div>
          
        </div>
        <div class="row">
            <div class="col-12 col-sm-12">
                <div class="card ">
                  
                    <div class="card-body">
                    <h4 style="color:red; float:right;">Opening Cash In Hand : {{number_format(@$account_opening)}}</h4>
                    
                    </div>
                </div>
            </div>
          
        </div>
        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-header">
                    <h3 class="card-title mb-0">All CashBook Detail</h3>
                </div>
                <div class="card-body">
                <table id="example" class="text-fade table table-bordered" style="width:100%">
                <thead>
                        <tr class="text-dark">
                            <th>Date</th>
                            <th>Account Name</th>
                            <th colspan="1"> Narration </th>
                            <th> Cr </th>
                            <th> Dr </th>
                            <th> Balance </th>
                            <th> cr/dr </th>
                        </tr>
                    </thead>
                    <tbody>
                
                         @if(@$cashbook != "")                          
                                @php
                                    $tot_balance = 0; $tot_payment=0;
                                    $tot_receipt=0; $tot_bal = 0;
                                @endphp
                                <tr class="text-dark">
                                    <td> {{ date('d-M-Y', strtotime(@$date)) }}</td>
                                    <td > Opening Balance </td>
                                    
                                    
                                        <?php @$tot_balance += @$account_opening; ?>
                                        <?php @$tot_payment += @$account_opening ;?>
                                        
                                        
                                        <td>-</td>
                                        <td><span class="waves-effect waves-light btn btn-primary-light">0</span></td>
                                        <td><span class="waves-effect waves-light btn btn-success-light">{{ @$account_opening }}</span></td>
                                        <td><span class="waves-effect waves-light btn btn-primary-light">{{ @$tot_balance }}</span></td>
                                    
                                        <td><span class="waves-effect waves-light btn btn-primary-light">dr</span></td>
                                        
                                    
                                    <td></td>
                                </tr>
                                <?php $tot_balance = $tot_balance ; ?>
                                @foreach($cashbook AS $c)
                                    
                                    <tr class="text-dark">
                                        <td> {{ date('d-M-Y', strtotime(@$c->date)) }}</td>
                                       <td ><span class="waves-effect waves-light btn btn-success-light">{{ @$c->account->name }}</span></td>
                                        
                                        <td >{{ @$c->narration }}</td>
                                        <?php @$tot_payment += @$c->payment_ammount ;?>
                                        <td><span class="waves-effect waves-light btn btn-danger-light">{{ number_format(@$c->payment_ammount) }}</span></td>
                                        <?php $tot_receipt += $c->receipt_ammount;?>
                                        <td><span class="waves-effect waves-light btn btn-success-light">{{  number_format(@$c->receipt_ammount) }}</span></td>
                                        
                                        <?php @$tot_balance += @$c->receipt_ammount - @$c->payment_ammount ;?>
                                        <td><span class="waves-effect waves-light btn btn-primary-light">{{ number_format(@$tot_balance) }}</span></td>
                                        
                                        @if($tot_balance > 0)
                                        <td><span class="waves-effect waves-light btn btn-primary-light">dr</span></td>
                                        <?php @$tot_bal += @$tot_balance; ?>
                                        @endif
                                        @if( @$tot_balance <= 0)
                                        <td><span class="waves-effect waves-light btn btn-info-light">cr</span></td>
                                            <?php @$tot_bal += @$tot_balance; ?>
                                        @endif
                                        
                                        <td></td>
                                    </tr>
                                @endforeach
                                <tr class="text-dark">
                                    <th>{{ date('d-M-Y', strtotime(@$date)) }}</th>
                                    <th colspan="1"> Expense </th>
                                    <th><span class="waves-effect waves-light btn btn-primary-light">{{ @$day_exp }}</span>  </th>
                                    <th><span class="waves-effect waves-light btn btn-primary-light"> 0</span> </th>
                                    <th> <span class="waves-effect waves-light btn btn-primary-light">{{ @$tot_balance - @$day_exp }} </span> </th>
                                    <th> <span class="waves-effect waves-light btn btn-primary-light">dr</span> </th>
                                    
                                </tr>
                            @endif
                    </tbody>
                    <tfoot>
                        <tr class="text-dark">
                        <td>Total:</td>
                        <td colspan="1">-</td>
                        <td >-</td>
                        
                        <td><span class="waves-effect waves-light btn btn-danger-light">{{ number_format(@$debit) }}</span></td>
                        <td><span class="waves-effect waves-light btn btn-success-light">{{  number_format(@$credit) }}</span></td>
                        <?php @$account_opening + @$debit  ?>
                        
                        <td><span class="waves-effect waves-light btn btn-primary-light">{{  number_format(@$tot_balance - @$day_exp) }} Closing Balance</span></td>
                        
                        @if(@$tot_balance > 0)
                        <td><span class="waves-effect waves-light btn btn-primary-light">dr</span></td>
                        <?php @$tot_bal += @$tot_balance; ?>
                        @endif
                        @if( @$tot_balance <= 0)
                        <td><span class="waves-effect waves-light btn btn-info-light">cr</span></td>
                            <?php @$tot_bal += @$tot_balance; ?>
                        @endif
                        
                        <td></td>
                    </tr>
                    </tfoot>
                </table>
                
            </div>
              </div>
          </div>
          <!-- COL END --> 
        </div>
        <div class="row">
            <div class="col-12 col-sm-12">
                <div class="card ">
                  
                    <div class="card-body">
                    <h4 style="color:blue; float:right;">Closing Cash In Hand : {{number_format(@$tot_balance - @$day_exp)}}</h4>
                    
                    </div>
                </div>
            </div>
          
        </div>
    </div>
    <!-- CONTAINER END --> 
  </div>
</div>



@endsection

@section('page-scripts')
<script>
  $('#example54').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example46').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example40').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example45').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example44').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example53').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example52').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example51').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example50').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example49').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example48').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
    $('#example47').DataTable( {
    "aaSorting": [[ 0, "desc" ]],
		dom: 'Bfrtip',
        buttons: [
            { extend: 'copyHtml5', footer: true },
            { extend: 'excelHtml5', footer: true },
            { extend: 'csvHtml5', footer: true },
            { extend: 'pdfHtml5', footer: true }
        ]
	} );
</script>
<script>
    $('#pdf').click(function(event){
        event.preventDefault();
        var form_data = $('form').serialize();
        // console.log(form_data);
        $.ajax({
            type: 'GET',
            url: "{{ route('admin.reports.newDayBookPdf') }}",
            data: form_data,
            xhrFields: {
                responseType: 'blob'
            },
            success: function(response){
                var blob = new Blob([response]);
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = "DayBook-Report.pdf";
                link.click();
                return false;
            },
            error: function(blob){
                console.log(blob);
            }
        });
    });
</script>

@endsection