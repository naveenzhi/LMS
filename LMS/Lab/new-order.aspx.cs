using System;
using System.Data;
using System.Linq;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace LMS.Lab
{
    public partial class new_order : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BindPage();

                if (Request.QueryString["pid"] != null)
                {
                    DropDownListPatient.SelectedValue = Request.QueryString["pid"].ToString();
                    patientdetails();
                }
            }
        }

        protected void BindPage()
        {
            if (Session["LabId"] != null)
            {
                DataSet dsbindpage = new DataSet();
                dsbindpage = operation.BindNewOrderPage(Session["LabId"].ToString());

                if (dsbindpage != null)
                {
                    DropDownListPatient.DataSource = dsbindpage.Tables[0];
                    DropDownListPatient.DataTextField = "PatientName";
                    DropDownListPatient.DataValueField = "PatientID";
                    DropDownListPatient.DataBind();
                    DropDownListPatient.Items.Insert(0, new ListItem("Select Patient", "0"));

                    DropDownListDoctor.DataSource = dsbindpage.Tables[1];
                    DropDownListDoctor.DataTextField = "NAME";
                    DropDownListDoctor.DataValueField = "NAME";
                    DropDownListDoctor.DataBind();
                    DropDownListDoctor.Items.Insert(0, new ListItem("Self", "Self"));

                    RepeaterTest.DataSource = dsbindpage.Tables[2];
                    RepeaterTest.DataBind();

                    DropDownListTestCenter.DataSource = dsbindpage.Tables[3];
                    DropDownListTestCenter.DataTextField = "NAME";
                    DropDownListTestCenter.DataValueField = "NAME";
                    DropDownListTestCenter.DataBind();
                    DropDownListTestCenter.Items.Insert(0, new ListItem("Reffered To", ""));
                }
            }
        }

        protected void patientdetails()
        {
            if (Session["LabId"] != null)
            {
                DataTable dtpatientdetails = new DataTable();

                dtpatientdetails = operation.PatientById(DropDownListPatient.SelectedValue, Session["LabId"].ToString());

                if (dtpatientdetails != null)
                {
                    DivPatientDetails.Visible = true;
                    RepeaterPatientDetails.DataSource = dtpatientdetails;
                    RepeaterPatientDetails.DataBind();
                }
            }


        }

        protected void DropDownListPatient_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownListPatient.SelectedIndex > 0)
            {
                patientdetails();
            }

            else
            {
                DivPatientDetails.Visible = false;
            }
        }



        protected void LinkButtonNewOrder_Click(object sender, EventArgs e)
        {
            if (Session["LabId"] != null)
            {
                string testid, testname, testprice;

                DataTable dtselectedtest = new DataTable();
                dtselectedtest.Columns.AddRange(new DataColumn[3] {
                    new DataColumn("TestID",typeof(string)),
                    new DataColumn("TestName",typeof(string)),
                    new DataColumn("TestPrice", typeof(string)) });

                DataTable dtselectedclubtest = new DataTable();
                dtselectedclubtest.Columns.AddRange(new DataColumn[3] {
                    new DataColumn("ClubTestID", typeof(string)),
                    new DataColumn("ClubTestName",typeof(string)),
                    new DataColumn("ClubTestPrice", typeof(string)) });

                foreach (RepeaterItem LabTestitem in this.RepeaterTest.Items)
                {
                    HiddenField HiddenTestId = LabTestitem.FindControl("HiddenTestId") as HiddenField;
                    testid = HiddenTestId.Value;

                    HiddenField HiddenIsClubTest = LabTestitem.FindControl("HiddenIsClubTest") as HiddenField;

                    Label LabelTestName = LabTestitem.FindControl("LabelTestName") as Label;
                    testname = LabelTestName.Text;

                    TextBox TextBoxTestPrice = LabTestitem.FindControl("TextBoxTestPrice") as TextBox;
                    testprice = TextBoxTestPrice.Text;

                    HtmlInputCheckBox CheckBoxTest = LabTestitem.FindControl("CheckBoxTest") as HtmlInputCheckBox;



                    if (CheckBoxTest.Checked)
                    {
                        if (HiddenIsClubTest.Value == "True")
                        {

                            DataTable dtclubtest = operation.GetClubTest(testid);
                            foreach (DataRow clubtestname in dtclubtest.Rows)
                            {
                                dtselectedtest.Rows.Add(clubtestname["TestID"].ToString(), clubtestname["TestName"].ToString(), 0);
                            }

                            dtselectedclubtest.Rows.Add(testid, testname, testprice);

                        }
                        else
                        {
                            dtselectedtest.Rows.Add(testid, testname, testprice);
                        }
                    }
                }

                if (dtselectedtest.Rows.Count > 0)
                {

                    string totalamount = (String.Format("{0}", Request.Form["TextBoxTotalAmount"])).Count() > 0 ? (String.Format("{0}", Request.Form["TextBoxTotalAmount"])) : null;
                    string paidamount = (String.Format("{0}", Request.Form["TextBoxPaid"])).Count() > 0 ? (String.Format("{0}", Request.Form["TextBoxPaid"])) : null;
                    string duesamount = (String.Format("{0}", Request.Form["TextBoxDues"])).Count() > 0 ? (String.Format("{0}", Request.Form["TextBoxDues"])) : null;
                    string discount = (String.Format("{0}", Request.Form["TextBoxDiscount"])).Count() > 0 ? (String.Format("{0}", Request.Form["TextBoxDiscount"])) : null;

                    string responsemsg = operation.AddOrder(Session["LabId"].ToString(), DropDownListPatient.SelectedValue, DropDownListDoctor.SelectedValue, totalamount, paidamount, duesamount, dtselectedtest, dtselectedclubtest, DropDownListTestCenter.SelectedValue, discount);

                    string response = responsemsg.Split(',')[0];

                    if (response == "SUCCESS")
                    {
                        Response.Redirect("Invoice.aspx?oid=" + responsemsg.Split(',')[1]);

                    }

                    else if (response == "ERROR")
                    {
                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Error! something went wrong please try again later.";
                    }
                }
                else
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Error! Please select test.";
                }
            }

            else
            {
                messagediv.Visible = true;
                messagediv.Attributes["class"] = "fixed-message rounded alert bg-warning alert-dismissible animated fadeIn text-center text-white";
                mesaagetxt.InnerHtml = "session out!";
            }
        }
        protected void LinkButtonAddDoctor_Click(object sender, EventArgs e)
        {
            if (TextBoxDoctorName.Text == "" || TextBoxDegree.Text == "" || TextBoxCity.Text == "")
            {
                messagediv.Visible = true;
                messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                mesaagetxt.InnerHtml = "Error! Please fill all required field.";

            }

            else
            {
                string response = operation.AddDoctor(TextBoxDoctorName.Text, TextBoxDegree.Text, TextBoxCity.Text);

                if (response == "SUCCESS")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Success.";

                    BindPage();
                }
                else if (response == "ERROR")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Error! something went wrong please try again later.";
                }
            }
        }
        protected void LinkButtonAddTestCenter_Click(object sender, EventArgs e)
        {
            if (Session["LabId"] != null)
            {
                if (TextBoxCenterName.Text == "" || TextBoxCenterCode.Text == "")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Error! Please fill all required field.";

                }

                else
                {
                    string response = operation.AddTestCenter(TextBoxCenterName.Text, TextBoxCenterCode.Text, Session["LabId"].ToString());

                    if (response == "SUCCESS")
                    {
                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Success.";

                        BindPage();
                    }
                    else if (response == "ERROR")
                    {
                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Error! something went wrong please try again later.";
                    }
                }
            }

            else
            {
                messagediv.Visible = true;
                messagediv.Attributes["class"] = "fixed-message rounded alert bg-warning alert-dismissible animated fadeIn text-center text-white";
                mesaagetxt.InnerHtml = "session out!";
            }

        }
    }
}