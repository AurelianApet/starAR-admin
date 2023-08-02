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

namespace nocutAR.Account
{
    public partial class advertisement : Common.PageBase
    {
        private string name1 = "", master1 = "", end1 = "", unlimited1 = "", imageurl1 = "", type1 = "", start1 = "", name2 = "",
            master2 = "", end2 = "", start2 = "", unlimited2 = "", imageurl2 = "", type2 = "";
        protected override void Page_Load(object sender, EventArgs e)
        {
            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM advertisement WHERE type=1 ORDER BY id");
            int count1 = PageDataSource.Tables[0].Rows.Count;
            if(count1> 0)
            {
                 name1 = PageDataSource.Tables[0].Rows[0][1].ToString();
                 master1 = PageDataSource.Tables[0].Rows[0][2].ToString();
                 start1 = PageDataSource.Tables[0].Rows[0][3].ToString();
                 end1 = PageDataSource.Tables[0].Rows[0][4].ToString();
                 unlimited1 = PageDataSource.Tables[0].Rows[0][5].ToString();
                 imageurl1 = "/uploads/advers/" + PageDataSource.Tables[0].Rows[0][6].ToString();
                 type1 = PageDataSource.Tables[0].Rows[0][7].ToString();
            }

            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM advertisement WHERE type=2 ORDER BY id");
            int count2 = PageDataSource.Tables[0].Rows.Count;
            if (count2> 0)
            {
                 name2 = PageDataSource.Tables[0].Rows[0][1].ToString();
                 master2 = PageDataSource.Tables[0].Rows[0][2].ToString();
                 start2 = PageDataSource.Tables[0].Rows[0][3].ToString();
                 end2 = PageDataSource.Tables[0].Rows[0][4].ToString();
                 unlimited2 = PageDataSource.Tables[0].Rows[0][5].ToString();
                 imageurl2 = "/uploads/advers/" + PageDataSource.Tables[0].Rows[0][6].ToString();
                 type2 = PageDataSource.Tables[0].Rows[0][7].ToString();
            }

            string strimageurl1 = "<img id = 'image1' src="
                + imageurl1
                + " style = 'position:absolute;left: -100%;right: -100%;top: -100%;bottom: -100%;margin: auto; min-height: 100%; min-width: 100%;' src = '' alt = '' />";
            Liter_imageurl1.Text = strimageurl1;

            string strname1 = "<input type = 'text' value = '"
                + name1
                + "' id = 'adv_name1' style = 'font-size:13pt;height:28px;width:380px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' />";
            Liter_name1.Text = strname1;

            string strmaster1 = "<input type = 'text' value = '"
                + master1
                + "' id = 'adv_master1' style = 'font-size:13pt;height:28px;width:380px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' />";
            Liter_master1.Text = strmaster1;

            StartDate1.Text = start1;
            EndDate1.Text = end1;

            if(unlimited1 == "1")
            {
                unlim1.Value = "1";
            }
            
            /*
                        string strstart1 = "<input type = 'text' value = '"
                            + start1
                            + "' id = 'period_start1' style = 'font-size:13pt;height:29px;width:132px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' />";
                        Liter_start1.Text = strstart1;

                        string strend1 = "<input type = 'text' value = '"
                            + end1
                            + "' id = 'period_end1' style = 'font-size:13pt;height:29px;width:132px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' />";
                        Liter_end1.Text = strend1;
            */

            string strimgurl1 = "<input type = 'text' value = '"
                + imageurl1
                + "' style = 'font-size:13pt;height:28px;width:280px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' id = 'adv_file_text1' size = '30' placeholder = '   jpg,jpeg,png 파일' readonly= 'readonly' />";
            Liter_imgurl1.Text = strimgurl1;

            string strimageurl2 = "<img id='image2' src="
                + imageurl2
                + " style='position:absolute;left: -100%;right: -100%;top: -100%;bottom: -100%;margin: auto; min-height: 100%; min-width: 100%;width:100%;height:100%' alt='' />";
            Liter_imageurl2.Text = strimageurl2;

            string strname2 = "<input type = 'text' value = '"
                + name2
                + "' id='adv_name2' style='font-size:13pt;height:28px;width:541px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' />";
            Liter_name2.Text = strname2;

            string strmaster2 = "<input type = 'text' value = '"
                + master2
                + "' id='adv_master2' style='font-size:13pt;height:28px;width:541px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' />";
            Liter_master2.Text = strmaster2;

            StartDate2.Text = start2;
            EndDate2.Text = end2;

            if(unlimited2 == "1")
            {
                unlim2.Value = "1";
            }
/*
            string strstart2 = "<input type='text' value = '"
                + start2
                + "' id='period_start2' style='font-size:13pt;height:28px;width:200px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' />";
            Liter_start2.Text = strstart2;

            string strend2 = "<input type = 'text' value = '"
                + end2
                + "' id='period_end2' style='font-size:13pt;height:28px;width:200px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' />";
            Liter_end2.Text = strend2;
*/

            string strimgurl2 = "<input type='text' value = '"
                + imageurl2
                + "' style='font-size:13pt;height:30px;width:450px;border-width:1px;border-color:rgb(204,204,204);border-style:solid;background-color:white' id='adv_file_text2' size='30' placeholder='   jpg,jpeg,png 파일' readonly='readonly' />";
            Lister_imgurl2.Text = strimgurl2;
        }
    }
}