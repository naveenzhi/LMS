<%@ Page Title="Generate Report" Language="C#" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="generate-report.aspx.cs" Inherits="LMS.Lab.generate_report" %>

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
            <a href="add-result.aspx" class="list-group-item list-group-item-action"><i class="fas fa-notes-medical mr-3"></i>Add Test Result</a>

            <a href="generate-report.aspx" class="list-group-item list-group-item-action active"><i class="fas fa-file-alt mr-3"></i>Generate Report</a>
            

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
                        <li class="breadcrumb-item active" aria-current="page">Report</li>
                    </ol>
                </nav>

                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">Generate Report
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
                                            <th>Sex</th>
                                            <th>Ordered Date</th>
                                            <th class="no-sort">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="RepeaterOrder" runat="server">
                                            <ItemTemplate>

                                                <tr>
                                                    <td><%# Container.ItemIndex + 1 %></td>
                                                    <td><%#Eval("OrderID") %></td>
                                                    <td><%# Eval("PatientName") %></td>
                                                    <td><%# Eval("Mobile") %></td>
                                                    <td><%# Eval("Sex") %></td>
                                                    <td><%#Eval("DateCreated","{0:dd MMM yy hh:mm tt}") %></td>

                                                    <td>
                                                        <a class="btn-sm btn-success" href="report.aspx?oid=<%#Eval("OrderID") %>">Generate Report</a>
                                                        <div class="dropdown dropleft mt-2">
                                                            <a href="#" class="dropdown-toggle no-toggle" data-toggle="dropdown">
                                                                <i class="fas fa-ellipsis-v mr-2"></i>More Action
                                                            </a>
                                                            <div class="dropdown-menu animated fadeIn">
                                                                <%--<a class="dropdown-item" href="Order_Test_Details.aspx?oid=<%#Eval("OrderID") %>">Test details</a>--%>
                                                                <a class="dropdown-item" href="edit-report.aspx?oid=<%#Eval("OrderID") %>">Edit Report</a>

                                                                <a class="dropdown-item" href="invoice.aspx?oid=<%#Eval("OrderID") %>">View Reciept</a>

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
        <div class="bg-white card card-body">
            <p>© 2019 All Rights Reserved. Powered by <a href="http://www.triopod.in/" class="text-dark" target="_blank">Triopod Technology</a><span class="float-right">lms version 1.1</span></p>
        </div>

    </div>


</asp:Content>
