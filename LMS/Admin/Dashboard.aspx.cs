using System;
using System.Data;

namespace LMS.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataSet dscount;
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                if (Session["UserId"] != null)
                {
                    dscount = operation.BindAdminDashboard();

                    if (dscount != null)
                    {
                        LabelTotalLab.Text = dscount.Tables[0].Rows[0][0].ToString();
                        LabelActiveLab.Text = dscount.Tables[1].Rows[0][0].ToString();
                        LabelInactiveLab.Text = dscount.Tables[2].Rows[0][0].ToString();
                        LabelTodayLab.Text = dscount.Tables[3].Rows[0][0].ToString();
                        LabelYesterdayLab.Text = dscount.Tables[4].Rows[0][0].ToString();
                        LabelWeeklyLab.Text = dscount.Tables[5].Rows[0][0].ToString();
                        LabelMonthlyLab.Text = dscount.Tables[6].Rows[0][0].ToString();
                    }

                }
            }
        }
    }
}