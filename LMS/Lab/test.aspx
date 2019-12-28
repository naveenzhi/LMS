<%@ Page Title="Test" Language="C#" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="LMS.Lab.test" %>
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
                <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapsetest" role="button" aria-expanded="true" aria-controls="collapsetest"><i class="fas fa-flask mr-3"></i>Test</a>
            </div>
            <div class="collapse show animated fadeInLeft" id="collapsetest" data-parent="#accordion">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="new-test"><i class="fas fa-user-plus mr-3"></i>Add New Test</a></li>
                    <li class="nav-item"><a class="nav-link active" href="test"><i class="fas fa-list-ol mr-3"></i>Manage Test</a></li>
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
                        <li class="breadcrumb-item active" aria-current="page">Test</li>
                    </ol>
                </nav>
                <div id="messagediv" runat="server" visible="false" role="alert" data-wow-duration="10ms" data-wow-delay="30ms">
                    <p id="mesaagetxt" runat="server"></p>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">Test
                    </h3>
                    <div class="card border-0">
                        
                        <div class="card-body">
                            <asp:LinkButton ID="LinkButtonDelete" runat="server" CssClass="btn btn-danger float-lg-right" OnClick="LinkButtonDelete_Click" OnClientClick="loading()">Delete Selected Test</asp:LinkButton>
                            <div class="table-responsive">
                                <table class="table table-bordered" id="tablepaging">
                                    <thead class="thead-light">
                                        <tr>
                                            
                                            <th>Test Name</th>
                                            <th>Price</th>
                                            <th>Normal Range</th>
                                            <th>Status</th>
                                            <th class="no-sort">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="RepeaterTest" runat="server">
                                            <ItemTemplate>

                                                <tr>
                                                    
                                                    <td>
                                                        <asp:HiddenField ID="HiddenTestId" Value='<%#Eval("TestID") %>' runat="server" />
                                                        <asp:CheckBox ID="CheckBoxTest" runat="server" CssClass="CheckBoxTest" Text='<%#Eval("TestName") %>' />
                                                    </td>
                                                    <td><%# Eval("Price", "{0:c}") %></td>
                                                    <td><%#Eval("NormalRange") %></td>
                                                    <td><%# (Boolean.Parse(Eval("Status").ToString())) ? "Active" : "In Active" %></td>
                                                    <td>
                                                        <a href="#" data-toggle="modal" data-target="#edit<%#Eval("TestID") %>" class="text-primary"><i class="fas fa-edit"></i></a>
                                                        <div class="modal fade" id="edit<%#Eval("TestID") %>" tabindex="-1" role="dialog" aria-labelledby="editLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                                <div class="modal-content border-0">
                                                                    <div class="modal-header bg-blue">
                                                                        <h5 class="modal-title text-white" id="editLabel"><%#Eval("TestName") %></h5>
                                                                        <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                                                                            <i class="fa fa-times pr-0"></i>
                                                                        </a>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <asp:HiddenField ID="HiddenFieldTestID" Value='<%#Eval("TestID") %>' runat="server" />
                                                                        <div class="form-group">
                                                                            <label class="text-black-50" for="DropDownListStatus">Status<span class="text-danger">*</span></label>
                                                                            <asp:DropDownList ID="DropDownListStatus" CssClass="form-control" runat="server" SelectedValue='<%#Eval("Status") %>'>
                                                                                <asp:ListItem disabled="disabled">Status</asp:ListItem>
                                                                                <asp:ListItem Value="True">Active</asp:ListItem>
                                                                                <asp:ListItem Value="False">Inactive</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="text-black-50" for="TextBoxTestName">Test Name<span class="text-danger">*</span></label>
                                                                            <asp:TextBox ID="TextBoxTestName" runat="server" CssClass="form-control" Text='<%#Eval("TestName") %>' placeholder="Enter Test Name"></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="text-black-50" for="TextBoxPrice">Price<span class="text-danger">*</span></label>
                                                                            <asp:TextBox ID="TextBoxPrice" runat="server" CssClass="form-control" TextMode="Number" Text='<%#Eval("Price") %>' placeholder="Enter Price"></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="text-black-50" for="TextBoxNormalRange">Normal Range</label>
                                                                            <asp:TextBox ID="TextBoxNormalRange" runat="server" CssClass="form-control" Text='<%#Eval("NormalRange") %> '></asp:TextBox>
                                                                        </div>
                                                                        
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <asp:LinkButton ID="LinkButtonUpdateRecord" runat="server" CssClass="btn btn-success text-white" Text="Save" OnClick="LinkButtonUpdateRecord_Click" />
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
        <div class="bg-white card card-body mt-4">
            <p>© 2019 All Rights Reserved. Powered by <a href="http://www.triopod.in/" class="text-dark" target="_blank">Triopod Technology</a><span class="float-right">lms version 1.1</span></p>
        </div>
    </div>
</asp:Content>
