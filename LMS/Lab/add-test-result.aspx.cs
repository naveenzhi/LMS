using System;
using System.Data;

namespace LMS.Lab
{
    public partial class add_test_result : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataSet dsorder = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {

            }
        }

    }
}