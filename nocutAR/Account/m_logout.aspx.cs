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
    public partial class m_logout : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.Params["userid"]))
            {
                return;
            }
            string userid = Request.Params["userid"];
            
            try
            {
                string query = "update users set contract_mode=0 where loginid='" + userid + "'";
                DBConn.RunSelectQuery(query);
            }
            catch (Exception)
            {
            }
        }

        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}