using System;
using System.Data;
using System.Web.UI.WebControls;

namespace LMS.Lab
{
    public partial class edit_report : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (Session["LabId"] != null && Request.QueryString["oid"] != null)
                {
                    string LabId = Session["LabId"].ToString();
                    string OrderId = Request.QueryString["oid"].ToString();

                    DataTable dtresult = operation.GetTestResult(OrderId, LabId);

                    if (dtresult != null)
                    {
                        RepeaterTestResult.DataSource = dtresult;
                        RepeaterTestResult.DataBind();
                    }

                }
            }
        }

        protected void LinkButtonUpdateResult_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;

            if (Session["LabId"] != null)
            {
                DataTable dttestresult = new DataTable();
                dttestresult.Columns.AddRange(new DataColumn[2] {
                    new DataColumn("ReportID", typeof(string)),
                    new DataColumn("Result", typeof(string)) });

                Label LabelOrderId = (Label)button.FindControl("LabelOrderId");

                TextBox TextBoxReportNotes = (TextBox)button.FindControl("TextBoxReportNotes");

                foreach (RepeaterItem TestResult in RepeaterTestResult.Items)
                {

                    HiddenField HiddenFieldReportId = TestResult.FindControl("HiddenFieldReportId") as HiddenField;
                    TextBox TextBoxResult = TestResult.FindControl("TextBoxResult") as TextBox;

                    if (TextBoxResult.Text == "")
                    {
                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Error! Result field cannot be blank.";

                    }
                    else
                    {
                        dttestresult.Rows.Add(HiddenFieldReportId.Value, TextBoxResult.Text);
                    }


                }



                if (dttestresult.Rows.Count > 0)
                {
                    string response = operation.UpdateTestResult(dttestresult);

                    if (response == "SUCCESS")
                    {

                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Success! Result saved.";
                        dttestresult = null;
                    }

                    else if (response == "ERROR")
                    {
                        dttestresult = null;
                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Error! Test result not saved.";
                    }
                }
            }
        }
    }
}