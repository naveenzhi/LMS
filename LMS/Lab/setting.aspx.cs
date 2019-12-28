using System;
using System.Data;

namespace LMS.Lab
{
    public partial class setting : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataTable dtsetting = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                GetSetting();
            }
        }

        protected void GetSetting()
        {
            if (Session["LabId"] != null)
            {
                dtsetting = operation.GetSetting(Session["LabId"].ToString());
                if (dtsetting != null)
                {
                    if (dtsetting.Rows.Count > 0)
                    {
                        DropDownListStatus.SelectedValue = dtsetting.Rows[0]["IsEnabeled"].ToString();
                        TextBoxHeader.Text = Server.HtmlDecode(dtsetting.Rows[0]["Header"].ToString());
                        TextBoxFooter.Text = Server.HtmlDecode(dtsetting.Rows[0]["Footer"].ToString());
                    }

                }
            }

        }

        protected void LinkButtonSave_Click(object sender, EventArgs e)
        {
            if (Session["LabId"] != null)
            {
                string header = TextBoxHeader.Text;
                string footer = TextBoxFooter.Text;

                string response = operation.Labsetting(Session["LabId"].ToString(), Server.HtmlEncode(header), Server.HtmlEncode(footer), DropDownListStatus.SelectedValue);
                if (response == "SUCCESS")
                {

                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Success!";
                    GetSetting();
                }

                else if (response == "ERROR")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Error!";
                }
            }
        }
    }
}