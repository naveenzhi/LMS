using System;

namespace LMS.Lab
{
    public partial class new_patient : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonAddPatient_Click(object sender, EventArgs e)
        {
            if (TextBoxName.Text != "" && TextBoxMobile.Text != "" && TextBoxAge.Text != "" && TextBoxAddress.Text != "")
            {
                string response = operation.AddPatient(DropDownListNameTitle.SelectedValue, TextBoxName.Text, TextBoxEmail.Text, TextBoxMobile.Text, TextBoxAadhar.Text, TextBoxAge.Text, DropDownListAgeType.SelectedValue, DropDownListSex.SelectedValue, DropDownListState.SelectedValue, TextBoxCity.Text, TextBoxPincode.Text, TextBoxAddress.Text, Session["LabId"].ToString(), Session["UserId"].ToString());

                string responsemsg = response.Split(',')[0];

                if (responsemsg == "SUCCESS")
                {
                    Response.Redirect("new-order?pid=" + response.Split(',')[1]);
                }

                else if (responsemsg == "DUPLICATE")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Mobile already registered.";
                }
                else if (responsemsg == "ERROR")
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
                mesaagetxt.InnerHtml = "Error! Please fill required field.";
            }

        }
    }
}