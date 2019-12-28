using System;

namespace LMS
{
    public partial class Site : System.Web.UI.MasterPage
    {
        //DBOperations operation = new DBOperations();
        //DataTable dtnotice = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {

            }
        }
    }
}