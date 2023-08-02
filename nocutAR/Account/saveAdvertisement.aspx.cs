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
    public partial class saveAdvertisement : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            string adv_name = Request.Params["adv_name"].ToString();
            string adv_master = Request.Params["adv_master"].ToString(); ;
            string period_start = Request.Params["period_start"].ToString(); ;
            string period_end = Request.Params["period_end"].ToString(); ;
            string fileurl = Request.Params["file"].ToString(); ;
            string type = Request.Params["type"].ToString();
            string unlimited;
            if (!string.IsNullOrEmpty(Request.Params["unlimited"]))
                unlimited = Request.Params["unlimited"].ToString();
            else
                unlimited = "";

            while(fileurl.IndexOf(@"\") > -1)
            {
                fileurl = fileurl.Substring(fileurl.IndexOf(@"\") + 1);
            }

            if(unlimited == "")
            {
                unlimited = "0";
            }
            string query = "SELECT * FROM advertisement WHERE type=" + type + " ORDER BY id";

            PageDataSource = DBConn.RunSelectQuery(query);
            try
            {
                string xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><contents><name>" + adv_name + "</name><master>" + adv_master + "</master><startTime>" +
    period_start + "</startTime><endTime>" + period_end + "</endTime><unlimited>" + unlimited + "</unlimited><imageurl>" + fileurl + "</imageurl><type>" + type + "</type></contents>";
                if (PageDataSource.Tables[0].Rows.Count > 0)
                {
                    query = "update advertisement set name='" + adv_name + "', master='" + adv_master + "',period_start='" + period_start + "',period_end='" + period_end + "',unlimited='" + unlimited + "',imageurl='" + fileurl + "', xml=\'" + xml + "\' where type='" + type + "'";
                    PageDataSource = DBConn.RunSelectQuery(query);
                }
                else if (PageDataSource.Tables[0].Rows.Count == 0)
                {
                    query = "insert into advertisement(name, master, period_start, period_end, unlimited, imageurl, type, xml) values('" + adv_name + "','" + adv_master + "','" + period_start + "','" + period_end + "','" + unlimited + "','" + fileurl + "','" + type + "',\'" + xml + "\')";
                    PageDataSource = DBConn.RunSelectQuery(query);
                }
            }
            catch(Exception)
            {
                MessageBox.Show("저장에 실패했습니다.");
            }
//            Response.Redirect("advertisement.aspx");
        }
    }
}