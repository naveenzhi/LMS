using System;
using System.Data;

namespace LMS
{
    public partial class Login : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataTable dtlogin = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserId"] != null && Session["UserRole"].ToString() == "0")
            {

                Response.Redirect("Dashboard.aspx");
            }
        }

        protected void LinkButtonLogin_Click(object sender, EventArgs e)
        {
            var continue_url = Request.QueryString["continue_url"];

            string username = TextBoxUsername.Text;
            string password = TextBoxPassword.Text;


            if (username != null && password != null)
            {

                dtlogin = operation.LoginAdmin(username, password);

                if (dtlogin != null)
                {
                    if (dtlogin.Rows.Count > 0)
                    {
                        Session["UserId"] = dtlogin.Rows[0]["UserId"].ToString();
                        Session["UserName"] = dtlogin.Rows[0]["Name"].ToString();
                        Session["Userimg"] = dtlogin.Rows[0]["UserImg"].ToString();
                        Session["UserRole"] = dtlogin.Rows[0]["UserRole"].ToString();

                        if (string.IsNullOrEmpty(continue_url))
                        {
                            continue_url = "Dashboard.aspx";
                        }

                        Response.Redirect(continue_url);


                    }
                    else
                    {
                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Error! Invalid Credential.";
                    }
                }



                else
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Error! Something went wrong. Please try again later.";
                }
            }

            else
            {
                messagediv.Visible = true;
                messagediv.Attributes["class"] = "fixed-message rounded alert bg-warning alert-dismissible animated fadeIn text-center text-white";
                mesaagetxt.InnerHtml = "Please enter username and Password.";
            }
        }
    }
}