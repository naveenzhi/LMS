<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LMS.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <link href="Content/css/bootstrap.css" rel="stylesheet" />

    <link href="Content/css/fontawesome.css" rel="stylesheet" />

    <link href="Content/css/animate.min.css" rel="stylesheet" />
    <link href="Content/css/main.css" rel="stylesheet" />
    <link id="favicon" rel="shortcut icon" href="/images/favicon.png" type="image/png" />
    
    <link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet" />
    <style>
        body, html {
            height: 100%;
        }

        .bg {
            background: url("/images/login-bg.jpg") no-repeat center;
            background-size: cover;
        }

        .bg-login {
            background: rgba(0, 0, 0, 0.60);
            color: #fff;
        }
    </style>

</head>
<body class="bg">
    <form id="form1" runat="server" defaultbutton="LinkButtonLogin" defaultfocus="TextBoxUsername">
        <div class="container">
            <br />
            <div class="col-lg-4 mx-auto">


                <div class="text-center mt-3">
                    <img src="/images/logo.png" class="rounded-circle bg-white p-2" height="80" alt="" />
                </div>
                <div class="bg-white rounded-new p-4 mt-3">
                    <p class="font-weight-bold mb-3">Login</p>
                    <div id="messagediv" runat="server" visible="false">
                        <p id="mesaagetxt" runat="server"></p>
                    </div>
                    <div class="form-group mb-4">
                        <label for="username" class="mb-2">Username</label>
                        <asp:TextBox ID="TextBoxUsername" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group mb-4">
                        <label for="password" class="mb-2">Password</label>
                        <asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:LinkButton ID="LinkButtonLogin" runat="server" CssClass="btn btn-primary text-white btn-block mb-4" OnClick="LinkButtonLogin_Click" OnClientClick="loading()">Login</asp:LinkButton>
                    <a href="#" class="text-danger mt-5" data-toggle="modal" data-target="#forgotpassword" data-backdrop="static">Forgot Password?</a>
                </div>


            </div>
        </div>
        <!-- Forgot Password Modal -->
        <div class="modal fade" id="forgotpassword" tabindex="-1" role="dialog" aria-labelledby="forgotpasswordTitle" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="forgotpasswordTitle">Forgot Password</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true" class="text-white">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Fogotmessagediv" runat="server" visible="false">
                            <p id="Fogotmessagetxt" runat="server"></p>
                        </div>
                        <div class="form-group">
                            <label for="password">User_Id</label>
                            <input type="text" name="textforgotuserid" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label for="password">Registered Email</label>
                            <input type="email" name="textforgotemail" class="form-control" />
                        </div>
                    </div>
                    <div class="modal-footer text-right">
                        <input id="btnforgotpassword" type="button" runat="server" class="btn btn-success" value="Submit" />
                    </div>
                </div>
            </div>
        </div>

        <script src="Content/js/popper.min.js"></script>
        <script src="Content/js/jquery-3.3.1.min.js"></script>
        <script src="Content/js/jquery.easing.1.3.js"></script>
        <script src="Content/js/bootstrap.min.js"></script>

        <script src="Content/js/Script.js" type="text/javascript"></script>

        <script src="Content/js/wow.min.js"></script>
    </form>
</body>
</html>
