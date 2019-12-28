using System;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;

namespace LMS.Admin
{
    public partial class manage_lab : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataTable dtlab = new DataTable();
        string fileextension, LogoUrl;
        string directoryUrl = "/Uploaded/images/logo/";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                GetLab();
            }
        }
        protected void GetLab()
        {
            dtlab = operation.GetLab();

            if (dtlab != null)
            {
                RepeaterLab.DataSource = dtlab;
                RepeaterLab.DataBind();
            }
        }

        protected void LinkButtonUpdateLab_Click(object sender, EventArgs e)
        {


            LinkButton button = (LinkButton)sender;

            HiddenField HiddenFieldLabId = (HiddenField)button.NamingContainer.FindControl("HiddenFieldLabId");
            HiddenField HiddenFieldLogo = (HiddenField)button.NamingContainer.FindControl("HiddenFieldLogo");
            DropDownList DropDownListStatus = (DropDownList)button.NamingContainer.FindControl("DropDownListStatus");
            TextBox TextBoxValidity = (TextBox)button.NamingContainer.FindControl("TextBoxValidity");
            TextBox TextBoxLabName = (TextBox)button.NamingContainer.FindControl("TextBoxLabName");
            TextBox TextBoxOwnerName = (TextBox)button.NamingContainer.FindControl("TextBoxOwnerName");
            TextBox TextBoxMobile = (TextBox)button.NamingContainer.FindControl("TextBoxMobile");
            TextBox TextBoxPhone = (TextBox)button.NamingContainer.FindControl("TextBoxPhone");
            TextBox TextBoxEmail = (TextBox)button.NamingContainer.FindControl("TextBoxEmail");
            DropDownList DropDownListState = (DropDownList)button.NamingContainer.FindControl("DropDownListState");
            TextBox TextBoxCity = (TextBox)button.NamingContainer.FindControl("TextBoxCity");
            TextBox TextBoxPincode = (TextBox)button.NamingContainer.FindControl("TextBoxPincode");
            TextBox TextBoxAddress = (TextBox)button.NamingContainer.FindControl("TextBoxAddress");
            FileUpload FileUploadLogo = (FileUpload)button.NamingContainer.FindControl("FileUploadLogo");
            TextBox TextBoxWebsite = (TextBox)button.NamingContainer.FindControl("TextBoxWebsite");

            if (TextBoxLabName.Text != "" && TextBoxOwnerName.Text != "" && TextBoxMobile.Text != "" && TextBoxPhone.Text != "" && TextBoxEmail.Text != "" && DropDownListState.SelectedIndex > 0 && TextBoxAddress.Text != "" && TextBoxValidity.Text != "")
            {
                if (FileUploadLogo.HasFile)
                {
                    string docfilename = Path.GetFileName(FileUploadLogo.PostedFile.FileName);
                    fileextension = System.IO.Path.GetExtension(docfilename);

                    if (fileextension.ToLower() == ".jpg" || fileextension.ToLower() == ".jpeg" || fileextension.ToLower() == ".png")
                    {

                        string dirPath = Server.MapPath(directoryUrl);

                        if (!Directory.Exists(dirPath))
                        {
                            Directory.CreateDirectory(dirPath);
                        }

                        LogoUrl = directoryUrl + DateTime.Now.Ticks.ToString() + "." + fileextension.ToLower();
                    }
                    else
                    {
                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Error! unsupported file format.";
                    }
                }

                else
                {
                    LogoUrl = HiddenFieldLogo.Value;
                }
                string response = operation.UpdateLab(HiddenFieldLabId.Value, TextBoxLabName.Text, TextBoxOwnerName.Text, TextBoxMobile.Text, TextBoxPhone.Text, TextBoxEmail.Text, DropDownListState.SelectedValue, TextBoxCity.Text, TextBoxPincode.Text, TextBoxAddress.Text, TextBoxValidity.Text, LogoUrl, TextBoxWebsite.Text, DropDownListStatus.SelectedValue);

                if (response == "SUCCESS")
                {
                    if (FileUploadLogo.HasFile)
                    {
                        FileUploadLogo.SaveAs(Server.MapPath(LogoUrl));
                    }

                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Success!";

                    GetLab();
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
                mesaagetxt.InnerHtml = "Error! Please fill required field.";
            }
        }
    }
}