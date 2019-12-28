using System;
using System.Data;
using System.Web.UI.WebControls;

namespace LMS.Lab
{
    public partial class new_test : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        string labid;
        bool IsClubTest;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                TestGroup();
            }
        }

        protected void TestGroup()
        {
            DataTable dttestgroup;

            if (CheckBoxsubgroup.Checked == true)
            {
                DropDownListTestSubGroup.Enabled = true;
                if (DropDownListTestGroup.SelectedIndex > 0)
                {

                    dttestgroup = operation.GetTestGroup(DropDownListTestGroup.SelectedValue, 3);
                    if (dttestgroup != null)
                    {
                        DropDownListTestSubGroup.DataSource = dttestgroup;
                        DropDownListTestSubGroup.DataTextField = "Name";
                        DropDownListTestSubGroup.DataValueField = "TestGroupID";
                        DropDownListTestSubGroup.DataBind();
                        DropDownListTestSubGroup.Items.Insert(0, new ListItem("Select Sub Group", "0"));
                    }
                }
            }

            else
            {
                dttestgroup = operation.GetTestGroup("0", 2);

                if (dttestgroup != null)
                {
                    DropDownListTestGroup.DataSource = dttestgroup;
                    DropDownListTestGroup.DataTextField = "Name";
                    DropDownListTestGroup.DataValueField = "TestGroupID";
                    DropDownListTestGroup.DataBind();
                    DropDownListTestGroup.Items.Insert(0, new ListItem("Select Group", "0"));

                    DropDownListModalGroup.DataSource = dttestgroup;
                    DropDownListModalGroup.DataTextField = "Name";
                    DropDownListModalGroup.DataValueField = "TestGroupID";
                    DropDownListModalGroup.DataBind();
                    DropDownListModalGroup.Items.Insert(0, new ListItem("Select Group", "0"));

                }


            }

        }
        protected void CheckBoxsubgroup_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBoxsubgroup.Checked == true)
            {
                TestGroup();
            }

            else
            {
                DropDownListTestSubGroup.Enabled = false;
            }

        }

        protected void DropDownListTestGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (CheckBoxsubgroup.Checked == true)
            {
                TestGroup();
            }
        }

        protected void LinkButtonAddGroup_Click(object sender, EventArgs e)
        {
            if (TextBoxGroupName.Text != "")
            {
                string response = operation.AddTestGroup(TextBoxGroupName.Text, "0");

                if (response == "SUCCESS")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Success.";
                    TestGroup();
                }
                else if (response == "ERROR")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Error! something went wrong please try again later.";
                }
            }
        }

        protected void LinkButtonAddSubGroup_Click(object sender, EventArgs e)
        {
            if (TextBoxSubGroupName.Text != "" && DropDownListModalGroup.SelectedIndex > 0)
            {
                string response = operation.AddTestGroup(TextBoxSubGroupName.Text, DropDownListModalGroup.SelectedValue);

                if (response == "SUCCESS")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Success.";
                    TestGroup();
                }
                else if (response == "ERROR")
                {
                    messagediv.Visible = true;
                    messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                    mesaagetxt.InnerHtml = "Error! something went wrong please try again later.";
                }
            }
        }

        protected void CheckBoxClubTest_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBoxClubTest.Checked == true)
            {
                if (Session["LabId"] != null)
                {
                    labid = Session["LabId"].ToString();
                }
                DataTable dttest = operation.GetTest(labid);
                if (dttest != null)
                {
                    divtest.Visible = true;
                    RepeaterTest.DataSource = dttest;
                    RepeaterTest.DataBind();
                }

            }
            else
            {
                divtest.Visible = false;
            }

        }

        protected void ButtonAddTest_Click(object sender, EventArgs e)
        {
            string testgroupid; string parentgroupid; string IsclubofClub = "0";
            string testsortname;

            if (TextBoxTestSortName.Text != "")
            {
                testsortname = " (" + TextBoxTestSortName.Text + ")";
            }

            else
            {
                testsortname = null;
            }

            if (TextBoxTestName.Text != "" && TextBoxPrice.Text != "" && DropDownListTestGroup.SelectedIndex > 0)
            {


                if (Session["LabId"] != null)
                {
                    labid = Session["LabId"].ToString();
                }

                if (CheckBoxsubgroup.Checked == true)
                {
                    testgroupid = DropDownListTestSubGroup.SelectedItem.Value;
                    parentgroupid = DropDownListTestGroup.SelectedItem.Value;
                }
                else
                {
                    testgroupid = DropDownListTestGroup.SelectedItem.Value;
                    parentgroupid = "0";
                }

                if (CheckBoxClubTest.Checked == true)
                {
                    DataTable dtselectedtest = new DataTable();
                    dtselectedtest.Columns.AddRange(new DataColumn[5] {
                    new DataColumn("TestID",typeof(string)),
                    new DataColumn("TestName",typeof(string)),
                    new DataColumn("DisplayOrder", typeof(string)),
                    new DataColumn("ISClub",typeof(string)),
                    new DataColumn("SubClubId", typeof(string))});

                    foreach (RepeaterItem LabTestitem in this.RepeaterTest.Items)
                    {
                        HiddenField HiddenTestId = LabTestitem.FindControl("HiddenTestId") as HiddenField;

                        HiddenField HiddenIsClubTest = LabTestitem.FindControl("HiddenIsClubTest") as HiddenField;
                        IsClubTest = Convert.ToBoolean(HiddenIsClubTest.Value);
                        HiddenField HiddenIsClubTestName = LabTestitem.FindControl("ClubName") as HiddenField;
                        string ClubName = HiddenIsClubTestName.Value;

                        CheckBox CheckBoxTest = LabTestitem.FindControl("CheckBoxTest") as CheckBox;
                        TextBox TestDisplayOrder = LabTestitem.FindControl("TextBoxTestDisplayOrder") as TextBox;

                        if (CheckBoxTest.Checked)
                        {
                            if (IsClubTest == true)
                            {

                                DataTable dtClubTest = operation.GetClubTest(HiddenTestId.Value);
                                IsclubofClub = "1";
                                foreach (DataRow ClubTestitem in dtClubTest.Rows)
                                {
                                    dtselectedtest.Rows.Add(ClubTestitem["TestID"].ToString(), ClubName, TestDisplayOrder.Text + "." + ClubTestitem["DisplayOrder"].ToString(), 1, HiddenTestId.Value);
                                }
                            }

                            else
                            {
                                dtselectedtest.Rows.Add(HiddenTestId.Value, ClubName, TestDisplayOrder.Text, 0, 0);
                            }
                        }
                    }
                    if (dtselectedtest.Rows.Count > 0)
                    {

                        string response = operation.AddClubTest(TextBoxTestName.Text, testgroupid, TextBoxPrice.Text, TextBoxNormalRange.Text, labid, dtselectedtest, parentgroupid, IsclubofClub, testsortname);

                        if (response == "SUCCESS")
                        {
                            messagediv.Visible = true;
                            messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                            mesaagetxt.InnerHtml = "Success.";
                            TestGroup();
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
                    string response = operation.AddTest(TextBoxTestName.Text, testgroupid, TextBoxPrice.Text, TextBoxNormalRange.Text, TextBoxDefaultResult.Text, labid, parentgroupid, IsclubofClub, testsortname);

                    if (response == "SUCCESS")
                    {
                        messagediv.Visible = true;
                        messagediv.Attributes["class"] = "fixed-message rounded alert bg-success alert-dismissible animated fadeIn text-center text-white";
                        mesaagetxt.InnerHtml = "Success.";
                        TestGroup();
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
                messagediv.Attributes["class"] = "fixed-message rounded alert bg-danger alert-dismissible animated fadeIn text-center text-white";
                mesaagetxt.InnerHtml = "Error! Please fill required field.";
            }

        }
    }
}