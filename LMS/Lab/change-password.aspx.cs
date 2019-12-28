using System;

namespace LMS.Lab
{
    public partial class change_password : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void ButtonChangePassword_Click(object sender, EventArgs e)
        {

            if (TextBoxNewPassword.Text != "" && TextBoxCurrentPassword.Text != "")
            {
                string response = operation.changepassword(Session["UserId"].ToString(), TextBoxCurrentPassword.Text, TextBoxNewPassword.Text);

                if (response == "SUCCESS")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Success! Password changed Successfully.";
                    Session["UserId"] = null;
                }
                else if (response == "INVALID")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Error! Invalid current password.";
                }
                else if (response == "ERROR")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Error! something went wrong please try again later.";
                }
            }
            else
            {
                messagediv.Visible = true;
                messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                mesaagetxt.InnerHtml = "Error! Please fill all field.";
            }


        }
    }
}