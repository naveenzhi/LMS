using System;
using System.Data;

namespace LMS.Lab
{
    public partial class patient : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataTable dtpatientlist = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                patientlist();
            }
        }

        protected void patientlist()
        {
            if (Session["LabId"] != null)
            {
                dtpatientlist = operation.PatientList(Session["LabId"].ToString());

                if (dtpatientlist != null)
                {
                    RepeaterPatient.DataSource = dtpatientlist;
                    RepeaterPatient.DataBind();
                }
            }


        }
    }
}