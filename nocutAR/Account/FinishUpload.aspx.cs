using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace nocutAR.Account
{
    public partial class FinishUpload : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            Process[] uploadProc = Process.GetProcessesByName("VuforiaUpload");
            if (uploadProc.Length != 0)
            {
                //Uploading
                Response.Write("1");
            }
            else
            {
                //Finish
                Response.Write("0");
            }
        }
    }
}