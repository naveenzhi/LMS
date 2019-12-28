using System;
using System.Data;

namespace LMS.Lab
{
    public partial class patient_order : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataTable dtorder = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                PatientOrder();
            }
        }

        protected void PatientOrder()
        {
            if (Session["LabId"] != null && Request.QueryString["pid"] != null)
            {
                dtorder = operation.PatientOrder(Session["LabId"].ToString(), Request.QueryString["pid"].ToString());

                if (dtorder != null)
                {
                    RepeaterOrder.DataSource = dtorder;
                    RepeaterOrder.DataBind();
                }
            }
        }
    }
}