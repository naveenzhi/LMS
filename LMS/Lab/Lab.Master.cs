using System;
using System.Web;

namespace LMS.Lab
{
    public partial class Lab : System.Web.UI.MasterPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserId"] == null)
            {
                string continue_url = HttpContext.Current.Request.Url.AbsoluteUri;
                Response.Redirect("Login.aspx?continue_url=" + continue_url);
            }

            else
            {
                if (Session["UserRole"].ToString() != "2")
                {
                    Response.Redirect("/index.aspx");
                }
            }



            if (!IsPostBack)
            {
                LabelValidity.Text = String.Format("{0:dd MMM yyyy}", Session["LabValidity"]);
                LabelLabId.Text = Session["LabId"].ToString();
                ImageUser.ImageUrl = Session["Userimg"].ToString();
                username.InnerHtml = Session["UserName"].ToString();
                ImageLab.ImageUrl = Session["LabLogo"].ToString();
                LabelLabName.Text = Session["LabName"].ToString();
            }


        }

        protected void btnlogout_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/Lab/Login.aspx");
        }
    }
}