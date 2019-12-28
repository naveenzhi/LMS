using System;
using System.Data;

namespace LMS.Lab
{
    public partial class invoice : System.Web.UI.Page
    {
        DBOperations operation = new DBOperations();
        DataSet dsorder = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                Invoice();
            }
        }

        protected void Invoice()
        {
            if (Session["LabId"] != null && Request.QueryString["oid"] != null)
            {
                dsorder = operation.GenerateInvoice(Session["LabId"].ToString(), Request.QueryString["oid"].ToString());

                if (dsorder != null)
                {
                    if (dsorder.Tables[0].Rows.Count > 0)
                    {
                        string orderno, patientname;

                        patientname = dsorder.Tables[0].Rows[0]["PatientName"].ToString();
                        orderno = dsorder.Tables[0].Rows[0]["OrderID"].ToString();
                        this.Page.Title = "Receipt_" + patientname + "_" + orderno;

                        LabelAddress.Text = dsorder.Tables[0].Rows[0]["ADDRESS"].ToString();
                        LabelAge.Text = dsorder.Tables[0].Rows[0]["AGE"].ToString();
                        LabelReferredBy.Text = dsorder.Tables[0].Rows[0]["ReferredBy"].ToString();
                        LabelReferredTo.Text = dsorder.Tables[0].Rows[0]["ReferredTo"].ToString();
                        LabelOrderNo.Text = orderno;
                        LabelPatientName.Text = patientname;
                        LabelOrderDate.Text = String.Format("{0:dd MMM yyyy hh:mm tt}", dsorder.Tables[0].Rows[0]["DateCreated"]);
                        LabelPhone.Text = dsorder.Tables[0].Rows[0]["Mobile"].ToString();
                        LabelEmail.Text = dsorder.Tables[0].Rows[0]["Email"].ToString();
                        LabelAmount.Text = String.Format("{0:C}", dsorder.Tables[0].Rows[0]["Amount"]);
                        LabelDiscount.Text = String.Format("{0:C}", dsorder.Tables[0].Rows[0]["Discount"]);
                        string header_footer = dsorder.Tables[0].Rows[0]["IsEnabeled"].ToString();

                        if (header_footer == "True")
                        {
                            PanelHeader.Visible = true;
                            PanelFooter.Visible = true;

                            LabelHeader.Text = Server.HtmlDecode(dsorder.Tables[0].Rows[0]["Header"].ToString());
                            LabelFooter.Text = Server.HtmlDecode(dsorder.Tables[0].Rows[0]["Footer"].ToString());
                        }

                        RepeaterTest.DataSource = dsorder.Tables[1];
                        RepeaterTest.DataBind();
                    }
                }
            }
        }
    }
}