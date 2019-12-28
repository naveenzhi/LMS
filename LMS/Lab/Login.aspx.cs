using System;
using System.Data;

namespace LMS.Lab
{
    public partial class Login : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataTable dtlogin = new DataTable();
        DateTime LabValidity;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserId"] != null && Session["UserRole"].ToString() == "2")
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

                dtlogin = operation.Login(username, password, 2);

                if (dtlogin != null)
                {
                    if (dtlogin.Rows.Count > 0)
                    {
                        Session["LabId"] = dtlogin.Rows[0]["LabID"].ToString();
                        Session["LabName"] = dtlogin.Rows[0]["LabName"].ToString();
                        Session["LabLogo"] = dtlogin.Rows[0]["LogoUrl"].ToString();
                        LabValidity = Convert.ToDateTime(dtlogin.Rows[0]["SubscriptionValidTo"].ToString());
                        Session["LabValidity"] = LabValidity;
                        Session["UserId"] = dtlogin.Rows[0]["UserId"].ToString();
                        Session["UserName"] = dtlogin.Rows[0]["Name"].ToString();
                        Session["Userimg"] = dtlogin.Rows[0]["UserImg"].ToString();
                        Session["UserRole"] = dtlogin.Rows[0]["UserRole"].ToString();

                        if (string.IsNullOrEmpty(continue_url))
                        {
                            continue_url = "Dashboard.aspx";
                        }

                        if (LabValidity < DateTime.Now)
                        {
                            Session.Abandon();
                            Response.Redirect("~/Lab/renew.aspx");
                        }
                        else
                        {
                            Response.Redirect(continue_url);
                        }


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