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
                            <div class="col-md-4">
                                <label class="text-dark">Shades</label>
                                <select class="form-control select2" name="Shade_id" id="Shade_id">
                                    <option value="" >Select Shade </option>
                                @foreach($shades AS $shade)
                                    <option value="{{ $shade->hashid }}" >{{ $shade->name }}</option>
                                @endforeach
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="">From Date</label>
                                <input type="date" class="form-control" name="from_date" id="from_date">
                            </div>
                            <div class="col-md-2">
                                <label for="">To Date</label>
                                <input type="date" class="form-control" name="to_date" id="to_date">
                            </div>
                            <div class="col-md-2 mt-3">
                            <input type="submit" class="btn btn-primary float-right mt-4">
                            <button class="btn btn-danger mt-4" id="pdf">PDF</button>
                            </div>

                        </div>
                        
                    </form>
                
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
                            <th>S.NO</th>
                            <th>Date</th>
                            <th colspan="1"> Description </th>
                            <th> Quantity </th>
                            <th> Remaining Available  </th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $tot_remaining = 0;?>
                        <tr class="text-dark">
                            <td>S.NO</td>
                            <td>Date</td>
                            <td colspan="1"> Description </td>
                            <td> Quantity </td>
                            <td> Remaining Available  </td>
                        </tr>
                          
                    </tbody>
                    <tfoot>
                        <td colspan="3"></td>
                        <td ><span class="waves-effect waves-light btn btn-warning-light">{{ number_format(@$tot_remaining  ) }}</span></td>
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

        var selectBox = document.getElementById("Shade_id");
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
</script>

@endsection