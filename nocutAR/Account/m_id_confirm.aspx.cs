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
    public partial class m_id_confirm : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.Params["userid"]))
            {
                return;
            }

            string userid = Request.Params["userid"];

            DataSet dsContent = null;
            string query = "select * from users where loginid='" + userid + "'";

            dsContent = DBConn.RunSelectQuery(query);

            if (!DataSetUtil.IsNullOrEmpty(dsContent))
            {
                try
                {
                    string responseXml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><contents>1</contents>";
                    Response.Write(responseXml);
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
                string responseXml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><contents>0</contents>";
                Response.Write(responseXml);
            }
        }

        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}