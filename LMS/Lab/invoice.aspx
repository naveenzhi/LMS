<%@ Page Title="Invoice" Language="C#" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="invoice.aspx.cs" Inherits="LMS.Lab.invoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background: #fff !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="accordion" class="sidenav scroll-thin pt-2 d-print-none">
        <div class="list-group list-group-flush">
            <a href="Dashboard.aspx" class="list-group-item list-group-item-action"><i class="fa fa-tachometer-alt mr-3"></i>Dashboard</a>
            <div class="accordion-title">
                <a class="list-group-item list-group-item-action collapsed" data-toggle="collapse" href="#collapsepatient" role="button" aria-expanded="true" aria-controls="collapsepatient"><i class="fas fa-users mr-3"></i>Patient</a>
            </div>
            <div class="collapse animated fadeInLeft" id="collapsepatient" data-parent="#accordion">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="new-patient"><i class="fas fa-user-alt mr-3"></i>Add New Patient</a></li>
                    <li class="nav-item"><a class="nav-link" href="patient"><i class="fas fa-list-alt mr-3"></i>Manage Patient</a></li>
                </ul>
            </div>
            <div class="accordion-title">
                <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapseorder" role="button" aria-expanded="true" aria-controls="collapseorder"><i class="fab fa-first-order mr-3"></i>Order</a>
            </div>
            <div class="collapse show animated fadeInLeft" id="collapseorder" data-parent="#accordion">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="new-order"><i class="fas fa-procedures mr-3"></i>New Order</a></li>
                    <li class="nav-item"><a class="nav-link active" href="order"><i class="fas fa-clipboard-list mr-3"></i>Manage Order</a></li>
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
    </div> <!-- ignore warning -->
    </div> <!-- ignore warning -->
    <div class="side-main">

        <div class="bg-white container-fluid">
            <div class="main-content pt-3">
                <div class="mb-2 text-center d-print-none">
                    <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                        <button type="button" class="btn btn-secondary" onclick="javascript:window.print();"><i class="fa fa-print"></i></button>
                        <button type="button" class="btn btn-secondary" onclick="javascript:window.print();"><i class="fa  fa-file-pdf"></i></button>
                        <button type="button" class="btn btn-secondary"><i class="fa fa-envelope"></i></button>
                    </div>
                </div>
                <div id="print-invoice" class="card card-body rounded-new m-3">
                    <asp:Panel ID="PanelHeader" CssClass="mb-3" runat="server" Visible="false">
                        <asp:Label ID="LabelHeader" runat="server"></asp:Label>
                    </asp:Panel>
                    <div class="row">
                        <div class="col-6">
                            <table class="table table-borderless">
                                <tr>
                                    <td>Patient Name </td>
                                    <td>:</td>
                                    <td>
                                        <asp:Label ID="LabelPatientName" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Address</td>
                                    <td>:</td>
                                    <td><asp:Label ID="LabelAddress" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Age / Sex</td>
                                    <td>:</td>
                                    <td><asp:Label ID="LabelAge" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Ref. By</td>
                                    <td>:</td>
                                    <td><asp:Label ID="LabelReferredBy" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Ref. To</td>
                                    <td>:</td>
                                    <td>
                                        <asp:Label ID="LabelReferredTo" runat="server"></asp:Label></td>
                                </tr>
                            </table>

                        </div>

                        <div class="col-6 ml-auto">

                            <table class="table table-borderless">
                                <tr>
                                    <td>Invoice # </td>
                                    <td>:</td>
                                    <td><asp:Label ID="LabelOrderNo" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Date</td>
                                    <td>:</td>
                                    <td><asp:Label ID="LabelOrderDate" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Phone</td>
                                    <td>:</td>
                                    <td><asp:Label ID="LabelPhone" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <td>:</td>
                                    <td><asp:Label ID="LabelEmail" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </div>


                    </div>

                    <div class="p-2 bg-light mb-3">
                        <p><strong>Total Amount:  <asp:Label ID="LabelAmount" runat="server"></asp:Label> </strong></p>
                        <h6>Discount: <asp:Label ID="LabelDiscount" runat="server"></asp:Label></h6>
                    </div>
                    <table class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>#</th>
                                <th>Investigation</th>
                                <th>Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="RepeaterTest" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Container.ItemIndex + 1 %></td>
                                        <td><%# Eval("testname") %></td>
                                        <td><%#Eval("testprice","{0:c}") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>

                        </tbody>


                    </table>
                    <small class="mt-5 pb-2 pr-4 text-right">Authorised Signatory</small>
                    <asp:Panel ID="PanelFooter" CssClass="mt-3" runat="server" Visible="false">
                        <asp:Label ID="LabelFooter" runat="server">
                        </asp:Label>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="bg-white card card-body d-print-none">
            <p>© 2019 All Rights Reserved. Powered by <a href="http://www.triopod.in/" class="text-dark" target="_blank">Triopod Technology</a><span class="float-right">lms version 1.1</span></p>
        </div>

    </div>


</asp:Content>