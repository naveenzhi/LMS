<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LMS.Lab.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="accordion" class="sidenav scroll-thin pt-2">
        <div class="list-group list-group-flush">
            <a href="Dashboard.aspx" class="list-group-item list-group-item-action active"><i class="fa fa-tachometer-alt mr-3"></i>Dashboard</a>
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
                    <ol class="breadcrumb bg-white rounded">
                        <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                    </ol>
                </nav>

                <div class="row mt-5">
                    <div class="col-md-3 mb-4">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-success font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-user-friends"></i>
                                    <asp:Label ID="LabelTotalPatient" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Total Patient</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-3 mb-4">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-warning font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-flask"></i>
                                    <asp:Label ID="LabelTodayTest" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Today Test</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-primary font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-user-check"></i>
                                    <asp:Label ID="LabelTodayPatient" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Today Appointment</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3  mb-4 mb-lg-0">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-pink font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-flask"></i>
                                    <asp:Label ID="LabelYesterdayTest" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Yesterday Test</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4 mb-lg-0">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-primary font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-flask"></i>
                                    <asp:Label ID="LabelWeeklyTest" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Test This Week</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4 mb-lg-0">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-pink font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-flask"></i>
                                    <asp:Label ID="LabelMonthlyTest" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Test This Month</small>
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
