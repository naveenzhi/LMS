﻿<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="change-password.aspx.cs" Inherits="LMS.Lab.change_password" %>

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
            <a href="setting.aspx" class="list-group-item list-group-item-action active"><i class="fa fa-cog mr-3"></i>Setting</a>
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
                    <ol class="breadcrumb bg-white shadow-sm">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Change Password</li>
                    </ol>
                </nav>
                <div id="messagediv" runat="server" visible="false">
                    <p id="mesaagetxt" runat="server"></p>
                </div>
                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">Change Password
                    </h3>
                    <div class="card border-0">
                        <div class="card-body form-row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="username">Current Password <span class="text-danger">*</span></label>
                                <asp:TextBox ID="TextBoxCurrentPassword" TextMode="Password" CssClass="form-control" MaxLength="15" runat="server" required="required"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="password">New Password (max 15 digit)<span class="text-danger">*</span></label>
                                <asp:TextBox ID="TextBoxNewPassword" TextMode="Password" CssClass="form-control" MaxLength="15" runat="server" required="required"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer bg-white">
                        <asp:Button ID="ButtonChangePassword" runat="server" CssClass="btn btn-success mb-2 text-white" OnClick="ButtonChangePassword_Click" Text="Login" />
                    </div>
                </div>
            </div>

        </div>
        <div class="bg-white card card-body">
            <p>© 2019 All Rights Reserved. Powered by <a href="http://www.triopod.in/" class="text-dark" target="_blank">Triopod Technology</a><span class="float-right">lms version 1.1</span></p>
        </div>
    </div>


</asp:Content>
