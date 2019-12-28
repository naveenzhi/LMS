<%@ Page Title="Patient Order Details" Language="C#" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="patient-order.aspx.cs" Inherits="LMS.Lab.patient_order" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="accordion" class="sidenav scroll-thin pt-2">
        <div class="list-group list-group-flush">
            <a href="Dashboard.aspx" class="list-group-item list-group-item-action"><i class="fa fa-tachometer-alt mr-3"></i>Dashboard</a>
            <div class="accordion-title">
                <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapsepatient" role="button" aria-expanded="true" aria-controls="collapsepatient"><i class="fas fa-users mr-3"></i>Patient</a>
            </div>
            <div class="collapse show animated fadeInLeft" id="collapsepatient" data-parent="#accordion">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="new-patient"><i class="fas fa-user-alt mr-3"></i>Add New Patient</a></li>
                    <li class="nav-item"><a class="nav-link active" href="patient"><i class="fas fa-list-alt mr-3"></i>Manage Patient</a></li>
                </ul>
            </div>
            <div class="accordion-title">
                <a class="list-group-item list-group-item-action collapsed" data-toggle="collapse" href="#collapseorder" role="button" aria-expanded="true" aria-controls="collapseorder"><i class="fab fa-first-order mr-3"></i>Order</a>
            </div>
            <div class="collapse animated fadeInLeft" id="collapseorder" data-parent="#accordion">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="new-order"><i class="fas fa-procedures mr-3"></i>New Order</a></li>
                    <li class="nav-item"><a class="nav-link" href="order"><i class="fas fa-clipboard-list mr-3"></i>Manage Order</a></li>
                </ul>
            </div>
            <a href="add-result.aspx" class="list-group-item list-group-item-action"><i class="fas fa-notes-medical mr-3"></i>Add Test Result</a>

            <a href="generate-report.aspx" class="list-group-item list-group-item-action"><i class="fas fa-file-alt mr-3"></i>Generate Report</a>
            

            <div class="accordion-title">
                <a class="list-group-item list-group-item-action collapsed" data-toggle="collapse" href="#collapsetest" role="button" aria-expanded="true" aria-controls="collapsetest"><i class="fas fa-flask mr-3"></i>Test</a>
            </div>
            <div class="collapse animated fadeInLeft" id="collapsetest" data-parent="#accordion">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="new-test"><i class="fas fa-user-plus mr-3"></i>Add New Test</a></li>
                    <li class="nav-item"><a class="nav-link" href="test"><i class="fas fa-list-ol mr-3"></i>Manage Test</a></li>
                </ul>
            </div>
            <a href="setting.aspx" class="list-group-item list-group-item-action"><i class="fa fa-cog mr-3"></i>Setting</a>
        </div>
    </div>
    </div>
    <!-- ignore warning -->
    </div>
    <!-- ignore warning -->
    <div class="side-main">

        <div class="container-fluid">
            <div class="main-content pt-3 min-vh-100">


                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-white rounded align-items-center">
                        <li class="breadcrumb-item"><a class="btn-link" href="Dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Order</li>
                    </ol>
                </nav>
                <div id="messagediv" runat="server" visible="false" role="alert" data-wow-duration="10ms" data-wow-delay="30ms">
                    <p id="mesaagetxt" runat="server"></p>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">Patient Order Details
                    </h3>
                    <div class="card border-0">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="tablepaging">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>Order Id</th>
                                            <th>Amount</th>
                                            <th>Dues</th>
                                            <th>RefferedBy</th>
                                            <th>RefferedTo</th>
                                            <th>Ordered Date</th>
                                            <th>Status</th>
                                            <th class="no-sort">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="RepeaterOrder" runat="server">
                                            <ItemTemplate>

                                                <tr>
                                                    <td><%# Container.ItemIndex+1 %></td>
                                                    <td><%#Eval("OrderID") %></td>
                                                    <td><%# Eval("Amount", "{0:c}") %></td>
                                                    <td><%# Eval("Dues", "{0:c}") %></td>
                                                    <td><%#Eval("ReferredBy") %></td>
                                                    <td><%#Eval("ReferredTo") %></td>
                                                    <td><%#Eval("DateCreated","{0:dd MMM yy}") %></td>
                                                    <td><%#Eval("StatusName") %></td>

                                                    <td>
                                                        <div class="dropdown dropleft">
                                                            <a href="#" class="dropdown-toggle no-toggle" data-toggle="dropdown">
                                                                <i class="fas fa-ellipsis-v"></i>
                                                            </a>
                                                            <div class="dropdown-menu animated fadeIn">
                                                                <a href="#" data-toggle="modal" data-target="#details<%#Eval("OrderID") %>" class="dropdown-item"><i class="fas fa-flask mr-2"></i>View Test</a>
                                                                <a class="dropdown-item" href="invoice.aspx?oid=<%#Eval("OrderID") %>"><i class="fas fa-file-invoice mr-2"></i>View Reciept</a>

                                                            </div>
                                                        </div>

                                                        <div class="modal fade" id="details<%#Eval("OrderID") %>" tabindex="-1" role="dialog" aria-labelledby="editLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                                <div class="modal-content border-0">
                                                                    <div class="modal-header bg-blue">
                                                                        <h5 class="modal-title text-white" id="detailsLabel"></h5>
                                                                        <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                                                                            <i class="fa fa-times pr-0"></i>
                                                                        </a>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        Coming soon...
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>
                                                    </td>

                                                </tr>

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-white card card-body mt-3">
            <p>© 2019 All Rights Reserved. Powered by <a href="http://www.triopod.in/" class="text-dark" target="_blank">Triopod Technology</a><span class="float-right">lms version 1.1</span></p>
        </div>
    </div>
</asp:Content>
