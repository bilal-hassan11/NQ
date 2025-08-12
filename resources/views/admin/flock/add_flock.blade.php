@extends('layouts.admin')
@section('content')

<div class="main-content app-content mt-5">
  <div class="side-app">
    <!-- CONTAINER -->
    <div class="main-container container-fluid">
        <!-- PAGE-HEADER -->


        <!-- COL END --> <!-- ROW-3 END --> <!-- ROW-5 -->

        <div class="row">
          <div class="col-12 col-sm-12">
              <div class="card ">
                <div class="card-header">
                    <h3 class="card-title mb-0">Add Flock Details</h3>
                </div>
                <div class="card-body">

                  <div class="card-block">
                    <div class="item_row">

                        <form class="ajaxForm" role="form" action="{{ route('admin.flocks.store') }}" method="POST" novalidate>
                            @csrf
                              <div class="row">
                                <div class="col-md-3">
                                  <div class="form-group">
                                    <label>Start Date</label>
                                    <input class="form-control" type="date"  name="start_date" value="{{ (@$edit_flock->start_date != "") ? date('Y-m-d', strtotime(@$edit_flock->start_date)) : date('Y-d-d') }}" required>
                                  </div>
                                </div>
                                <input type="hidden" name="flock_id" value="{{ @$edit_flock->id }}">

                                <div class="col-md-3">
                                  <div class="form-group">
                                    <label>Flock Name </label>
                                    <input class="form-control" name="name" value="{{ @$edit_flock->name }}" required>
                                  </div>
                                </div>
                                <div class="col-md-3 ">
                                    <div class="form-group">
                                      <label for="shade" class="required">Shade Name</label>
                                      <select class="form-control select2" name="shade" id="shade_id">
                                        <option value="">Select Shade</option>
                                        @foreach($shade as $s)
                                        <option  value="{{ $s->id }}"  {{ $s->id == @$edit_flock->shade_id ? 'selected' : '' }}>{{ $s->name }}</option>
                                        @endforeach
                                      </select>
                                    </div>
                                  </div>
                                <div class="col-md-3">
                                  <div class="form-group">
                                    <label>Status </label>
                                      <select class="form-control select2" name="status" id="status">
                                        <option value="active">Active</option>
                                        <option value="not_active">Not Active</option>
                                      </select>
                                  </div>
                                </div>
                              </div>
                              <div class="row">
                                <div class="col-md-3">
                                  <div class="form-group">
                                    <button type="submit" value="submit" name="save_shade" class="btn btn-success"> Save </button>
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
                    <h3 class="card-title mb-0">All Flocks Details </h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                      <div id="data-table_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">

                            <div class="row">
                              <div class="col-sm-12">
                                <table id="example5" class="text-fade table table-bordered" style="width:100%">
                                    <thead>
                                        <tr class="text-dark">
                                            <th>S.NO</th>
                                            <th>Start date</th>
                                            <th>Shade Name</th>
                                            <th>Flock Name</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      @foreach($flock AS $f)
                                        <tr>
                                            <td>{{ $loop->iteration }}</td>
                                            <td>{{ date('d-M-Y', strtotime( @$f->start_date)) }}</td>

                                            <td><span
                                                class="waves-effect waves-light btn btn-rounded btn-danger-light">{{ $f->shade->name ?? '' }}</span>
                                            </td>
                                            <td><span
                                                class="waves-effect waves-light btn btn-rounded btn-success-light">{{ $f->name ?? '' }}</span>
                                            </td>

                                            <td>{{ $f->status }}</td>
                                            <td style="width: 20%; !important">

                                                <a class="btn btn-outline-info rounded-pill btn-wave mr-2"
                                                    href="{{route('admin.flocks.edit', $f->hashid)}}"
                                                    title="Edit">
                                                    <i class="ri-edit-line"></i>
                                                </a>

                                            </td>

                                        </tr>
                                        @endforeach
                                    </tbody>

                                </table>
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





