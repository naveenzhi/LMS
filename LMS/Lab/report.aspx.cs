using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace LMS.Lab
{
    public partial class report : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataSet dsorder = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Report();
            }
        }

        protected void Report()
        {
            if (Session["LabId"] != null && Request.QueryString["oid"] != null)
            {
                dsorder = operation.GenerateReport(Session["LabId"].ToString(), Request.QueryString["oid"].ToString());

                if (dsorder.Tables.Count > 0)
                {
                    if (dsorder.Tables[0].Rows.Count > 0)
                    {
                        string orderno, patientname;
                        string header_footer = dsorder.Tables[0].Rows[0]["IsEnabeled"].ToString();

                        patientname = dsorder.Tables[0].Rows[0]["PatientName"].ToString();
                        orderno = dsorder.Tables[0].Rows[0]["OrderID"].ToString();
                        this.Page.Title = "Report_" + patientname + "_" + orderno;

                        LabelAddress.Text = dsorder.Tables[0].Rows[0]["ADDRESS"].ToString();
                        LabelAge.Text = dsorder.Tables[0].Rows[0]["AGE"].ToString() + " / " + dsorder.Tables[0].Rows[0]["SEX"].ToString();
                        LabelReferredBy.Text = dsorder.Tables[0].Rows[0]["ReferredBy"].ToString();
                        LabelReferredTo.Text = dsorder.Tables[0].Rows[0]["ReferredTo"].ToString();
                        LabelOrderNo.Text = orderno;
                        LabelPatientName.Text = patientname;
                        LabelOrderDate.Text = String.Format("{0:dd MMM yyyy hh:mm tt}", dsorder.Tables[0].Rows[0]["DateCreated"]);
                        LabelPhone.Text = dsorder.Tables[0].Rows[0]["Mobile"].ToString();
                        LabelEmail.Text = dsorder.Tables[0].Rows[0]["Email"].ToString();
                        LabelReportNotes.Text = Server.HtmlDecode(dsorder.Tables[0].Rows[0]["ReportNotes"].ToString());


                        if (header_footer == "True")
                        {
                            PanelHeader.Visible = true;
                            PanelFooter.Visible = true;

                            LabelHeader.Text = Server.HtmlDecode(dsorder.Tables[0].Rows[0]["Header"].ToString());
                            LabelFooter.Text = Server.HtmlDecode(dsorder.Tables[0].Rows[0]["Footer"].ToString());
                        }

                        if (dsorder.Tables.Count > 1)
                        {
                            if (dsorder.Tables[1].Rows.Count > 0)
                            {

                                DataTable sortedtestbydisplayorder;
                                DataTable dttest = dsorder.Tables[1]; // Assume this method returns the datatable from service      
                                DataTable dttestclone = dttest.Clone();
                                dttestclone.Columns["Displayorder"].DataType = Type.GetType("System.Double");

                                foreach (DataRow dr in dttest.Rows)
                                {
                                    dttestclone.ImportRow(dr);
                                }
                                dttestclone.AcceptChanges();
                                DataView dvtest = dttestclone.DefaultView;
                                dvtest.Sort = "Displayorder asc";
                                sortedtestbydisplayorder = dvtest.ToTable();

                                DataTable dtcustomtest = new DataTable();

                                dtcustomtest.Columns.AddRange(new DataColumn[4] {
                                new DataColumn("TestGroup",typeof(string)),
                                new DataColumn("TestName",typeof(string)),
                                new DataColumn("Result",typeof(string)),

                                new DataColumn("NormalRange",typeof(string)) });

                                foreach (DataRow sortedtest in sortedtestbydisplayorder.Rows)
                                {
                                    if (sortedtest["Clubname"].ToString() != "")
                                    {

                                        dtcustomtest.Rows.Add(sortedtest["TestGroup"].ToString(), null, null, null);

                                        dtcustomtest.Rows.Add(sortedtest["Clubname"].ToString().Trim(),
                                        sortedtest["TestName"].ToString(),
                                        sortedtest["Result"].ToString(),
                                        sortedtest["NormalRange"].ToString());
                                    }
                                    else
                                    {
                                        dtcustomtest.Rows.Add(sortedtest["TestGroup"].ToString().Trim(),
                                        sortedtest["TestName"].ToString(),
                                        sortedtest["Result"].ToString(),
                                        sortedtest["NormalRange"].ToString());
                                    }
                                }

                                if (dtcustomtest.Rows.Count > 0)
                                {

                                    IEnumerable<dynamic> data = dtcustomtest.Rows.Cast<DataRow>()
                                    .GroupBy<DataRow, String>(d => Convert.ToString(d["TestGroup"]))
                                    .Select<IGrouping<String, DataRow>, dynamic>(grp =>
                                    {
                                        return new
                                        {
                                            TestGroup = grp.Key,
                                            Test = grp.Select<DataRow, dynamic>(row =>
                                            {
                                                return new
                                                {
                                                    TestName = Convert.ToString(row["TestName"]).Trim(),
                                                    Result = Convert.ToString(row["Result"]).Trim(),
                                                    NormalRange = Convert.ToString(row["NormalRange"]).Trim()
                                                };
                                            })
                                        };
                                    });

                                    RepeaterLabPatientTest.DataSource = data;
                                    RepeaterLabPatientTest.DataBind();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}