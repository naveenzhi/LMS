<%@ Page Title="Add Result" Language="C#" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="add-result.aspx.cs" Inherits="LMS.Lab.add_result" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="accordion" class="sidenav scroll-thin pt-2">
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
                <a class="list-group-item list-group-item-action collapsed" data-toggle="collapse" href="#collapseorder" role="button" aria-expanded="true" aria-controls="collapseorder"><i class="fab fa-first-order mr-3"></i>Order</a>
            </div>
            <div class="collapse animated fadeInLeft" id="collapseorder" data-parent="#accordion">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="new-order"><i class="fas fa-procedures mr-3"></i>New Order</a></li>
                    <li class="nav-item"><a class="nav-link" href="order"><i class="fas fa-clipboard-list mr-3"></i>Manage Order</a></li>
                </ul>
            </div>
            <a href="add-result.aspx" class="list-group-item list-group-item-action active"><i class="fas fa-notes-medical mr-3"></i>Add Test Result</a>

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
                        <li class="breadcrumb-item"><a class="btn-link" href="Dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Add Test Result</li>
                    </ol>
                </nav>
                <div id="messagediv" runat="server" visible="false" role="alert" data-wow-duration="10ms" data-wow-delay="30ms">
                    <p id="mesaagetxt" runat="server"></p>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">Add Test Result
                    </h3>
                    <div class="card border-0">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover" id="tablepaging">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>Order Id</th>
                                            <th>Patient Name</th>
                                            <th>Patient Mobile</th>
                                            <th>Ordered Date</th>
                                            <th class="no-sort">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="RepeaterOrder" runat="server" OnItemDataBound="RepeaterOrder_ItemDataBound">
                                            <ItemTemplate>

                                                <tr>
                                                    <td><%# Container.ItemIndex + 1 %></td>
                                                    <td><%#Eval("OrderID") %></td>
                                                    <td><%# Eval("PatientName") %></td>
                                                    <td><%# Eval("Mobile") %></td>
                                                    <td><%#Eval("DateCreated","{0:dd MMM yy hh:mm tt}") %></td>

                                                    <td>
                                                        <a href="#" data-toggle="modal" data-target="#AddFullResult<%#Eval("OrderID") %>" class="btn-sm btn-success"><i class="fas fa-plus-circle mr-2"></i>Add Result</a>
                                                        <a href="#" data-toggle="modal" data-target="#AddResult<%#Eval("OrderID") %>" class="btn-sm btn-primary"><i class="fas fa-plus-circle mr-2"></i>Add Single Result</a>
                                                        <div class="modal fade" id="AddResult<%#Eval("OrderID") %>" tabindex="-1" role="dialog" aria-labelledby="AddResultLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                                <div class="modal-content border-0">
                                                                    <div class="modal-header bg-blue">
                                                                        <h5 class="modal-title text-white" id="AddResultLabel">Order Id - <%#Eval("OrderID") %> - <%#Eval("PatientName") %></h5>
                                                                        <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                                                                            <i class="fa fa-times pr-0"></i>
                                                                        </a>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="table-responsive">
                                                                            <table class="table table-bordered">
                                                                                <asp:Repeater ID="RepeaterOrderTest" runat="server">
                                                                                    <ItemTemplate>
                                                                                        <tr>
                                                                                            <td><%# Container.ItemIndex + 1 %></td>
                                                                                            <td><%#Eval("TestName") %></td>
                                                                                            <td><a href="#" id="addresultbtnlink" class="btn-sm btn-primary" runat="server" visible='<%# Convert.ToBoolean(Eval("IsReportGenerated").ToString() == "True" ? "False": "True") %>'>Add Result</a></td>
                                                                                        </tr>
                                                                                    </ItemTemplate>
                                                                                </asp:Repeater>
                                                                            </table>
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="modal fade" id="AddFullResult<%#Eval("OrderID") %>" tabindex="-1" role="dialog" aria-labelledby="AddFullResultLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-lg" role="document">
                                                                <div class="modal-content border-0">
                                                                    <div class="modal-header bg-blue">
                                                                        <h5 class="modal-title text-white" id="AddFullResultLabel">Order Id - <asp:Label ID="LabelOrderId" runat="server" Text='<%#Eval("OrderID") %>'></asp:Label> - <%#Eval("PatientName") %></h5>
                                                                        <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                                                                            <i class="fa fa-times pr-0"></i>
                                                                        </a>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="form-group mb-3">
                                                                            <label>Report Notes</label>
                                                                            <asp:TextBox ID="TextBoxReportNotes" CssClass="summernote-simple" TextMode="MultiLine" runat="server"></asp:TextBox>
                                                                        </div>

                                                                        <div class="table-responsive">
                                                                            <table class="table table-bordered">
                                                                                <thead class="thead-light">
                                                                                    <tr>
                                                                                        <th>#</th>
                                                                                        <th>Test</th>
                                                                                        <th>Result</th>
                                                                                        <th>Normal Range</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <asp:Repeater ID="RepeaterOrderAllTest" runat="server">
                                                                                        <ItemTemplate>
                                                                                            <tr>
                                                                                                <td><%# Container.ItemIndex + 1 %></td>
                                                                                                <td>
                                                                                                    <asp:HiddenField ID="HiddenFieldTestId" Value='<%#Eval("TestID") %>' runat="server" />
                                                                                                    <asp:Label ID="LabelTestName" runat="server" Text='<%#Eval("TestName") %>'></asp:Label></td>
                                                                                                <td>
                                                                                                    <asp:TextBox ID="TextBoxResult" CssClass="form-control" Text='<%#Eval("DefaultResult") %>' runat="server" required=""></asp:TextBox></td>
                                                                                                <td>
                                                                                                    <asp:Label ID="LabelNormalRange" runat="server" Text='<%#Eval("NormalRange") %>'></asp:Label></td>
                                                                                            </tr>
                                                                                            </tr>
                                                                                        </ItemTemplate>
                                                                                    </asp:Repeater>
                                                                            </table>
                                                                        </div>
                                                                        <asp:LinkButton ID="LinkButtonSaveResult" runat="server" CssClass="btn btn-success" OnClick="LinkButtonSaveResult_Click" OnClientClick="loading()">Save</asp:LinkButton>
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
