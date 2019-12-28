using System;
using System.Data;
using System.Web.UI.WebControls;

namespace LMS.Lab
{
    public partial class add_result : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataSet dsorder = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Order();
            }
        }

        protected void Order()
        {
            if (Session["LabId"] != null)
            {
                dsorder = operation.GetOrderReportNotGenerated(Session["LabId"].ToString());

                if (dsorder != null)
                {
                    dsorder.Relations.Add(new DataRelation("OrderedTest", dsorder.Tables[0].Columns["OrderID"], dsorder.Tables[1].Columns["OrderID"], false));
                    dsorder.Relations.Add(new DataRelation("OrderedAllTest", dsorder.Tables[0].Columns["OrderID"], dsorder.Tables[2].Columns["OrderID"], false));

                    RepeaterOrder.DataSource = dsorder;
                    RepeaterOrder.DataBind();
                }
            }
        }

        protected void RepeaterOrder_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataRowView dvTest = e.Item.DataItem as DataRowView;
            DataRowView DVAllTest = e.Item.DataItem as DataRowView;

            if (dvTest != null && DVAllTest != null)
            {
                Repeater RepeaterOrderTest = e.Item.FindControl("RepeaterOrderTest") as Repeater;
                Repeater RepeaterOrderAllTest = e.Item.FindControl("RepeaterOrderAllTest") as Repeater;
                if (RepeaterOrderTest != null && RepeaterOrderAllTest != null)
                {
                    RepeaterOrderTest.DataSource = dvTest.CreateChildView("OrderedTest");
                    RepeaterOrderTest.DataBind();

                    RepeaterOrderAllTest.DataSource = DVAllTest.CreateChildView("OrderedAllTest");
                    RepeaterOrderAllTest.DataBind();
                }
            }

        }





        protected void LinkButtonSaveResult_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;

            if (Session["LabId"] != null)
            {
                DataTable dttestresult = new DataTable();
                dttestresult.Columns.AddRange(new DataColumn[4] {
                    new DataColumn("OrderID", typeof(string)),
                    new DataColumn("TestID",typeof(string)),
                    new DataColumn("TestName",typeof(string)),
                    new DataColumn("Result", typeof(string)) });

                Label LabelOrderId = (Label)button.FindControl("LabelOrderId");

                TextBox TextBoxReportNotes = (TextBox)button.FindControl("TextBoxReportNotes");

                foreach (RepeaterItem Order in RepeaterOrder.Items)
                {
                    Repeater RepeaterOrderAllTest = ((Repeater)(Order.FindControl("RepeaterOrderAllTest")));

                    foreach (RepeaterItem OrderTest in RepeaterOrderAllTest.Items)
                    {
                        HiddenField HiddenFieldTestId = OrderTest.FindControl("HiddenFieldTestId") as HiddenField;
                        Label LabelTestName = OrderTest.FindControl("LabelTestName") as Label;
                        TextBox TextBoxResult = OrderTest.FindControl("TextBoxResult") as TextBox;

                        if (TextBoxResult.Text == "")
                        {
                            messagediv.Visible = true;
                            messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                            mesaagetxt.InnerHtml = "Error! Test result not saved.";

                        }
                        else
                        {
                            dttestresult.Rows.Add(LabelOrderId.Text, HiddenFieldTestId.Value, LabelTestName.Text, TextBoxResult.Text);
                        }
                    }

                }



                if (dttestresult.Rows.Count > 0)
                {



                    string response = operation.AddTestResult(LabelOrderId.Text, Server.HtmlEncode(TextBoxReportNotes.Text), dttestresult);

                    if (response == "SUCCESS")
                    {

                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Success! Result saved.";
                        dttestresult = null;
                        Order();
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