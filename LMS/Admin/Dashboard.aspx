<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LMS.Admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="collapse animated fadeIn d-print-none" id="collapsibleNavbar">
        <div class="sidenav shadow-sm">
            <div id="accordion" class="sidenav scroll-thin pt-2">
                <div class="list-group list-group-flush">
                    <a href="Dashboard.aspx" class="list-group-item list-group-item-action active"><i class="fa fa-tachometer-alt mr-3"></i>Dashboard</a>
                    <div class="accordion-title">
                        <a class="list-group-item list-group-item-action collapsed" data-toggle="collapse" href="#collapselab" role="button" aria-expanded="true" aria-controls="collapselab"><i class="fas fa-users mr-3"></i>Lab</a>
                    </div>
                    <div class="collapse animated fadeInLeft" id="collapselab" data-parent="#accordion">
                        <ul class="nav flex-column">
                            <li class="nav-item"><a class="nav-link" href="new-lab"><i class="fas fa-user-alt mr-3"></i>Add New Lab</a></li>
                            <li class="nav-item"><a class="nav-link" href="manage-lab"><i class="fas fa-list-alt mr-3"></i>Manage Lab</a></li>
                        </ul>
                    </div>
                    
                    
                </div>
            </div>
        </div>
    </div>
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

                            <div class="card-body align-items-center text-primary font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-flask"></i>
                                    <asp:Label ID="LabelTotalLab" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Total Lab</small>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-success font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-user-check"></i>
                                    <asp:Label ID="LabelActiveLab" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Active Lab</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-danger font-weight-bold">

                                <p class="h2">
                                    <i class="fas  fa-user-friends"></i>
                                    <asp:Label ID="LabelInactiveLab" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">InActive Lab</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4 mb-lg-0">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-pink font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-flask"></i>
                                    <asp:Label ID="LabelTodayLab" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Today Lab</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3  mb-4 mb-lg-0">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-warning font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-flask"></i>
                                    <asp:Label ID="LabelYesterdayLab" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Yesterday Lab</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4 mb-lg-0">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-info font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-flask"></i>
                                    <asp:Label ID="LabelWeeklyLab" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Lab This Week</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4 mb-lg-0">
                        <div class="card rounded-new">

                            <div class="card-body align-items-center text-orange font-weight-bold">

                                <p class="h2">
                                    <i class="fas fa-flask"></i>
                                    <asp:Label ID="LabelMonthlyLab" CssClass="float-right" runat="server" Text="0"></asp:Label>
                                </p>
                                <small class="card-title">Lab This Month</small>
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
