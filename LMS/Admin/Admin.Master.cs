using System;
using System.Web;

namespace LMS.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
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
                if (Session["UserRole"].ToString() != "0")
                {
                    Response.Redirect("/index.aspx");
                }
            }



            if (!IsPostBack)
            {

                ImageUser.ImageUrl = Session["Userimg"].ToString();
            }


        }

        protected void btnlogout_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/Admin/Login.aspx");
        }
    }
}