<%@ Page Title="Patient" Language="C#" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="patient.aspx.cs" Inherits="LMS.Lab.patient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="accordion" class="sidenav scroll-thin pt-2">
        <div class="list-group list-group-flush">
            <a href="Dashboard.aspx" class="list-group-item list-group-item-action"><i class="fa fa-tachometer-alt mr-3"></i>Dashboard</a>
            <div class="accordion-title">
                <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapsepatient" role="button" aria-expanded="true" aria-controls="collapsepatient"><i class="fas fa-users mr-3"></i>Patient</a>
            </div>
            <div class="collapse show animated fadeInLeft" id="collapsepatient" data-parent="#accordion">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="new-patient"><i class="fas fa-user-alt mr-3"></i>Add New Patient</a></li>
                    <li class="nav-item"><a class="nav-link active" href="patient"><i class="fas fa-list-alt mr-3"></i>Manage Patient</a></li>
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
                    <ol class="breadcrumb bg-white rounded align-items-center">
                        <li class="breadcrumb-item"><a class="btn-link" href="Dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Patient</li>
                    </ol>
                </nav>
                <div id="messagediv" runat="server" visible="false" role="alert" data-wow-duration="10ms" data-wow-delay="30ms">
                    <p id="mesaagetxt" runat="server"></p>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">Patient List
                    </h3>
                    <div class="card border-0">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="tablepaging">
                                    <thead class="thead-light">
                                        <tr>
                                            <th>Id</th>
                                            <th>Name</th>
                                            <th>Mobile</th>
                                            <th>Gender</th>

                                            <th>Address</th>
                                            <th>Created Date</th>
                                            <th class="no-sort">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="RepeaterPatient" runat="server">
                                            <ItemTemplate>

                                                <tr>

                                                    <td><%#Eval("PatientID") %></td>
                                                    <td><%#Eval("NAME") %></td>
                                                    <td><%#Eval("MOBILE") %></td>
                                                    <td><%#Eval("SEX") %></td>

                                                    <td><%# Eval("Address") %> <%# Eval("City") %></td>
                                                    <td><%#Eval("DateCreated", "{0:dd MMM yyyy}") %></td>
                                                    <td>

                                                        <div class="dropdown">

                                                            <a href="#" class="no-toggle dropdown-toggle" data-toggle="dropdown">
                                                                <i class="fas fa-ellipsis-v"></i>
                                                            </a>
                                                            <div class="dropdown-menu">
                                                                <a href="new-order?pid=<%#Eval("PatientID") %>" class="dropdown-item">New Order</a>
                                                                <a href="#" data-toggle="modal" data-target="#edit<%#Eval("PatientID") %>" class="text-primary dropdown-item">Edit</a>
                                                                <a href="#?PatientID=<%#Eval("PatientID") %>" class="dropdown-item">View Details</a>
                                                                <a href="patient-order?pid=<%#Eval("PatientID") %>" class="dropdown-item">View Order</a>
                                                            </div>
                                                        </div>

                                                        <div class="modal fade" id="edit<%#Eval("PatientID") %>" tabindex="-1" role="dialog" aria-labelledby="editLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                                <div class="modal-content border-0">
                                                                    <div class="modal-header bg-blue">
                                                                        <h5 class="modal-title text-white" id="editLabel"><%#Eval("NAME") %></h5>
                                                                        <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                                                                            <i class="fa fa-times pr-0"></i>
                                                                        </a>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <asp:HiddenField ID="HiddenFieldPatientID" Value='<%#Eval("PatientID") %>' runat="server" />

                                                                        <div class="form-group">
                                                                            <label>Age <span class="text-danger">*</span></label>
                                                                            <div class="input-group">
                                                                                <asp:TextBox ID="TextBoxAge" runat="server" TextMode="Number" min="0" CssClass="form-control" required="" Text='<%#Eval("Age") %>'></asp:TextBox>
                                                                                <div class="input-group-append">
                                                                                    <asp:DropDownList ID="DropDownListAgeType" CssClass="input-group-text bg-white" runat="server" required="" SelectedValue='<%#Eval("AgeType") %>'>
                                                                                        <asp:ListItem Value="Year">Year</asp:ListItem>
                                                                                        <asp:ListItem Value="Month">Month</asp:ListItem>
                                                                                        <asp:ListItem Value="Day">Day</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="TextBoxMobile">Mobile <span class="text-danger">*</span></label>
                                                                            <asp:TextBox ID="TextBoxMobile" runat="server" MaxLength="10" CssClass="form-control" required="" Text='<%#Eval("Mobile") %>'></asp:TextBox>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="name">Email</label>
                                                                            <asp:TextBox ID="TextBoxEmail" runat="server" TextMode="Email" CssClass="form-control" Text='<%#Eval("Email") %>'></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="name">Aadhar</label>
                                                                            <asp:TextBox ID="TextBoxAadhar" runat="server" MaxLength="12" CssClass="form-control" Text='<%#Eval("Aadhar") %>'></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>State</label>
                                                                            <asp:DropDownList ID="State" runat="server" CssClass="form-control" SelectedValue='<%#Eval("State") %>'>
                                                                                <asp:ListItem Value="" disabled="disabled">Select State</asp:ListItem>
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
                                                                            <label for="TextBoxcity">City</label>
                                                                            <asp:TextBox ID="TextBoxcity" runat="server" CssClass="form-control" Text='<%#Eval("City") %>'></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="TextBoxpincode">Pincode</label>
                                                                            <asp:TextBox ID="TextBoxpincode" runat="server" CssClass="form-control" TextMode="Number" Text='<%#Eval("Pincode") %>'></asp:TextBox>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="TextBoxaddress">Address</label>
                                                                            <asp:TextBox ID="TextBoxaddress" runat="server" CssClass="form-control" Text='<%#Eval("Address") %>' TextMode="MultiLine" Rows="2" required=""></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <asp:Button ID="ButtonUpdateRecord" runat="server" CssClass="btn btn-success text-white" Text="Save" OnClientClick="loading()" />
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
    </div>
</asp:Content>
