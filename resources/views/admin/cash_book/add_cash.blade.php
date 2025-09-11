
@extends('layouts.admin')
@section('content')
<div class="main-content app-content mt-6">
  <div class="side-app">
    <!-- CONTAINER --> 
    <div class="main-container container-fluid">
        <!-- PAGE-HEADER --> 
        
        <!-- PAGE-HEADER END --> <!-- ROW-1 --> 
        <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4">
            <div class="col">
              <div class="card radius-10 border-start border-0 border-4 border-info">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div>
                      <h1 class="mb-0 text-secondary">Total Credit</h1><br />
                      <h1 class="my-1 text-info">{{ number_format(@$tot_cr,2)}}</h1><br />
                      <p class="mb-0 font-13">+2.5% from last week</p>
                    </div>
                    <div class="widgets-icons-2 rounded-circle bg-gradient-blues text-white ms-auto"><i class='bx bxs-cart'></i>
                    </div>
                  </div>
                </div>
              </div>
				    </div>
				    <div class="col">
              <div class="card radius-10 border-start border-0 border-4 border-danger">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div>
                      <h1 class="mb-0 text-secondary">Total Debit</h1><br />
                      <h1 class="my-1 text-danger">{{ number_format(@$tot_dr,2)}}</h1><br />
                      <p class="mb-0 font-13">+5.4% from last day</p>
                    </div>
                    <div class="widgets-icons-2 rounded-circle bg-gradient-burning text-white ms-auto"><i class='bx bxs-wallet'></i>
                    </div>
                  </div>
                </div>
              </div>
				    </div>
            <div class="col">
              <div class="card radius-10 border-start border-0 border-4 border-success">
                <div class="card-body">
                  <div class="d-flex align-items-center">
                    <div>
                      <h1 class="mb-0 text-secondary">Cash In Hand</h1><br />
                      <h1 class="my-1 text-success">{{ number_format(@$cash_in_hand,2)}}</h1><br />
                      <p class="mb-0 font-13">-4.5% from last day</p>
                    </div>
                    <div class="widgets-icons-2 rounded-circle bg-gradient-ohhappiness text-white ms-auto"><i class='bx bxs-bar-chart-alt-2' ></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
				  
				</div>
        <!-- COL END --> <!-- ROW-3 END --> <!-- ROW-5 --> 
        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-header">
                    <h3 class="card-title mb-0">Add CashBook Detail</h3>
                </div>
                <div class="card-body">
                
                <div class="card-block">
            <div class="item_row">
              <div class="row">
              </div>
              <h1>Cash Book</h1><br />
              <div class="row">
                <div class="col-md-2">
                  <div class="form-group">
                    <label style="font-size:20px;">Cash In Hand </label>
                    <input class="form-control" type="number" name="open_balance" value="{{number_format(@$cash_in_hand,2)}}" readonly>
                  </div>
                </div>

              </div>
              <br />
              <h3>Receipts (آمد)</h3><br />
              <form class="ajaxForm" role="form" action="{{ route('admin.cash.store') }}" method="POST" novalidate>
              @csrf
                <div class="row">
                  <div class="col-md-2">
                    <div class="form-group">
                      <label>Date</label>
                      <input class="form-control" id="rec_date" type="date" required data-validation-required-message="This field is required"  name="date" value="{{ (isset($is_update_receipt)) ? date('Y-m-d', strtotime(@$edit_receipt->entry_date)) : date('Y-m-d') }}" required>
                      
                    </div>
                  </div>
                  <input type="hidden" name="cash_id" value="{{ @$edit_receipt->hashid }}">
                  <input type="hidden" name="status" value="receipt">

                  <div class="col-md-4">
                    <div class="form-group">
                      <label>Account </label>
                      <select class="form-control select2" style="width: 100%;" id="receipt_account"  type="text" name="account_id" >
                        <option value="">Select account </option>
                        @foreach($accounts AS $account)
                          <option value="{{ $account->hashid }}" @if(@$edit_receipt->account_id == $account->id) selected @endif>{{ $account->name }}</option>
                        @endforeach
                        </select>
                    </div>
                  </div>

                  <div class="col-md-2">
                    <div class="form-group">
                      <label>CH # </label>
                      <input class="form-control" name="bil_no" value="{{ @$edit_receipt->bil_no ?? 0 }}" required>
                    </div>
                  </div>
                  <div class="col-md-2">
                    <div class="form-group">
                      <label>Slip # </label>
                      <input class="form-control" name="slip_no" value="{{ @$edit_receipt->slip_no ?? 0 }}" required>
                    </div>
                  </div>

                </div>
                <div class="row">
                  <div class="col-md-8">
                      <div class="form-group">
                        <label style="margin-right:10px;">Narration</label>                     
                          <datalist id="cityname" >
                          @forelse($accounts AS $account)
                            <option style="width:300px;" value="{{ $account->name }}" @if(@$edit_receipt->account_id == $account->id) selected @endif>{{ $account->name }}</option>
                            @empty
                            <option style="width:300px;" value="">No Account Found!</option>
                            
                          @endforelse
                          </datalist>
                          <input  class="form-control" name="narration" value="{{ @$edit_receipt->narration }}" autocomplete="on" style="width:920px;" list="cityname">
                      </div>
                    </div>
                  <div class="col-md-2">
                    <div class="form-group">
                      <label>Amount </label>
                      <input class="form-control" type="number" name="receipt_ammount" value="{{ @$edit_receipt->receipt_ammount }}" >
                    </div>
                  </div>
                  <div class="col-md-1 mt-6">
                    <div class="form-group">
                      <button type="reset" class="btn btn-danger "><i class="fa fa-repeat" aria-hidden="true"></i>&nbsp Reset</button>
                    </div>
                  </div>
                  <input type="hidden" name="cash_id" value="{{ @$edit_receipt->hashid }}">
                  <div class="col-md-1 mt-6">
                    <div class="form-group">
                      <button type="submit" value="{{ (@$is_update_receipt ? 'Update' : 'Add') }}" name="save_receipt" class="btn btn-success">&nbsp Save </button>

                    </div>
                  </div>
                </div>
              </form>
              <br />
              <h3>Payments (جامد)</h3><br />
              <form class="ajaxForm" role="form" action="{{ route('admin.cash.store') }}" method="POST" novalidate>
              @csrf
                <div class="row">
                  <div class="col-md-2">
                    <div class="form-group">
                      <label>Date</label>
                      <input class="form-control" type="date" id="balance_date" name="date" value="{{ (@$is_update_payment) ? date('Y-m-d', strtotime($edit_payment->entry_date)) : date('Y-m-d') }}" required>
                    </div>
                  </div>
                  <input type="hidden" name="cash_id" value="{{ @$edit_payment->hashid }}">
                  <input type="hidden" name="status" value="payment">
                  <div class="col-md-6">
                    <div class="form-group ">
                      <label>Account </label>
                      <select class="form-control select2" id="payment_account" type="text" name="account_id">
                        <option value="">Select account </option>
                        @foreach($accounts AS $account)
                          <option value="{{ $account->hashid }}" @if(@$edit_payment->account_id == $account->id) selected @endif>{{ $account->name }}</option>
                        @endforeach
                        </select>
                    </div>
                  </div>

                  <div class="col-md-2">
                    <div class="form-group">
                      <label>CH # </label>
                      <input class="form-control" name="bil_no" value="{{ @$edit_payment->bil_no ?? 0 }}" required>
                    </div>
                  </div>
                  <div class="col-md-2">
                    <div class="form-group">
                      <label>Slip # </label>
                      <input class="form-control" name="slip_no" value="{{ @$edit_payment->slip_no ?? 0 }}" required>
                    </div>
                  </div>

                </div>
                
                <div class="row">
                  <div class="col-md-8">
                    <div class="form-group">
                      <label style="margin-right:10px;">Narration</label>                     
                        <datalist id="cityname" >
                        @forelse($accounts AS $account)
                          <option style="width:300px;" value="{{ $account->name }}" @if(@$edit_payment->account_id == $account->id) selected @endif>{{ $account->name }}</option>
                          @empty
                          <option style="width:300px;" value="">No Account Found!</option>
                          
                        @endforelse
                        </datalist>
                        <input  class="form-control" name="narration" autocomplete="on" value="{{ @$edit_payment->narration }}" style="width:920px;" list="cityname">
                    </div>
                  </div>
                  <div class="col-md-2">
                    <div class="form-group">
                      <label>Amount </label>
                      <input class="form-control" name="payment_ammount" value="{{ @$edit_payment->payment_ammount }}" required>
                    </div>
                  </div>
                  <div class="col-md-1 mt-6 ">
                    <div class="form-group">
                      <button type="reset" class="btn btn-danger "><i class="fa fa-repeat" aria-hidden="true"></i>&nbsp Reset</button>
                    </div>
                  </div>
                  <input type="hidden" name="cash_id" value="{{ @$edit_payment->hashid }}">
                  <div class="col-md-1 mt-6 ">
                    <div class="form-group">

                      <button type="submit" value="{{ (isset($is_update_payment) ? 'Update' : 'Add') }}" name="save_payment" class="btn btn-success">&nbsp Save </button>
                    </div>

                  </div>
                </div>
              </form>
              <br /><br />
            </div>

          </div>
            </div>
              </div>
          </div>
          <!-- COL END --> 
        </div>
        <!-- ROW-5 END -->
        
        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-header">
                    <h3 class="card-title mb-0"> CashBook Filters</h3>
                </div>
                <div class="card-body">
                <form action="{{ route('admin.cash.index') }}" method="GET">
                  @csrf
                  <div class="row">
                    
                    <div class="col-md-4">
                      <label for="">Accounts</label>
                      <select class="form-control select2" name="parent_id" id="parent_id">
                        <option value="">Select  Account</option>
                        @foreach($accounts AS $account)
                          <option value="{{ $account->hashid }}" >{{ $account->name }}</option>
                        @endforeach
                      </select>
                    </div>
                    <div class="col-md-2">
                      <label for="">Status</label>
                      <select class="form-control select2" name="status" id="status">
                        <option value="">Select status</option>
                        <option value="payment">Payment</option>
                        <option value="receipt">Reciept</option>
                      </select>
                    </div>
                    <div class="col-md-2">
                      <label for="">From</label>
                      <input type="date" class="form-control" name="from_date" id="from_date">
                    </div>
                    <div class="col-md-2">
                      <label for="">To</label>
                      <input type="date" class="form-control" name="to_date" id="to_date">
                    </div>
                    <div class="col-md-2 mt-5">
                      <input type="submit" class="btn btn-primary" value="Search">
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
                <div class="card-header">
                    <h3 class="card-title mb-0">All CashBook Detail</h3>
                </div>
                <div class="card-body">
                  <div class="table-responsive">
                    <div id="data-table_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
                      <div class="row">
                          <div class="col-sm-12">
                            <table id="example54" class="table table-bordered text-nowrap mb-0 dataTable no-footer" role="grid" aria-describedby="data-table_info">

                              <thead>
                                <tr class="text-dark">
                                  <th style="width: 5%;">S.No</th>
                                  <th style="width: 10%;">Date</th>
                                  <th style="width: 10%;">CH # / Slip #</th>
                                  
                                  <th  style="width: 15%;"> Account Name </th>
                                  <th  style="width: 20%;">Narration</th>
                                  <th  style="width: 10%;"> Payment </th>
                                  <th  style="width: 10%;"> Receipt </th>
                                  <th  style="width: 20%;">Action</th>
                                  </tr>
                              </thead>
                              <tbody>
                                <?php $total_receipt = 0; $total_payment = 0; ?>
                                @foreach($cash AS $c)
                                  <tr class="text-dark">
                                      <td width="5%">{{ $loop->iteration }}</td>
                                      <td width="10%">{{ date('d-M-Y', strtotime($c->entry_date)) }}</td>
                                      <td width="10%">{{ $c->bil_no }}/{{ $c->slip_no }}</td>
                                     
                                      <td width="15%"><span class="waves-effect waves-light btn btn-primary-light">{{ @$c->account->name }}</span></td>
                                      <td width="20%">{{ $c->narration }}</td>
                                      <?php $total_receipt += $c->receipt_ammount; $total_payment +=$c->payment_ammount; ?>
                                      <td width="10%">{{ $c->payment_ammount }}</td>
                                      <td width="10%">{{ $c->receipt_ammount }}</td>
                                      
                                    <td width="20%">
                                        <div class="btn-group" role="group">
                                            <a class="btn btn-outline-info rounded-pill btn-wave mr-2"
                                                href="{{ route('admin.cash.edit', ['id' => $c->id]) }}"
                                                title="Edit">
                                                <i class="ri-edit-line"></i>
                                            </a>
                                            <button type="button" onclick="ajaxRequest(this)" data-url="{{ route('admin.cash.delete', ['id' => $c->id]) }}">
                                                <a class="btn btn-outline-info rounded-pill btn-wave" target="_blank"
                                                    title="Download">
                                                    <i class="ri-delete-bin-line "></i>
                                                </a>    
                                            </button>
                                
                                        </div>
                                    </td>
                                  </tr>
                                @endforeach
                              </tbody>
                              <tfoot>
                              <tr class="text-dark">
                                    <td colspan="6">Total:</td>
                                    <td><strong><?= @$total_payment ?></strong></td>
                                    <td><strong><?= @$total_receipt ?></strong></td>
                                    
                                  </tr>
                              </tfoot>

                            </table>
                          </div>
                      </div>
                    </div>
                  </div>
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
$('.ajaxForm').submit(function(e){
  e.preventDefault();
  const btn = $(this).find('[type="submit"]').prop('disabled', true).text('Saving...');
  $.post('{{ route("admin.cash.store") }}', $(this).serialize())
    .done(resp => {
      alert(resp.success);
      if (resp.pdf_url) window.open(resp.pdf_url, '_blank');
      window.location = resp.redirect;
    })
    .fail(xhr => {
      alert(xhr.responseJSON?.message || 'Error occurred.');
    })
    .always(() => btn.prop('disabled', false).text('Save'));
});
</script>

<script>
 $('#payment_account').change(function () {
    let accountId = $(this).val();
    let selectedDate = $('#balance_date').val();

    if (!accountId || !selectedDate) {
        Swal.fire('Error', 'Please select both account and date.', 'warning');
        return;
    }

    let url = '{{ route("admin.accounts.getBalance", [":id", ":date"]) }}'
                .replace(':id', accountId)
                .replace(':date', selectedDate);

    $.ajax({
        url: url,
        type: 'GET',
        success: function (resp) {
            Swal.fire(
                'Account Balance',
                `${resp.balance} (${resp.account_nature})`,
                'info'
            );
        },
        error: function () {
            Swal.fire('Error', 'Failed to fetch balance.', 'error');
        }
    });
});
 
 $('#receipt_account').change(function () {
    let accountId = $(this).val();
    let selectedDate = $('#rec_date').val();

    if (!accountId || !selectedDate) {
        Swal.fire('Error', 'Please select both account and date.', 'warning');
        return;
    }

    let url = '{{ route("admin.accounts.getBalance", [":id", ":date"]) }}'
                .replace(':id', accountId)
                .replace(':date', selectedDate);

    $.ajax({
        url: url,
        type: 'GET',
        success: function (resp) {
            Swal.fire(
                'Account Balance',
                `${resp.balance} `,
                'info'
            );
        },
        error: function () {
            Swal.fire('Error', 'Failed to fetch balance.', 'error');
        }
    });
});
   
 
</script>
@endsection