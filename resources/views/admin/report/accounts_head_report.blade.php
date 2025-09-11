@extends('layouts.admin')
@section('content')
<style>
@page { size: auto;  margin: 0mm; }

</style>
<div class="main-content app-content mt-5">
  <div class="side-app">
    <!-- CONTAINER --> 
    <div class="main-container container-fluid">
        <!-- PAGE-HEADER --> 
        
        <!-- ROW-5 END -->
        
        <div class="row">
            <div class="col-12 col-sm-12">
                <div class="card ">
                    <div class="card-header">
                        <h3 class="card-title mb-0"> All Accounts Head Filters</h3>
                    </div>
                    <div class="card-body">
                        <form action="" id="form">
                            <div class="row">
                                <div class="col-md-4 mt-2">
                                    <label for="">Select Head</label>
                                    <select class="form-control select2" name="parent_id[]" id="accountFilter" multiple>
                                        <option value="" >Select Account </option>
                                    @foreach($account_types AS $account)
                                        <option value="{{ $account->id }}" >{{ $account->name }}</option>
                                    @endforeach
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="">From Date</label>
                                    <input type="date" class="form-control"  value="{{ (@$from_date) ? date('Y-m-d', strtotime($from_date)) : date('Y-m-d') }}" name="from_date" id="from_date">
                                </div>
                                
                                <div class="col-md-2 mt-3">
                                <input type="submit" class="btn btn-primary float-right mt-4">
                                
                            </div>
                            
                        </form>
                        <div class="row">
                        <div class="col-md-12 mt-3">
                            <form action="{{ route('admin.reports.account_head_report_pdf') }}" method="GET" target="_blank">
                                @csrf
                                <input type="hidden" name="parent_id[]" id="accountInput">
                                <input type="hidden" name="from_date" id="fromdateInput">
                                <input type="hidden" name="id" id="idInput">

                                <input type="hidden" name="generate_pdf" value="1">
                                <button type="submit" class="btn btn-danger">
                                    <i class="ri-download-2-line"></i> Download PDF
                                </button>
                            </form>
                        </div>
                    </div>
                    </div>
               </div>
            </div>
          <!-- COL END --> 
        </div>
        
        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-header">
                    <h3 class="card-title mb-0">All Accounts Heads Reports</h3>
                </div>
                <div class="card-body">
                <table id="example54" class="text-fade table table-bordered" style="width:100%">
                    <thead>
                        <tr class="text-dark">
                            <th>Account Name</th>
                            <th>Phone No</th>
                            <th>Receivable Balance </th>
                            <th> Payable Balance </th>
                            
                            
                        </tr>
                    </thead>
                    <tbody>
                    
                    <?php @$tot_rec = 0; $tot_pay = 0;  ?>
                        @foreach($ac AS $a)

                            
                                <tr class="text-dark">
                                    <td><span class="waves-effect waves-light btn btn-primary-light"> {{ $a->name }}</span></td>
                                    <td><span class="waves-effect waves-light btn btn-primary-light"> {{ $a->phone_no }}</span></td>
                                    
                                    @if(@$a->opening_balance < 0)
                                    <td ><span class="waves-effect waves-light btn btn-info-light">{{ number_format(abs(@$a->opening_balance) ,2) }}</span></td>
                                    <?php @$tot_rec += abs(@$a->opening_balance) ; ?>
                                        <td><span class="waves-effect waves-light btn btn-danger-light">0</span></td>
                                    @endif
                                    @if(@$a->opening_balance >= 0)
                                        <td ><span class="waves-effect waves-light btn btn-info-light">0</span></td>
                                        <td><span class="waves-effect waves-light btn btn-danger-light">{{ number_format(abs(@$a->opening_balance) ,2) }}</span></td>
                                        <?php @$tot_pay += abs(@$a->opening_balance) ;  @$tot_rec += 0 ;?>
                                    @endif
                                    
                                </tr>
                                
                        @endforeach
                    </tbody>
                    
                    <tfoot>
                        <tr class="text-dark">
                            <th>Total :</th>
                            <th>-</th>
                            
                            <th><span class="waves-effect waves-light btn btn-success-light">{{ number_format(abs(@$tot_rec) ,2) }}</span></th>
                            <th><span class="waves-effect waves-light btn btn-warning-light">{{ number_format(abs(@$tot_pay) ,2)}}</span></th>
                        </tr>
                    </tfoot>
                </table>
                
            </div>
              </div>
          </div>
          <!-- COL END --> 
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box ">
                                    <center>
                                    <h2 style="color:green;  justify_content:center;"><span> <i class="glyphicon glyphicon-user"></i> </span>{{ @$tot_rec > @$tot_pay ? "Receivable Ammount" : "Payble Ammount" }}</h2>
                                <h4>{{abs(@$tot_rec - @$tot_pay) }}</h4>
                                
                                    </center>
                                
                                
                                </div>
                            </div>
                        </div>
                        
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
@include('admin.partials.datatable')
<script>
    $(document).ready(function() {
        $('.select2').select2();

        $.ajax({
            type: 'GET',
            url: "{{ route('admin.reports.account_head_report_pdf') }}",
            data: function(d) {
                    d.account_id = $('#accountInput').val();
                    d.from_date = $('#fromdateInput').val();
                    d.id = $('#idInput').val();

                },
            success: function(response){

                console.log(response);
            },
            error: function(blob){
                console.log(blob);
            }
        });

        var id = $('#report_id').val();
            $('#idInput').val(id);

        var fromdate = $('#from_date').val();
            $('#fromdateInput').val(fromdate);

        
        $('#accountFilter').change(function() {
            var accountId = $(this).val();
            $('#accountInput').val(accountId);

        });

        
        $('#from_date').change(function() {
            var fromdate = $(this).val();
            $('#fromdateInput').val(fromdate);

        });

        

    });
</script>
<script>
    $('#pdf').click(function(event){
        event.preventDefault();
        var form_data = $('form').serialize();
        // console.log(form_data);
        $.ajax({
            type: 'GET',
            url: "{{ route('admin.reports.account_pdf') }}",
            data: form_data,
            xhrFields: {
                responseType: 'blob'
            },
            success: function(response){
                var blob = new Blob([response]);
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = "account_report.pdf";
                link.click();
                return false;
            },
            error: function(blob){
                console.log(blob);
            }
        });
    });
</script>
<script>
$('#grand_parent_id').change(function(){
    var id    = $(this).val();
    var route = "{{ route('admin.cash.get_parent_accounts', ':id') }}";
    route     = route.replace(':id', id);

   if(id != ''){
      getAjaxRequests(route, "", "GET", function(resp){
        $('#parent_id').html(resp.html);
      });
    }
  })

</script>
@endsection