using System;
using System.Data;

namespace LMS.Lab
{
    public partial class Dashboard : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();

        string LabId;
        DataSet dscount;
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                if (Session["LabId"] != null)
                {
                    LabId = Session["LabId"].ToString();
                    dscount = operation.BindDashboard(LabId);

                    if (dscount != null)
                    {
                        LabelTotalPatient.Text = dscount.Tables[0].Rows[0][0].ToString();
                        LabelTodayTest.Text = dscount.Tables[1].Rows[0][0].ToString();

                        LabelTodayPatient.Text = dscount.Tables[2].Rows[0][0].ToString();
                        LabelYesterdayTest.Text = dscount.Tables[3].Rows[0][0].ToString();
                        LabelWeeklyTest.Text = dscount.Tables[4].Rows[0][0].ToString();
                        LabelMonthlyTest.Text = dscount.Tables[5].Rows[0][0].ToString();
                    }

                }
            }
        }
    }
}