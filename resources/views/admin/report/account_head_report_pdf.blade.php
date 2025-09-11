<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $data['account_detail'][0]->name ?? 'All Accounts Report' }} | Accounts Report</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 0;
            font-size: 12px;
        }

        .company-info {
            text-align: center;
            padding: 0;
        }

        .table-container {
            margin-top: 10px;
        }

        .company-info h1 {
            margin: 0;
        }

        h1,
        h2,
        h5 {
            margin: 0;
        }
        
        .header {
            text-align: center;
        }

        
        table {
            width: 100%;
            border-collapse: collapse;
            border: none;
            margin-top: 10px;
        }

        th,
        td {
            padding: 8px;
            text-align: left;
            border: 1px solid #ddd;
            background-color: white;
        }

        .text-center {
            text-align: center;
        }

        .text-right {
            text-align: right;
        }

        .container {
            width: 100%;
            padding: 0 15px;
            margin-right: auto;
            margin-left: auto;
        }

        .terms-conditions {
            margin-top: 20px;
        }

        .sign {
            margin-top: 20px;
            text-align: right;
        }

        .account_name{
            color: green;
            margin-top: 20px;
        }
        
        .party_name{
            color:green;
            
        }
        .date{
            color:blue;
            
        }
        
    </style>
</head>

<body>
    <div class="container">
        
        <div class="company-info">
            <table style="border: none;">
                <tr style="border: none;">
                    <td style="border: none;"><span><img src="{{ asset('new_assets') }}/images/main-logo-mgh.jpeg" alt="" width="150"></span></td>
                    <td style="border: none; margin-top:10px !important;">
                        
                        <h1 class="text-center"><u>Al Madina Chicken Center (Shareef Naqi) | Accounts Report</u></h1>
                           
                    </td>
                    
                    
                </tr>
                
            </table>
         </div>
         <div class="header">
            <h2 class="party_name">All {{ $data['account_detail'][0]->name ?? ''  }} Accounts Report</h2>
            <h3 class="date">Date : {{$data['from_date']}} </h3>
        </div>
         
        <div class="table-container">


            <table >
                <thead>
                    <tr>
                        <th>S.No</th>
                        <th>Account Name</th>
                        <th>Phone No</th>
                        
                        <th>Receivable Balance </th>
                        <th> Payable Balance </th>
                        
                    </tr>
                </thead>
                <tbody>
                    
                    <?php @$tot_rec = 0; $tot_pay = 0;  ?>
                        @foreach($data['ac'] AS $a)
                            
                            <tr class="text-dark">
                                <td>{{$loop->iteration}}</td>
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
                        <tr>
                            <td></td>
                            <td>Total :</td>
                            <td>-</td>
                            <td>{{@$tot_rec}}</td>
                            <td>{{@$tot_pay}}</td>
                            
                        </tr>
                    </tbody>
                                
                
            </table>

            <div class="terms-conditions">
                <div class="sign">
                    <ul>Signature______________________________</ul>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
