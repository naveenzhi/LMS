﻿using System;
using System.Data;

namespace LMS.Lab
{
    public partial class order : System.Web.UI.Page
    {

        DBOperations operation = new DBOperations();
        DataTable dtorder = new DataTable();
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
                dtorder = operation.GetOrder(Session["LabId"].ToString());

                if (dtorder != null)
                {
                    RepeaterOrder.DataSource = dtorder;
                    RepeaterOrder.DataBind();
                }
            }
        }
    }
}