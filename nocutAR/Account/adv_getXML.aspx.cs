using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DataAccess;
using System.Text;
using System.Data;

namespace nocutAR.Account
{
    public partial class adv_getXML : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.Params["type"]))
            {
                return;
            }
            int type = Int32.Parse(Request.Params["type"]);

            DataSet dsContent = null;
            dsContent = DBConn.RunSelectQuery("select xml from starAR.dbo.advertisement where type=" + type);
            if (!DataSetUtil.IsNullOrEmpty(dsContent))
            {
                try
                {
                    StringBuilder responseXml = new StringBuilder();
                    responseXml.Append(DataSetUtil.RowStringValue(dsContent, "xml", 0));
                    string str = responseXml.ToString();
                    Response.Write(responseXml.ToString());
                }
                catch (Exception)
                {
                    StringBuilder responseXml = new StringBuilder();
                    responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                    responseXml.Append("<contents >");
                    responseXml.Append("</contents>");
                    Response.Write(responseXml.ToString());
                }
            }
            else
            {
                StringBuilder responseXml = new StringBuilder();
                responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                responseXml.Append("<contents >");
                responseXml.Append("</contents>");
                Response.Write(responseXml.ToString());
            }
        }

        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}