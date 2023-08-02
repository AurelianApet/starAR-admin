using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using nocutAR.Common;
using DataAccess;
using System.Net;
using System.Windows.Forms;

namespace nocutAR.Account
{
    public partial class delAdvertisement : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.Params["type"]))
            {
                ShowMessageBox("잘못된 접근입니다.", "advertisement.aspx");
                return;
            }
            int type = Int32.Parse(Request.Params["type"]);
            try
            {
                if (type == 1)
                {
                    PageDataSource = DBConn.RunSelectQuery("delete from advertisement where type = 1");
                }
                else if (type == 2)
                {
                    PageDataSource = DBConn.RunSelectQuery("delete from advertisement where type = 2");
                }
            }
            catch(Exception )
            {
                MessageBox.Show("삭제에 실패했습니다.");
            }
            Response.Redirect("advertisement.aspx");
        }
    }
}