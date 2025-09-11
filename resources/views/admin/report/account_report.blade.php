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
                    <h3 class="card-title mb-0">{{@$title}} Filters</h3>
                </div>
                <div class="card-body">
                    <form action="" id="form">
                        <div class="row">
                            <div class="col-md-3">  
                                <label class="text-dark">Account</label>  
                                <select class="form-control select2" name="parent_id" id="accountFilter">  
                                    <option value="">Select Account</option>  
                                    @foreach($accounts as $account)
                                        @if($account->status == 0)
                                            <option value="{{ $account->id }}">{{ $account->name }}</option>
                                        @endif
                                        @if($account->status == 1)
                                            <option value="{{ $account->id }}" ><span style="background-color: green;">{{ $account->name }}</span></option>
                                        @endif
                                          
                                    @endforeach  
                                </select>  
                            </div>
                            <div class="col-md-3">
                                <label class="text-dark">Type</label>
                                <select class="form-control select2" name="type" id="typeFilter">
                                    <option value="" >Select Account </option>
                                    <option value="medicine_invoice_id" >Medicine</option>
                                    <option value="murghi_invoice_id" >Murghi</option>
                                    <option value="feed_invoice_id" >Feed </option>
                                    <option value="chick_invoice_id" >Chick </option>
                                    <option value="cash_id" >Cash</option>
                                    <option value="payment_id" >Payment</option>
                                    <option value="other_invoice_id" >Other</option>
                                    <option value="expense_id" >Expense </option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="">From Date</label>
                                <input type="date" class="form-control" value="{{ (isset($from_date)) ? date('Y-m-d', strtotime($from_date)) : date('2023-11-13') }}" name="from_date" id="from_date">
                            </div>
                            <div class="col-md-2">
                                <label for="">To Date</label>
                                <input type="date" class="form-control" value="{{ (isset($to_date)) ? date('Y-m-d', strtotime($to_date)) : date('Y-m-d') }}" name="to_date" id="to_date">
                            </div>
                            <div class="col-md-2 mt-3">
                            <input type="submit" class="btn btn-primary float-right mt-4">

                            </div>

                        </div>

                    </form>
                    <div class="row">
                        <div class="col-md-12 mt-3">
                            <form action="{{ route('admin.reports.account_pdf') }}" method="GET" target="_blank">
                                @csrf
                                <input type="hidden" name="account_id" id="accountInput">
                                <input type="hidden" name="type" id="typeInput">
                                
                                <input type="hidden" name="from_date" id="fromdateInput">
                                <input type="hidden" name="to_date" id="todateInput">
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
        @if(isset($from_date))
        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-body">
                    <center>
                        <h2 style="color:green;  justify_content:center;"><span> <i class="glyphicon glyphicon-user"></i> </span>{{@$party_name[0]['name']}}</h2>
                        <h4>From {{date('d-M-Y', strtotime($from_date))}} to {{date('d-M-Y', strtotime($to_date))}}</h4>
                    </center>

            </div>
              </div>
          </div>
          <!-- COL END -->
        </div>
        @endif
        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-header">
                    <h3 class="card-title mb-0">All {{@$title}} </h3>
                </div>
                <div class="card-body">
                
                        <table id="example" class="text-fade table table-bordered" style="width:100%">
                    <thead>
                        <tr class="text-dark">
                            <th>Date</th>
                            <th>Type</th>
                            <th colspan="1"> Description </th>
                            <th> Dr </th>
                            <th> Cr </th>
                            <th> Balance </th>
                            <th> cr/dr </th>

                        </tr>
                    </thead>
                    <tbody>
                        @if(@$account_ledger != "")

                            @if(@$account_nature == "debit")
                                @php
                                    $tot_balance = 0; $tot_deb=0;
                                    $tot_credit=0; $tot_bal = 0;
                                @endphp
                                <tr class="text-dark">
                                    <td> {{ date('d-M-Y', strtotime($from_date)) }}</td>
                                    <td>-</td>
                                    <td > Opening Balance </td>

                                        <?php $tot_balance += @$opening_balance ?>

                                        <td><span class="waves-effect waves-light btn btn-success-light">{{ number_format(@$opening_balance , 2) }}</span></td>
                                        <td><span class="waves-effect waves-light btn btn-primary-light">0</span></td>

                                        <td><span class="waves-effect waves-light btn btn-primary-light">{{ number_format(@$opening_balance , 2) }}</span></td>

                                        <td><span class="waves-effect waves-light btn btn-primary-light">dr</span></td>
                                        <?php @$tot_bal += @$tot_balance; ?>



                                </tr>
                                <?php $tot_balance = @$opening_balance ; ?>
                                @foreach($account_ledger AS $ac)
                                    <?php @$tot_deb += $ac->debit; $tot_credit += $ac->credit;  ?>
                                    <tr class="text-dark">
                                        <td> {{ date('d-M-Y', strtotime($ac->date)) }}</td>
                                        <td> <span class="waves-effect waves-light btn btn-warning-light">{{ @$ac->type }}</span></td>

                                        <td >{{ @$ac->description }}</td>
                                        <td><span class="waves-effect waves-light btn btn-danger-light">{{ number_format(@$ac->debit) }}</span></td>
                                        <td><span class="waves-effect waves-light btn btn-success-light">{{  number_format(@$ac->credit) }}</span></td>

                                        <?php $tot_balance += $ac->debit - $ac->credit ;?>
                                        <td><span class="waves-effect waves-light btn btn-primary-light">{{ number_format(abs($tot_balance)) }}</span></td>

                                        @if($tot_balance > 0)
                                        <td><span class="waves-effect waves-light btn btn-primary-light">dr</span></td>
                                        <?php @$tot_bal += @$tot_balance; ?>
                                        @endif
                                        @if( @$tot_balance <= 0)
                                        <td><span class="waves-effect waves-light btn btn-info-light">cr</span></td>
                                            <?php @$tot_bal += @$tot_balance; ?>
                                        @endif


                                    </tr>
                                @endforeach
                            @endif
                            @if(@$account_nature == "credit")
                                @php
                                    $tot_balance = 0; $tot_deb=0;
                                    $tot_credit=0; $tot_bal = 0;
                                @endphp
                                <tr class="text-dark">
                                    <td> {{ date('d-M-Y', strtotime($from_date)) }}</td>
                                    <td> - </td>
                                    <td > Opening Balance </td>
                                    <?php $tot_balance -= @$opening_balance;?>
                                    <td><span class="waves-effect waves-light btn btn-primary-light">0</span></td>
                                    <td><span class="waves-effect waves-light btn btn-danger-light"> {{ @$opening_balance }}</span></td>
                                    <td><span class="waves-effect waves-light btn btn-info-light">cr</span></td>
                                    <?php @$tot_bal += @$tot_balance; ?>


                                </tr>

                                <?php $tot_balance = @$opening_balance ; ?>

                                @foreach($account_ledger AS $ac)
                                <?php @$tot_deb += $ac->debit; $tot_credit += $ac->credit;  ?>
                                    <tr class="text-dark">
                                        <td> {{ date('d-M-Y', strtotime($ac->date)) }}</td>
                                        <td> <span class="waves-effect waves-light btn btn-warning-light">{{ @$ac->type }}</span></td>

                                        <td >{{ @$ac->description }}</td>
                                        <td><span class="waves-effect waves-light btn btn-danger-light">{{ number_format(@$ac->debit) }}</span></td>
                                        <td><span class="waves-effect waves-light btn btn-success-light">{{  number_format(@$ac->credit) }}</span></td>

                                        <?php $tot_balance += $ac->credit - $ac->debit ;?>
                                        <td><span class="waves-effect waves-light btn btn-primary-light">{{ number_format(abs($tot_balance)) }}</span></td>

                                        @if($tot_balance > 0)
                                        <td><span class="waves-effect waves-light btn btn-info-light">cr</span></td>
                                        <?php @$tot_bal += @$tot_balance; ?>
                                        @endif
                                        @if( @$tot_balance <= 0)
                                        <td><span class="waves-effect waves-light btn btn-primary-light">dr</span></td>
                                            <?php @$tot_bal += @$tot_balance; ?>
                                        @endif


                                    </tr>
                                @endforeach
                            @endif

                        @endif
                    </tbody>
                    <tfoot>
                        <td colspan="3"></td>
                        @if(@$account_nature == "debit")
                            <td ><span class="waves-effect waves-light btn btn-warning-light">{{ number_format(@$tot_deb + $opening_balance ) }}</span></td>
                            <td><span class="waves-effect waves-light btn btn-warning-light">{{ number_format(@$tot_credit) }}</span></td>
                            <td><span class="waves-effect waves-light btn btn-warning-light">{{ number_format(abs(  @$tot_balance)) }}</span></td>

                        @endif

                        @if(@$account_nature == "credit")
                            <td ><span class="waves-effect waves-light btn btn-warning-light">{{ number_format(@$tot_deb  ) }}</span></td>
                            <td><span class="waves-effect waves-light btn btn-warning-light">{{ number_format(@$tot_credit + $opening_balance) }}</span></td>
                            <td><span class="waves-effect waves-light btn btn-warning-light">{{ number_format(abs(@$tot_balance)) }}</span></td>

                        @endif
                        <td>-</td>
                    </tfoot>
                </table>
            </div>
              </div>
          </div>
          <!-- COL END -->
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
            url: "{{ route('admin.reports.all_reports_pdf') }}",
            data: function(d) {
                    d.account_id = $('#accountInput').val();
                    d.type = $('#typeInput').val();
                    d.from_date = $('#fromdateInput').val();
                    d.to_date = $('#todateInput').val();
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

        var to_date = $('#to_date').val();
            $('#todateInput').val(to_date);

        $('#accountFilter').change(function() {
            var accountId = $(this).val();

            $('#accountInput').val(accountId);

        });

        $('#typeFilter').change(function() {
            var type = $(this).val();
            $('#typeInput').val(type);

        });

        $('#from_date').change(function() {
            var fromdate = $(this).val();
            $('#fromdateInput').val(fromdate);

        });

        $('#to_date').change(function() {
            var to_date = $(this).val();
            $('#todateInput').val(to_date);

        });





    });
</script>
{{-- <script>
    $('#pdf').click(function(event){
        event.preventDefault();
        var form_data = $('form').serialize();

        let from_date =  document.getElementById("from_date");
        let  get_from_date = new Date(from_date.value);
        let to_date =  document.getElementById("to_date");
        let  get_to_date = new Date(to_date.value);

        // Calculate the difference in milliseconds
        var differenceInMs = get_to_date - get_from_date;
        var differenceInDays = differenceInMs / (1000 * 60 * 60 * 24);

        var selectBox = document.getElementById("parent_id");
        var selectedOption = selectBox.options[selectBox.selectedIndex];
        var optionText = selectedOption.innerText;


        $.ajax({
            type: 'GET',
            url: "{{ route('admin.reports.account_pdf')}}",
            data: form_data,
            xhrFields: {
                responseType: 'blob'
            },
            success: function(response){
                var blob = new Blob([response]);
                var link = document.createElement('a');
                var fileName =  optionText +" "+ differenceInDays +" "+"Days.pdf";
                link.href = window.URL.createObjectURL(blob);
                link.download = fileName;
                link.click();
                return false;
            },
            error: function(blob){
                console.log(blob);
            }
        });
    });
</script> --}}

@endsection
