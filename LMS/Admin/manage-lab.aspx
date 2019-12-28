<%@ Page Title="Manage Lab" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="manage-lab.aspx.cs" Inherits="LMS.Admin.manage_lab" %>

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
                            <li class="nav-item"><a class="nav-link" href="new-lab"><i class="fas fa-user-alt mr-3"></i>Add New Lab</a></li>
                            <li class="nav-item"><a class="nav-link active" href="manage-lab"><i class="fas fa-list-alt mr-3"></i>Manage Lab</a></li>
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
                        <li class="breadcrumb-item"><a class="btn-link" href="Dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Lab</li>
                    </ol>
                </nav>
                <div id="messagediv" runat="server" visible="false" role="alert" data-wow-duration="10ms" data-wow-delay="30ms">
                    <p id="mesaagetxt" runat="server"></p>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">Manage Lab
                    </h3>
                    <div class="card border-0">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="tablepaging">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>Lab Id</th>
                                            <th>Lab Name</th>
                                            <th>Contact</th>
                                            <th>Status</th>
                                            <th>Validity</th>
                                            <th>Created Date</th>
                                            <th class="no-sort">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="RepeaterLab" runat="server">
                                            <ItemTemplate>

                                                <tr>
                                                    <td><%# Container.ItemIndex+1 %></td>
                                                    <td><%#Eval("LabID") %></td>
                                                    <td><%# Eval("LabName") %></td>
                                                    <td><%#Eval("Mobile") %><br />
                                                        <%#Eval("SecondaryPhone") %></td>
                                                    <td><%# (Boolean.Parse(Eval("Status").ToString())) ? "Active" : "In Active" %></td>
                                                    <td><%#Eval("SubscriptionValidTo","{0:dd MMM yy}") %></td>
                                                    <td><%#Eval("DateCreated","{0:dd MMM yy}") %></td>
                                                    <td>
                                                        <a href="#" data-toggle="modal" data-target="#details<%#Eval("LabID") %>" class="text-success"><i class="fas fa-eye"></i></a>
                                                        <a href="#" data-toggle="modal" data-target="#edit<%#Eval("LabID") %>" class="text-primary"><i class="fas fa-edit"></i></a>
                                                        <div class="modal fade" id="details<%#Eval("LabID") %>" tabindex="-1" role="dialog" aria-labelledby="detailsLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                                <div class="modal-content border-0">
                                                                    <div class="modal-header bg-blue">
                                                                        <h5 class="modal-title text-white" id="detailsLabel"><%# Eval("LabName") %></h5>
                                                                        <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                                                                            <i class="fa fa-times pr-0"></i>
                                                                        </a>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="table-responsive">
                                                                            <table class="table table-borderless table-striped">
                                                                                <tr>
                                                                                    <td>Lab ID</td>
                                                                                    <td>:</td>
                                                                                    <td><%# Eval("LabID") %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Lab Name</td>
                                                                                    <td>:</td>
                                                                                    <td><%# Eval("LabName") %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Owner Name</td>
                                                                                    <td>:</td>
                                                                                    <td><%# Eval("OwnerName") %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Contact Number</td>
                                                                                    <td>:</td>
                                                                                    <td><%#Eval("Mobile") %>,&nbsp; <%#Eval("SecondaryPhone") %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Valid Till</td>
                                                                                    <td>:</td>
                                                                                    <td><%#Eval("SubscriptionValidTo","{0:dd MMM yy}") %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Address</td>
                                                                                    <td>:</td>
                                                                                    <td><%# Eval("Address") %>, &nbsp; <%# Eval("City") %>, &nbsp; <%# Eval("State") %>, &nbsp; <%# Eval("Pincode") %></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>Website</td>
                                                                                    <td>:</td>
                                                                                    <td><%# Eval("Website") %></td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>

                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>
                                                        <!-- Edit Lab -->
                                                        <div class="modal fade" id="edit<%#Eval("LabID") %>" tabindex="-1" role="dialog" aria-labelledby="editLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                                <div class="modal-content border-0">
                                                                    <div class="modal-header bg-blue">
                                                                        <h5 class="modal-title text-white" id="editLabel"><%# Eval("LabName") %></h5>
                                                                        <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                                                                            <i class="fa fa-times pr-0"></i>
                                                                        </a>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <asp:HiddenField ID="HiddenFieldLabId" Value='<%# Eval("LabID") %>' runat="server" />
                                                                        <asp:HiddenField ID="HiddenFieldLogo" Value='<%# Eval("logourl") %>' runat="server" />

                                                                        <div class="form-group">
                                                                            <label for="name">Status <span class="text-danger">*</span></label>
                                                                            <asp:DropDownList ID="DropDownListStatus" CssClass="form-control" SelectedValue='<%#Eval("Status") %>' runat="server" required="">
                                                                                <asp:ListItem Value="True">Active</asp:ListItem>
                                                                                <asp:ListItem Value="False">In Active</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Validity<span class="text-danger">*</span></label>
                                                                            <asp:TextBox ID="TextBoxValidity" runat="server" TextMode="Date" CssClass="form-control" Text='<%#Eval("SubscriptionValidTo", "{0:yyyy-MM-dd}") %>' required=""></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Lab Name <span class="text-danger">*</span></label>
                                                                            <asp:TextBox ID="TextBoxLabName" runat="server" CssClass="form-control" Text='<%# Eval("LabName") %>' required=""></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Owner Name <span class="text-danger">*</span></label>
                                                                            <asp:TextBox ID="TextBoxOwnerName" runat="server" CssClass="form-control" Text='<%# Eval("OwnerName") %>' required=""></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Mobile <span class="text-danger">*</span> (10 digit)</label>
                                                                            <asp:TextBox ID="TextBoxMobile" runat="server" MaxLength="10" CssClass="form-control" Text='<%# Eval("Mobile") %>' required=""></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Phone</label>
                                                                            <asp:TextBox ID="TextBoxPhone" runat="server" MaxLength="12" CssClass="form-control" Text='<%# Eval("SecondaryPhone") %>'></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Email<span class="text-danger">*</span></label>
                                                                            <asp:TextBox ID="TextBoxEmail" runat="server" TextMode="Email" CssClass="form-control" Text='<%# Eval("Email") %>' required=""></asp:TextBox>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="name">State <span class="text-danger">*</span></label>
                                                                            <asp:DropDownList ID="DropDownListState" CssClass="form-control" runat="server" SelectedValue='<%# Eval("State") %>' required="">
                                                                                <asp:ListItem disabled="disabled">Select State</asp:ListItem>
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

                                                                        <div class="form-group">
                                                                            <label for="name">City</label>
                                                                            <asp:TextBox ID="TextBoxCity" runat="server" CssClass="form-control" Text='<%# Eval("City") %>'></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Pincode</label>
                                                                            <asp:TextBox ID="TextBoxPincode" runat="server" CssClass="form-control" Text='<%# Eval("Pincode") %>'></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Address <span class="text-danger">*</span></label>
                                                                            <asp:TextBox ID="TextBoxAddress" runat="server" CssClass="form-control" Text='<%# Eval("Address") %>' required=""></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="FileUploadLogo">Logo</label>
                                                                            <div class="custom-file">
                                                                                <asp:FileUpload ID="FileUploadLogo" runat="server" CssClass="custom-file-input" accept="image/*" />
                                                                                <label class="custom-file-label" for="FileUploadPhotograph">Choose file</label>
                                                                            </div>

                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Website</label>

                                                                            <asp:TextBox ID="TextBoxWebsite" runat="server" CssClass="form-control" Text='<%# Eval("Website") %>'></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <asp:LinkButton ID="LinkButtonUpdateLab" CssClass="btn btn-success" runat="server" OnClick="LinkButtonUpdateLab_Click" OnClientClick="loading()">Update</asp:LinkButton>
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
