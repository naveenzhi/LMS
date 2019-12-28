<%@ Page Title="Report" Language="C#" MasterPageFile="~/Lab/Lab.Master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="LMS.Lab.report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background: #fff !important;
        }
    </style>

    <script src="http://code.jquery.com/jquery-1.5.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#tablereport tr').each(function () {
                $(this).find('td').each(function () {
                    if ($(this).text().trim() == "") {
                        $(this).remove();
                    };
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="accordion" class="sidenav scroll-thin pt-2 d-print-none">
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

            <a href="generate-report.aspx" class="list-group-item list-group-item-action active"><i class="fas fa-file-alt mr-3"></i>Generate Report</a>


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

        <div class="bg-white container-fluid">
            <div class="main-content pt-3">
                <div class="mb-2 text-center d-print-none">
                    <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
                        <button type="button" class="btn btn-secondary" onclick="javascript:window.print();"><i class="fa fa-print"></i></button>
                        <button type="button" class="btn btn-secondary" onclick="javascript:window.print();"><i class="fa  fa-file-pdf"></i></button>
                        <button type="button" class="btn btn-secondary"><i class="fa fa-envelope"></i></button>
                    </div>
                </div>
                <div id="print-invoice" class="card card-body rounded-new m-3">

                    <table id="tablereport" class="table table-borderless">
                        <thead class="bg-light">
                            <tr>
                                <th colspan="3">
                                    <asp:Panel ID="PanelHeader" runat="server" Visible="false">
                                        <asp:Label ID="LabelHeader" runat="server"></asp:Label>
                                    </asp:Panel>
                                </th>
                            </tr>

                            <tr>
                                <th colspan="3">
                                    <div class="row">
                                        <div class="col-6 my-1">
                                            <div class="d-flex">
                                                <div>Patient Name</div>
                                                <div class="mx-2">:</div>
                                                <div>
                                                    <asp:Label ID="LabelPatientName" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 my-1">
                                            <div class="d-flex">
                                                <div>Invoice #</div>
                                                <div class="mx-2">:</div>
                                                <div>
                                                    <asp:Label ID="LabelOrderNo" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 my-1">
                                            <div class="d-flex">
                                                <div style="margin-right: 32px;">Address</div>
                                                <div class="mx-2">:</div>
                                                <div>
                                                    <asp:Label ID="LabelAddress" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 my-1">
                                            <div class="d-flex">
                                                <div style="margin-right: 27px;">Date</div>
                                                <div class="mx-2">:</div>
                                                <div>
                                                    <asp:Label ID="LabelOrderDate" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 my-1">
                                            <div class="d-flex">
                                                <div style="margin-right: 24px;">Age / Sex</div>
                                                <div class="mx-2">:</div>
                                                <div>
                                                    <asp:Label ID="LabelAge" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 my-1">
                                            <div class="d-flex">
                                                <div style="margin-right: 18px;">Phone</div>
                                                <div class="mx-2">:</div>
                                                <div>
                                                    <asp:Label ID="LabelPhone" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 my-1">
                                            <div class="d-flex">
                                                <div style="margin-right: 37px;">Ref. By</div>
                                                <div class="mx-2">:</div>
                                                <div>
                                                    <asp:Label ID="LabelReferredBy" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 my-1">
                                            <div class="d-flex">
                                                <div style="margin-right: 24px;">Email</div>
                                                <div class="mx-2">:</div>
                                                <div>
                                                    <asp:Label ID="LabelEmail" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-6 my-1">
                                            <div class="d-flex">
                                                <div style="margin-right: 38px;">Ref. To</div>
                                                <div class="mx-2">:</div>
                                                <div>
                                                    <asp:Label ID="LabelReferredTo" runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        
                                        
                                    </div>
                                    
                                </th>
                                
                            </tr>

                        </thead>

                        <tbody>

                            <tr>
                                <td colspan="3">
                                    <asp:Label ID="LabelReportNotes" CssClass="ml-1 mb-auto" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr class="bg-white">
                                <td><strong>Test Name</strong></td>
                                <td><strong>Result</strong></td>
                                <td><strong>Biological Ref Range</strong></td>
                            </tr>
                            <asp:Repeater ID="RepeaterLabPatientTest" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td colspan="3">
                                            <asp:Label ID="LabelTestGroup" CssClass="font-weight-bold mb-auto" Text='<%# Eval("TestGroup")%>' runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <asp:Repeater ID="RepeaterLabPatientTestInner" runat="server" DataSource='<%# Eval("Test") %>'>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%#Eval("TestName") %>
                                                </td>

                                                <td><%#Eval("Result") %></td>

                                                <td><%#Eval("NormalRange") %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ItemTemplate>
                            </asp:Repeater>

                            <tr>

                                <td colspan="3" class="text-center">
                                    <br />
                                    <br />
                                    <b>*** End Of Report ***</b></td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-right">
                                    <br />
                                    <br />
                                    <br />
                                    <br />
                                    <small>Authorised Signatory</small></td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3">
                                    <asp:Panel ID="PanelFooter" runat="server" Visible="false">
                                        <span class="d-none">..</span><asp:Label ID="LabelFooter" runat="server">
                                        </asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </tfoot>

                    </table>
                </div>
            </div>
        </div>
        <div class="bg-white card card-body d-print-none">
            <p>© 2019 All Rights Reserved. Powered by <a href="http://www.triopod.in/" class="text-dark" target="_blank">Triopod Technology</a><span class="float-right">lms version 1.1</span></p>
        </div>

    </div>


</asp:Content>
