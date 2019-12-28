<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="LMS.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="home" class="bg-gray">
        <img src="/Content/images/banner.png" class="img-fluid" alt="banner">
    </section>
    <section id="price" class="py-5 bg-gray">
        <div class="container">
            <p class="h1 text-center text-black text-uppercase pt-3 font-weight-bold">Our <span class="text-theme">Pricing</span></p>
            <div class="row py-4">
                <div class="col-lg-4">
                    <div class="card border-0 shadow">
                        <div class="card-body">
                            <p class="h3 text-center mb-3 font-weight-bold">1 Month</p>
                            <p class="h1 text-primary text-center">₹ 1,200.00</p>

                        </div>
                        <ul class="list-group list-group-flush mb-4">
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>300 Preloaded Test</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>Dashboard</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>Manage Patient</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>Manage Order</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>View Report</li>
                        </ul>
                        <div class="card-footer">
                            <a href="#" class="btn btn-primary btn-block">Get Started</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card border-0 shadow">
                        <div class="card-body">
                            <p class="h3 text-center mb-3 font-weight-bold">6 Month</p>
                            <p class="h1 text-warning text-center">₹ 6,000.00</p>

                        </div>
                        <ul class="list-group list-group-flush mb-4">
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>300 Preloaded Test</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>Dashboard</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>Manage Patient</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>Manage Order</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>View Report</li>
                        </ul>
                        <div class="card-footer">
                            <a href="#" class="btn btn-warning btn-block">Get Started</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card border-0 shadow">
                        <div class="card-body">
                            <p class="h3 text-center mb-3 font-weight-bold">12 Month</p>
                            <p class="h1 text-success text-center">₹ 10,000.00</p>

                        </div>
                        <ul class="list-group list-group-flush mb-4">
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>300 Preloaded Test</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>Dashboard</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>Manage Patient</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>Manage Order</li>
                            <li class="list-group-item"><i class="fas fa-check text-success mr-3"></i>View Report</li>
                        </ul>
                        <div class="card-footer">
                            <a href="#" class="btn btn-success btn-block">Get Started</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
