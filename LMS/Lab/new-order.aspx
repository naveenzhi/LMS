<%@ Page Title="New Order" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="new-order.aspx.cs" Inherits="LMS.Lab.new_order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script>


        $(document).ready(function () {


            var $checkboxes = $(".CheckBoxTest");
            $checkboxes.change(function () {

                calculateTotal();

            });

            //Calculate Test Price On Text change

            $('.TextBoxTestPrice').on("change paste keyup", function () {
                calculateTotal();
            });

            $('#TextBoxPaid').on("change paste keyup", function () {
                $("#TextBoxDues").val(Number($("#TextBoxTotalAmount").val()) - Number($("#TextBoxPaid").val()));
            });
            $('#TextBoxDiscount').on("change paste keyup", function () {
                $("#TextBoxPaid").val(Number($("#TextBoxTotalAmount").val()) - Number($("#TextBoxDiscount").val()));
            });


        });

        function calculateTotal() {
            var total = 0;
            $(".CheckBoxTest:checked").each(function () {

                var val = parseFloat($(this).parents("tr").find('.TextBoxTestPrice').val());
                total += val;
            });

            $('input[name="TextBoxTotalAmount"]').val(total);
            $('input[name="TextBoxPaid"]').val(total);

        }

    </script>
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
                <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapseorder" role="button" aria-expanded="true" aria-controls="collapseorder"><i class="fab fa-first-order mr-3"></i>Order</a>
            </div>
            <div class="collapse show animated fadeInLeft" id="collapseorder" data-parent="#accordion">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link active" href="new-order"><i class="fas fa-procedures mr-3"></i>New Order</a></li>
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
                        <li class="breadcrumb-item"><a class="btn-link" href="Dashboard.aspx">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">New Order</li>
                    </ol>
                </nav>
                <div id="messagediv" runat="server" visible="false" role="alert" data-wow-duration="10ms" data-wow-delay="30ms">
                    <p id="mesaagetxt" runat="server"></p>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">New Order
                    </h3>
                    <div class="card border-0">
                        <div class="card-body">
                            <div class="form-row mb-4">
                                <div class="col-md-4 mb-3">
                                    <asp:DropDownList ID="DropDownListPatient" runat="server" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="DropDownListPatient_SelectedIndexChanged"></asp:DropDownList>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-white">Dr.</span>
                                        </div>
                                        <asp:DropDownList ID="DropDownListDoctor" runat="server" CssClass="custom-select select2"></asp:DropDownList>
                                        <div class="input-group-append">
                                            <button class="btn btn-success" type="button" data-toggle="modal" data-target="#adddoctormodal"><i class="fa fa-plus-circle"></i></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <div class="input-group">
                                        <asp:DropDownList ID="DropDownListTestCenter" runat="server" CssClass="custom-select select2"></asp:DropDownList>
                                        <div class="input-group-append">
                                            <button class="btn btn-success" type="button" data-toggle="modal" data-target="#addtestcentermodal"><i class="fa fa-plus-circle"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="DivPatientDetails" runat="server" visible="false">
                                <div class="form-row jumbotron p-3">
                                    <asp:Repeater ID="RepeaterPatientDetails" runat="server">

                                        <ItemTemplate>
                                            <div class="col-lg-3 mb-3">
                                                Patient ID: <%#Eval("PatientID") %>
                                            </div>
                                            <div class="col-lg-3 mb-3">
                                                Patient Name: <%#Eval("Title") %>. <%#Eval("Name") %>
                                            </div>
                                            <div class="col-lg-3 mb-3">
                                                Age: <%#Eval("Age") %>&nbsp;<%#Eval("AgeType") %>
                                            </div>
                                            <div class="col-lg-3 mb-3">
                                                Sex:<%#Eval("Sex") %>
                                            </div>
                                            <div class="col-lg-3 mt-3">
                                                Email: <%#Eval("Email") %>
                                            </div>
                                            <div class="col-lg-3 mt-3">
                                                Mobile: <%#Eval("Mobile") %>
                                            </div>
                                            <div class="col-lg-6 mt-3">
                                                Address: <%#Eval("Address") %> &nbsp;<%#Eval("City") %>&nbsp;<%#Eval("State") %>&nbsp;<%#Eval("Pincode") %>
                                            </div>

                                        </ItemTemplate>

                                    </asp:Repeater>
                                </div>
                                <div class="card mt-2">
                                    <div class="card-header d-lg-flex justify-content-between">
                                        <div class="d-inline-block align-middle h5 mt-2">Choose Test</div>
                                        <div class="btn-group">
                                            <input id="inputsearchtest" type="text" class="form-control" placeholder="Search Test" />
                                        </div>

                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover" id="filtertest">
                                                <thead>
                                                    <tr>
                                                        <th>&nbsp;</th>
                                                        <th>Test Name</th>
                                                        <th>Type</th>
                                                        <th>Price</th>
                                                    </tr>
                                                </thead>
                                                <tbody">
                                                    <asp:Repeater ID="RepeaterTest" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <asp:HiddenField ID="HiddenTestId" Value='<%#Eval("TestID") %>' runat="server" />
                                                                    <asp:HiddenField ID="HiddenIsClubTest" Value='<%#Eval("IsClubTest") %>' runat="server" />
                                                                    <input id="CheckBoxTest" class="CheckBoxTest" runat="server" type="checkbox" value='<%#Eval("Price") %>' />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="LabelTestName" runat="server" Text='<%#Eval("TestName") %>'></asp:Label><%#Eval("TestSortName") %></td>
                                                                <td><%# (Boolean.Parse(Eval("isclubtest").ToString())) ? "Club Test" : "Single Test" %></td>
                                                                <td>
                                                                    <asp:TextBox ID="TextBoxTestPrice" runat="server" CssClass="TextBoxTestPrice form-control" TextMode="Number" Text='<%#Eval("Price") %>'></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row mt-4">
                                    <div class="col-md-3">
                                        <label>Total Amount (₹)</label>
                                        <input type="number" id="TextBoxTotalAmount" name="TextBoxTotalAmount" value="0" readonly="" class="form-control" />
                                    </div>
                                    <div class="col-md-3">
                                        <label>Discount</label>
                                        <input type="number" id="TextBoxDiscount" name="TextBoxDiscount" value="0" class="form-control" />
                                    </div>
                                    <div class="col-md-3">
                                        <label>Paid</label>
                                        <input type="number" id="TextBoxPaid" name="TextBoxPaid" class="form-control" />
                                    </div>
                                    <div class="col-md-3">
                                        <label>Dues</label>
                                        <input type="number" id="TextBoxDues" name="TextBoxDues" value="0" readonly="" class="form-control" />
                                    </div>
                                </div>
                                <asp:LinkButton ID="LinkButtonNewOrder" runat="server" CssClass="btn btn-primary btn-rad mt-4" OnClick="LinkButtonNewOrder_Click" OnClientClick="loading()">Order Now</asp:LinkButton>
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

    <!-- Modal Add Doctor-->
    <div class="modal fade" id="adddoctormodal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-blue">
                    <h5 class="modal-title text-white" id="AddDoctorLabel">Add Doctor</h5>
                    <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                        <i class="fa fa-times pr-0"></i>
                    </a>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label>Doctor Name <span class="text-danger">*</span></label>
                        <asp:TextBox ID="TextBoxDoctorName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Degree <span class="text-danger">*</span></label>
                        <asp:TextBox ID="TextBoxDegree" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>City <span class="text-danger">*</span></label>
                        <asp:TextBox ID="TextBoxCity" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:LinkButton ID="LinkButtonAddDoctor" CssClass="btn btn-success" runat="server" OnClick="LinkButtonAddDoctor_Click" OnClientClick="loading()">Save</asp:LinkButton>
                </div>



            </div>
        </div>
    </div>

    <!-- Modal Add Test Center -->
    <div class="modal fade" id="addtestcentermodal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-blue">
                    <h5 class="modal-title text-white" id="addtestcenterLabel">Add Doctor</h5>
                    <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                        <i class="fa fa-times pr-0"></i>
                    </a>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label>Center Name <span class="text-danger">*</span></label>
                        <asp:TextBox ID="TextBoxCenterName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Center Code <span class="text-danger">*</span></label>
                        <asp:TextBox ID="TextBoxCenterCode" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:LinkButton ID="LinkButtonAddTestCenter" CssClass="btn btn-success" runat="server" OnClick="LinkButtonAddTestCenter_Click" OnClientClick="loading()">Save</asp:LinkButton>
                </div>



            </div>
        </div>
    </div>
</asp:Content>
