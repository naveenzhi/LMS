using System;
using System.Data;
using System.Web.UI.WebControls;

namespace LMS.Lab
{
    public partial class test : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        string labid, response;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                GetTest();
            }
        }

        protected void GetTest()
        {
            if (Session["LabId"] != null)
            {
                labid = Session["LabId"].ToString();
                DataTable dttest = operation.GetTest(labid);
                if (dttest != null)
                {
                    RepeaterTest.DataSource = dttest;
                    RepeaterTest.DataBind();
                }
            }

        }

        protected void LinkButtonUpdateRecord_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;

            TextBox TextBoxTestName = (TextBox)button.NamingContainer.FindControl("TextBoxTestName");
            TextBox TextBoxPrice = (TextBox)button.NamingContainer.FindControl("TextBoxPrice");
            TextBox TextBoxNormalRange = (TextBox)button.NamingContainer.FindControl("TextBoxNormalRange");
            DropDownList DropDownListStatus = (DropDownList)button.NamingContainer.FindControl("DropDownListStatus");

            HiddenField HiddenFieldTestID = (HiddenField)button.NamingContainer.FindControl("HiddenFieldTestID");

            if (TextBoxTestName.Text != "" && TextBoxPrice.Text != "" && DropDownListStatus.SelectedIndex > 0)
            {

                response = operation.UpdateTest(HiddenFieldTestID.Value, TextBoxTestName.Text, TextBoxPrice.Text, TextBoxNormalRange.Text, DropDownListStatus.SelectedValue);

                if (response == "SUCCESS")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "alert alert-success alert-dismissible";
                    mesaagetxt.InnerHtml = "Success!";
                    GetTest();
                }
                else if (response == "ERROR")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "alert alert-danger alert-dismissible";
                    mesaagetxt.InnerHtml = "Error!";
                }

            }

            else
            {
                messagediv.Visible = true;
                messagediv.Attributes["class"] = "alert alert-danger alert-dismissible";
                mesaagetxt.InnerHtml = "Error! Please fill required field.";
            }
        }
        protected void LinkButtonDelete_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;

            foreach (RepeaterItem LabTestitem in this.RepeaterTest.Items)
            {
                HiddenField HiddenTestId = LabTestitem.FindControl("HiddenTestId") as HiddenField;
                CheckBox CheckBoxTest = LabTestitem.FindControl("CheckBoxTest") as CheckBox;

                if (CheckBoxTest.Checked)
                {
                    response = operation.DeleteTest(HiddenTestId.Value);
                }
            }

            if (response == "SUCCESS")
            {
                messagediv.Visible = true;
                messagediv.Attributes["class"] = "alert alert-success alert-dismissible";
                mesaagetxt.InnerHtml = "Success!";
                GetTest();
            }
            else if (response == "ERROR")
            {
                messagediv.Visible = true;
                messagediv.Attributes["class"] = "alert alert-danger alert-dismissible";
                mesaagetxt.InnerHtml = "Error!";
            }
        }
    }
}