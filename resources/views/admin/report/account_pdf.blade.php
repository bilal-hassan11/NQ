<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $data['account_name']->name}} | Ledger Statement</title>
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
        .td-styling{
            font-size: 14px;
            
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
                        
                        <h1 class="text-center"><u>Ghulam Hussain Poultry | Ledger Statement</u></h1>
                           
                    </td>
                    
                    
                </tr>
                
            </table>
         </div>
         <div class="header">
            <h2 class="party_name">{{ $data['account_name']->name }}</h2>
            <h4 class="date">From {{$data['from_date']}} to {{$data['to_date']}}</h4>
        </div>
         
        <div class="table-container">


            <table >
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Dr</th>
                        <th>Cr</th>
                        <th>Balance</th>
                        <th>cr/dr</th>
                    </tr>
                </thead>
                <tbody>

                    <tbody>
                        @if(@$data['account_ledger'] != "")

                            @if(@$data['account_nature'] == "debit")
                                @php
                                    $tot_balance = 0; $tot_deb=0;
                                    $tot_credit=0; $tot_bal = 0;
                                @endphp
                                <tr class="text-dark">
                                    <td><span class="td-styling"> {{ date('d-M-Y', strtotime($data['from_date'])) }}</span></td>
                                    <td><span class="td-styling">-</span></td>
                                    <td > <span class="td-styling" >Opening Balance </span></td>

                                        <?php $tot_balance += @$data['opening_balance'] ?>

                                        <td><span class="td-styling">{{ number_format(@$data['opening_balance'],2) }}</span></td>
                                        <td><span class="td-styling">0</span></td>

                                        <td><span class="td-styling">{{ number_format($tot_balance,2) }}</span></td>

                                        <td><span class="td-styling">dr</span></td>
                                        <?php @$tot_bal += @$tot_balance; ?>



                                </tr>
                                <?php $tot_balance = @$data['opening_balance'] ; ?>
                                @foreach($data['account_ledger'] AS $ac)
                                    <?php @$tot_deb += $ac->debit; $tot_credit += $ac->credit;  ?>
                                    <tr class="text-dark">
                                        @if(@$ac->debit != 0 && @$ac->credit == 0)
                                        <td><span class="td-styling"> {{ date('d-M-Y', strtotime($ac->date)) }}</span></td>
                                        <td><span class="td-styling"> {{ @$ac->type }}</span></td>

                                        <td > <span class="td-styling">{{ @$ac->description }}</span></td>
                                        <td><span class="td-styling">{{ number_format(@$ac->debit) }}</span></td>
                                        <td><span class="td-styling" >{{  number_format(@$ac->credit) }}</span></td>
                                        
                                        <?php $tot_balance += $ac->debit - $ac->credit ;?>
                                        <td><span class="td-styling">{{ number_format(abs($tot_balance)) }}</span></td>
                                       
                                        @if($tot_balance > 0)
                                        <td><span class="td-styling">dr</span></td>
                                        <?php @$tot_bal += @$tot_balance; ?>
                                        @endif
                                        @if( @$tot_balance <= 0)
                                        <td><span >cr</span></td>
                                            <?php @$tot_bal += @$tot_balance; ?>
                                        @endif

                                        @endif
                                        @if(@$ac->credit != 0 && @$ac->debit == 0)
                                        
                                        <td><span class="td-styling" style="color:red"> {{ date('d-M-Y', strtotime($ac->date)) }}</span></td>
                                        <td><span class="td-styling" style="color:red"> {{ @$ac->type }}</span></td>

                                        <td > <span class="td-styling" style="color:red">{{ @$ac->description }}</span></td>
                                        <td><span class="td-styling" style="color:red">{{ number_format(@$ac->debit) }}</span></td>
                                        <td><span class="td-styling" style="color:red">{{  number_format(@$ac->credit) }}</span></td>
                                        
                                        <?php $tot_balance += $ac->debit - $ac->credit ;?>
                                        <td><span class="td-styling" style="color:red">{{ number_format(abs($tot_balance)) }}</span></td>
                                       
                                        @if($tot_balance > 0)
                                        <td><span class="td-styling" style="color:red">dr</span></td>
                                        <?php @$tot_bal += @$tot_balance; ?>
                                        @endif
                                        @if( @$tot_balance <= 0)
                                        <td><span class="td-styling">cr</span></td>
                                            <?php @$tot_bal += @$tot_balance; ?>
                                        @endif

                                        @endif
                                        <?php @$tot_bal += @$tot_balance; ?>
                                        
                                        


                                    </tr>
                                @endforeach
                            @endif
                            @if(@$data['account_nature'] == "credit")
                                @php
                                    $tot_balance = 0; $tot_deb=0;
                                    $tot_credit=0; $tot_bal = 0;
                                @endphp
                                <tr class="text-dark" >
                                    <td> {{ date('d-M-Y', strtotime($data['from_date'])) }}</td>
                                    <td> - </td>
                                    <td > Opening Balance </td>
                                    <?php $tot_balance -= @$data['opening_balance'];?>
                                    <td>0</td>
                                    <td> {{ @$data['opening_balance'] }}</td>
                                    <td> {{ @$data['opening_balance'] }}</td>

                                    <td>cr</td>
                                    <?php @$tot_bal += @$tot_balance; ?>


                                </tr>

                                <?php $tot_balance = @$data['opening_balance'] ; ?>

                                @foreach($data['account_ledger'] AS $ac)
                                <?php @$tot_deb += $ac->debit; $tot_credit += $ac->credit;  ?>
                                    <tr class="text-dark" >
                                        @if(@$ac->debit != 0 && @$ac->credit == 0)
                                            <td> <span class="td-styling" style="color:red"> {{ date('d-M-Y', strtotime($ac->date)) }}</span></td>
                                            <td> <span class="td-styling" style="color:red">{{ @$ac->type }}</span></td>
    
                                            <td ><span class="td-styling" style="color:red">{{ @$ac->description }}</span></td>
                                            <td><span class="td-styling" style="color:red">{{ number_format(@$ac->debit) }}</span></td>
                                            <td><span class="td-styling" style="color:red">{{  number_format(@$ac->credit) }}</span></td>
    
                                            <?php $tot_balance += $ac->credit - $ac->debit ;?>
    
                                            @if($tot_balance > 0)
                                            <td><span class="td-styling" style="color:red">{{ number_format(abs($tot_balance)) }}</span></td>
                                            <td><span class="td-styling" style="color:red">cr</span></td>
                                            <?php @$tot_bal += @$tot_balance; ?>
                                            @endif
                                            @if( @$tot_balance <= 0)
                                            <td><span class="td-styling" style="color:red">{{ number_format(abs($tot_balance)) }}</span></td>
                                            <td><span class="td-styling" style="color:red">dr</span></td>
                                                <?php @$tot_bal += @$tot_balance; ?>
                                            @endif
                                        @endif
                                        @if(@$ac->credit != 0 && @$ac->debit == 0)
                                            <td> {{ date('d-M-Y', strtotime($ac->date)) }}</td>
                                            <td> {{ @$ac->type }}</td>
    
                                            <td >{{ @$ac->description }}</td>
                                            <td>{{ number_format(@$ac->debit) }}</td>
                                            <td>{{  number_format(@$ac->credit) }}</td>
    
                                            <?php $tot_balance += $ac->credit - $ac->debit ;?>
    
                                            @if($tot_balance > 0)
                                            <td>{{ number_format(abs($tot_balance)) }}</td>
                                            <td>cr</td>
                                            <?php @$tot_bal += @$tot_balance; ?>
                                            @endif
                                            @if( @$tot_balance <= 0)
                                            <td>{{ number_format(abs($tot_balance)) }}</td>
                                            <td>dr</td>
                                                <?php @$tot_bal += @$tot_balance; ?>
                                            @endif
                                        @endif    
                                        
                                    </tr>
                                @endforeach
                            @endif

                        @endif
                    </tbody>



                <tfoot>
                    <tr>
                        <td colspan="3"></td>
                        @if(@$data['account_nature'] == "debit")
                            <td ><span class="td-styling">{{ number_format(@$tot_deb + $data['opening_balance'] ,2) }}</span></td>
                            <td><span class="td-styling">{{ number_format(@$tot_credit ,2) }}</span></td>
                            <td><span class="td-styling">{{ number_format(abs(  @$tot_balance) ,2) }}</span></td>

                        @endif

                        @if(@$data['account_nature'] == "credit")
                            <td ><span class="td-styling">{{ number_format(@$tot_deb  ,2) }}</span></td>
                            <td><span class="td-styling">{{ number_format(@$tot_credit + $data['opening_balance'] ,2) }}</span></td>
                            <td><span class="td-styling">{{ number_format(abs(@$tot_balance) ,2) }}</span></td>

                        @endif
                        <td class="td-styling">-</span></td>
                    </tr>

                </tfoot>
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
