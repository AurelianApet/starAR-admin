using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using DataAccess;

namespace nocutAR.Account
{
    public partial class getContentData : Common.AjaxPageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            DataSet dsContent = null;
            string strData = null;

            int IID = Int32.Parse(Request.Params["id"]);
            dsContent=DBConn.RunSelectQuery("SELECT contents.id AS content_id, contents.marker_url, contents.xml FROM contents WHERE contents.id={0}",
                new string[] { "@id" },
                new object[] { IID });
            if (!DataSetUtil.IsNullOrEmpty(dsContent))
            {
                string strItemFormat = "{{\"content_id\":\"{0}\", " +
                                         "\"marker_url\":\"{1}\", " +
                                         "\"flag\":\"{2}\" " +
                                       "}}";
                strData = string.Format(strItemFormat, DataSetUtil.RowLongValue(dsContent, "content_id", 0), DataSetUtil.RowStringValue(dsContent, "marker_url", 0), (DataSetUtil.RowStringValue(dsContent, "xml", 0) == "")?0:1);
            }
            Response.Write(strData);
            Response.End();
        }
    }
}