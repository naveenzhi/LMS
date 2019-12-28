<%@ Page Title="Add Lab" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="new-lab.aspx.cs" Inherits="LMS.Admin.new_lab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="collapse animated fadeIn d-print-none" id="collapsibleNavbar">
        <div class="sidenav shadow-sm">
            <div id="accordion" class="sidenav scroll-thin pt-2">
                <div class="list-group list-group-flush">
                    <a href="Dashboard.aspx" class="list-group-item list-group-item-action"><i class="fa fa-tachometer-alt mr-3"></i>Dashboard</a>
                    <div class="accordion-title">
                        <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapselab" role="button" aria-expanded="true" aria-controls="collapselab"><i class="fas fa-users mr-3"></i>Lab</a>
                    </div>
                    <div class="collapse show animated fadeInLeft" id="collapselab" data-parent="#accordion">
                        <ul class="nav flex-column">
                            <li class="nav-item"><a class="nav-link active" href="new-lab"><i class="fas fa-user-alt mr-3"></i>Add New Lab</a></li>
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
                    <ol class="breadcrumb bg-white rounded align-items-center">
                        <li class="breadcrumb-item"><a class="btn-link" href="Dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Add New Lab</li>
                    </ol>
                </nav>
                <div id="messagediv" runat="server" visible="false" role="alert" data-wow-duration="10ms" data-wow-delay="30ms">
                    <p id="mesaagetxt" runat="server"></p>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">Add New Lab
                    </h3>
                    <div class="card border-0">
                        <div class="card-body">
                            <div class="form-row">
                                <div class="col-md-3 mb-4">
                                    <label for="name">User Name <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="TextBoxUserName" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Password<span class="text-danger">*</span> (Max Length 15)</label>
                                    <asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password" MaxLength="15" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Lab Name <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="TextBoxLabName" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Owner Name <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="TextBoxOwnerName" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Mobile <span class="text-danger">*</span> (10 digit)</label>
                                    <asp:TextBox ID="TextBoxMobile" runat="server" MaxLength="10" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Phone</label>
                                    <asp:TextBox ID="TextBoxPhone" runat="server" MaxLength="12" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Email<span class="text-danger">*</span></label>
                                    <asp:TextBox ID="TextBoxEmail" runat="server" TextMode="Email" CssClass="form-control" required=""></asp:TextBox>
                                </div>

                                <div class="col-md-3 mb-4">
                                    <label for="name">Country <span class="text-danger">*</span></label>
                                    <asp:DropDownList ID="DropDownListCountry" CssClass="form-control" runat="server" required="">
                                        <asp:ListItem Value="India">India</asp:ListItem>

                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">State <span class="text-danger">*</span></label>
                                    <asp:DropDownList ID="DropDownListState" CssClass="form-control" runat="server" required="">
                                        <asp:ListItem Value="" Selected="True">Select State</asp:ListItem>
                                        <asp:ListItem Value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</asp:ListItem>
                                        <asp:ListItem Value="Andhra Pradesh">Andhra Pradesh</asp:ListItem>
                                        <asp:ListItem Value="Arunachal Pradesh">Arunachal Pradesh</asp:ListItem>
                                        <asp:ListItem Value="Assam">Assam</asp:ListItem>
                                        <asp:ListItem Value="Bihar">Bihar</asp:ListItem>
                                        <asp:ListItem Value="Chandigarh">Chandigarh</asp:ListItem>
                                        <asp:ListItem Value="Chhattisgarh">Chhattisgarh</asp:ListItem>
                                        <asp:ListItem Value="Dadra and Nagar Haveli">Dadra and Nagar Haveli</asp:ListItem>
                                        <asp:ListItem Value="Daman and Diu">Daman and Diu</asp:ListItem>
                                        <asp:ListItem Value="Delhi">Delhi</asp:ListItem>
                                        <asp:ListItem Value="Goa">Goa</asp:ListItem>
                                        <asp:ListItem Value="Gujarat">Gujarat</asp:ListItem>
                                        <asp:ListItem Value="Haryana">Haryana</asp:ListItem>
                                        <asp:ListItem Value="Himachal Pradesh">Himachal Pradesh</asp:ListItem>
                                        <asp:ListItem Value="Jammu and Kashmir">Jammu and Kashmir</asp:ListItem>
                                        <asp:ListItem Value="Jharkhand">Jharkhand</asp:ListItem>
                                        <asp:ListItem Value="Karnataka">Karnataka</asp:ListItem>
                                        <asp:ListItem Value="Kerala">Kerala</asp:ListItem>
                                        <asp:ListItem Value="Lakshadweep">Lakshadweep</asp:ListItem>
                                        <asp:ListItem Value="Madhya Pradesh">Madhya Pradesh</asp:ListItem>
                                        <asp:ListItem Value="Maharashtra">Maharashtra</asp:ListItem>
                                        <asp:ListItem Value="Manipur">Manipur</asp:ListItem>
                                        <asp:ListItem Value="Meghalaya">Meghalaya</asp:ListItem>
                                        <asp:ListItem Value="Mizoram">Mizoram</asp:ListItem>
                                        <asp:ListItem Value="Nagaland">Nagaland</asp:ListItem>
                                        <asp:ListItem Value="Odisha">Odisha</asp:ListItem>
                                        <asp:ListItem Value="Pondicherry">Pondicherry</asp:ListItem>
                                        <asp:ListItem Value="Punjab">Punjab</asp:ListItem>
                                        <asp:ListItem Value="Rajasthan">Rajasthan</asp:ListItem>
                                        <asp:ListItem Value="Sikkim">Sikkim</asp:ListItem>
                                        <asp:ListItem Value="Tamil Nadu">Tamil Nadu</asp:ListItem>
                                        <asp:ListItem Value="Telangana">Telangana</asp:ListItem>
                                        <asp:ListItem Value="Tripura">Tripura</asp:ListItem>
                                        <asp:ListItem Value="Uttar Pradesh">Uttar Pradesh</asp:ListItem>
                                        <asp:ListItem Value="Uttarakhand">Uttarakhand</asp:ListItem>
                                        <asp:ListItem Value="West Bengal">West Bengal</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="col-md-3 mb-4">
                                    <label for="name">City</label>
                                    <asp:TextBox ID="TextBoxCity" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Pincode</label>
                                    <asp:TextBox ID="TextBoxPincode" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Address <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="TextBoxAddress" runat="server" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Validity<span class="text-danger">*</span></label>

                                    <asp:TextBox ID="TextBoxValidity" runat="server" TextMode="Date" CssClass="form-control" required=""></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="FileUploadLogo">Logo</label>
                                    <div class="custom-file">
                                        <asp:FileUpload ID="FileUploadLogo" runat="server" CssClass="custom-file-input" accept="image/*" />
                                        <label class="custom-file-label" for="FileUploadPhotograph">Choose file</label>
                                    </div>

                                </div>
                                <div class="col-md-3 mb-4">
                                    <label for="name">Website</label>

                                    <asp:TextBox ID="TextBoxWebsite" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <asp:Button ID="ButtonAddNewLab" runat="server" CssClass="btn btn-primary text-white" OnClick="ButtonAddNewLab_Click" Text="Add Lab" />
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
