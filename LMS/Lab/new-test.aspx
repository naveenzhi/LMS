<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="new-test.aspx.cs" Inherits="LMS.Lab.new_test" %>

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
                    <li class="nav-item"><a class="nav-link active" href="new-test"><i class="fas fa-user-plus mr-3"></i>Add New Test</a></li>
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
                        <li class="breadcrumb-item"><a class="btn-link" href="test">Test</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Add Test</li>
                    </ol>
                </nav>
                <div id="messagediv" runat="server" visible="false" role="alert" data-wow-duration="10ms" data-wow-delay="30ms">
                    <p id="mesaagetxt" runat="server"></p>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="bg-white rounded-new mt-4">
                    <h3 class="head-title">Add New Test
                    </h3>
                    <div class="card border-0">
                        <div class="card-body">
                            <div class="form-check-inline mb-4">
                                <label class="form-check-label">
                                    <asp:CheckBox ID="CheckBoxClubTest" CssClass="form-check-input" Text="Make Club Test" runat="server" OnCheckedChanged="CheckBoxClubTest_CheckedChanged" AutoPostBack="true" />
                                </label>

                            </div>
                            <div class="form-row">

                                <div class="col-md-6 mb-3">
                                    <label>Test Group<span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <asp:DropDownList ID="DropDownListTestGroup" runat="server" CssClass="form-control" OnSelectedIndexChanged="DropDownListTestGroup_SelectedIndexChanged" AutoPostBack="true">
                                        </asp:DropDownList>
                                        <div class="input-group-append">
                                            <span class="input-group-text bg-white"><a href="#" data-toggle="modal" data-target="#testgroupmodal"><i class="fa fa-plus-circle"></i></a></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label>
                                        <asp:CheckBox ID="CheckBoxsubgroup" Text="Sub Group" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBoxsubgroup_CheckedChanged" /></label>
                                    <div class="input-group">
                                        <asp:DropDownList ID="DropDownListTestSubGroup" runat="server" CssClass="form-control" AutoPostBack="true" Enabled="false">
                                        </asp:DropDownList>
                                        <div class="input-group-append">
                                            <span class="input-group-text bg-white"><a href="#" data-toggle="modal" data-target="#testsubgroupmodal"><i class="fa fa-plus-circle"></i></a></span>

                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Test Name<span class="text-danger">*</span></label>
                                    <asp:TextBox ID="TextBoxTestName" CssClass="form-control" required="" runat="server"></asp:TextBox>
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Test Sort Name</label>
                                    <asp:TextBox ID="TextBoxTestSortName" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Test Price<span class="text-danger">*</span></label>
                                    <asp:TextBox ID="TextBoxPrice" CssClass="form-control" TextMode="Number" min="0" required="" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label>Normal Range</label>
                                    <asp:TextBox ID="TextBoxNormalRange" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Default Result</label>
                                    <asp:TextBox ID="TextBoxDefaultResult" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>

                                <!-- Bind Available Test -->

                                <div id="divtest" runat="server" class="col-md-12 mb-3" visible="False">
                                    <div class="card">
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
                                                            <th>Category</th>
                                                            <th>Type</th>
                                                            <th>Display Order</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Repeater ID="RepeaterTest" runat="server">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <asp:HiddenField ID="ClubName" Value='<%#Eval("TestName") %>' runat="server" />
                                                                        <asp:HiddenField ID="HiddenTestId" Value='<%#Eval("TestID") %>' runat="server" />
                                                                        <asp:HiddenField ID="HiddenIsClubTest" Value='<%#Eval("IsClubTest") %>' runat="server" />
                                                                        <asp:CheckBox ID="CheckBoxTest" runat="server" CssClass="CheckBoxTest" />
                                                                    </td>
                                                                    <td><%#Eval("TestName") %></td>
                                                                    <td><%#Eval("Name") %></td>
                                                                    <td><%# (Boolean.Parse(Eval("isclubtest").ToString())) ? "Club Test" : "Single Test" %></td>
                                                                    <td>
                                                                        <asp:TextBox ID="TextBoxTestDisplayOrder" runat="server" CssClass="form-control w-25" TextMode="Number" min="1"></asp:TextBox>
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
                                <!-- // Bind Available Lab Test -->
                            </div>
                            <asp:Button ID="ButtonAddTest" runat="server" CssClass="w-25 btn btn-success btn-rad text-white" Text="Save" OnClick="ButtonAddTest_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    <div class="bg-white card card-body mt-3">
        <p>© 2019 All Rights Reserved. Powered by <a href="http://www.triopod.in/" class="text-dark" target="_blank">Triopod Technology</a><span class="float-right">lms version 1.1</span></p>
    </div>
    </div>

    <!-- Test Group Modal -->
    <div class="modal fade" id="testgroupmodal">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header bg-blue">
                    <h5 class="modal-title text-white">Add Group</h5>
                    <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                        <i class="fa fa-times pr-0"></i>
                    </a>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Test Group</label>
                        <asp:TextBox ID="TextBoxGroupName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:LinkButton ID="LinkButtonAddGroup" CssClass="btn btn-success" runat="server" OnClick="LinkButtonAddGroup_Click">Save</asp:LinkButton>
                </div>



            </div>
        </div>
    </div>
    <!-- Test SubGroup Modal -->
    <div class="modal fade" id="testsubgroupmodal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-blue">
                    <h5 class="modal-title text-white">Add Sub Group</h5>
                    <a href="#" class="btn-sm btn-danger" data-dismiss="modal" aria-label="Close">
                        <i class="fa fa-times pr-0"></i>
                    </a>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label>Test Group</label>
                        <asp:DropDownList ID="DropDownListModalGroup" CssClass="form-control" runat="server"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Sub Group Name</label>
                        <asp:TextBox ID="TextBoxSubGroupName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:LinkButton ID="LinkButtonAddSubGroup" CssClass="btn btn-success" runat="server" OnClick="LinkButtonAddSubGroup_Click">Save</asp:LinkButton>
                </div>


            </div>
        </div>
    </div>
</asp:Content>
