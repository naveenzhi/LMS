using System;
using System.IO;

namespace LMS.Admin
{
    public partial class new_lab : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        string fileextension, LogoUrl;
        string directoryUrl = "/Uploaded/images/logo/";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonAddNewLab_Click(object sender, EventArgs e)
        {
            if (TextBoxUserName.Text != "" && TextBoxPassword.Text != "" && TextBoxLabName.Text != "" && TextBoxOwnerName.Text != "" && TextBoxMobile.Text != "" && TextBoxPhone.Text != "" && TextBoxEmail.Text != "" && DropDownListState.SelectedIndex > 0 && TextBoxAddress.Text != "" && TextBoxValidity.Text != "")
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
                    LogoUrl = "/Uploaded/images/logo/logo.png";
                }
                string response = operation.AddLab(TextBoxUserName.Text, TextBoxPassword.Text, TextBoxLabName.Text, TextBoxOwnerName.Text, TextBoxMobile.Text, TextBoxPhone.Text, TextBoxEmail.Text, DropDownListState.SelectedValue, TextBoxCity.Text, TextBoxPincode.Text, TextBoxAddress.Text, TextBoxValidity.Text, LogoUrl, TextBoxWebsite.Text);

                string responsemsg = response.Split(',')[0];

                if (responsemsg == "SUCCESS")
                {
                    if (FileUploadLogo.HasFile)
                    {
                        FileUploadLogo.SaveAs(Server.MapPath(LogoUrl));
                    }
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Success! Lab Id : " + response.Split(',')[1];
                }

                else if (responsemsg == "DUPLICATE")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "username already taken.";
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