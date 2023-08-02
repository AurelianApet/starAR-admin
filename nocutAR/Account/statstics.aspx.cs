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
    public partial class statstics : Common.PageBase
    {
        private int sumuser;
        private int activesumusers;
        private int deactivesumusers;
        private int sumscans;
//        private int sumactions;
        private bool page_type;
        private int curpage;
        private int totalpage;
        private int cur_userpage;
        private int total_userpage;

        private string title;
        private void  loadCampains()
        {
            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM users where user_type=0");
            sumuser = PageDataSource.Tables[0].Rows.Count;

            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM users where contract_mode=1 and user_type=0");
            activesumusers = PageDataSource.Tables[0].Rows.Count;

            deactivesumusers = sumuser - activesumusers;

            PageDataSource = DBConn.RunSelectQuery("SELECT api_requests FROM contents");
            int count1 = PageDataSource.Tables[0].Rows.Count;
            if (count1 > 0)
            {
                for (int i = 0; i < count1; i++)
                {
                    sumscans += Convert.ToInt32(PageDataSource.Tables[0].Rows[i][0]);
                }
            }
        }                
        protected void btnDelUser_Click1(object sender, EventArgs e)
        {
            string user_id = userID.Value;
            if (user_id == "")
            {
                ShowMessageBox("비정상적인 접근입니다.", "statstics.aspx?page_type=1");
                return;
            }

            try
            {
                string query = "delete from users where loginid='" + user_id + "'";
                DBConn.RunSelectQuery(query);
                ShowMessageBox("성공적으로 삭제했습니다.", "statstics.aspx?page_type=1");
                return;
            }
            catch(Exception)
            {
                ShowMessageBox("삭제도중에 오류가 발생했습니다.", "statstics.aspx?page_type=1");
                return;
            }
        }
        private void LoadUserPages(string query)
        {
            if (string.IsNullOrEmpty(Request.Params["user_page"]))
            {
                cur_userpage = 1;
            }
            else
            {
                cur_userpage = Convert.ToInt32(Request.Params["user_page"]);
            }

            PageDataSource = DBConn.RunSelectQuery(query);
            int ct = PageDataSource.Tables[0].Rows.Count;
            total_userpage = Convert.ToInt32(Math.Ceiling(ct / 5.0));

            if(ct > 0)
            {
                string page_userdata = "<table cellpadding='0' cellspacing='0' width='427' align='center'><tbody><tr>"
    + "<td width='25' height='70'><p><a onclick='GoPrevUserPage("
    + cur_userpage
    + ")' style='cursor:pointer'><font color='#666666'>◀</font></a></p></td><td width='377' height='70'><p align='center'>";

                int curtimepage = (cur_userpage - 1) / 5;

                for (int i = curtimepage * 5 + 1; i <= (curtimepage + 1) * 5; i++)
                {
                    if (i > total_userpage) break;
                    if (i == cur_userpage)
                    {
                        page_userdata += "<a onclick='GotoUserPage("
                                + Convert.ToString(i)
                                + ","
                                + Convert.ToString(total_userpage)
                                + ")' style='cursor:pointer' ><span style='font-size:15pt;'><b>"
                                + "<font face='돋움' color='#111111'>"
                                + Convert.ToString(i)
                                + "&nbsp;&nbsp;&nbsp;</font></b></span></a>";
                    }
                    else
                    {
                        page_userdata += "<a onclick='GotoUserPage("
                                + Convert.ToString(i)
                                + ","
                                + Convert.ToString(total_userpage)
                                + ")' style='cursor:pointer' ><span style='font-size:11pt;'><b>"
                                + "<font face='돋움' color='#666666'>"
                                + Convert.ToString(i)
                                + "&nbsp;&nbsp;&nbsp;</font></b></span></a>";
                    }
                }

                page_userdata += "</p></td><td width='25' height='70'><p align='right'><a onclick='GoNextUserPage("
                    + cur_userpage
                    + ", "
                    + total_userpage
                    + ")' style='cursor:pointer'><font color='#666666'>▶</font></a></p></td></tr></tbody></table></td>";

                userpageData.Text = page_userdata;
            }
        }
        private void LoadPages()
        {
            if (string.IsNullOrEmpty(Request.Params["page"]))
            {
                curpage = 1;
            }
            else
            {
                curpage = Convert.ToInt32(Request.Params["page"]);
            }

            if (!string.IsNullOrEmpty(Request.Params["stype"]))
            {
                string start_searchtxt = Request.Params["searchtxt1"];
                string end_searchtxt = Request.Params["searchtxt2"];
                string stype = Request.Params["stype"];
                if (stype == "1")
                {
                    if(start_searchtxt == "" && end_searchtxt == "")
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where title = '" + title + "'");
                    }
                    else if (start_searchtxt == "")
                    {
                        if(title == "")
                        {
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where changedate <  '" + end_searchtxt + "'");
                        }
                        else
                        {
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where changedate <  '" + end_searchtxt + "' and title = '" + title + "'");
                        }
                    }
                    else if (end_searchtxt == "")
                    {
                        if (title == "")
                        {
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "'");
                        }
                        else
                        {
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and title = '" + title + "'");
                        }
                    }
                    else
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "'");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "' and title = '" + title + "'");
                    }
                }
                else if(stype == "2")
                {
                    if (start_searchtxt == "" && end_searchtxt == "")
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "'");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "' and title = '" + title + "'");
                    }
                    else if (start_searchtxt == "")
                    {
                        if (title == "")
                        {
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where changedate <  '" + end_searchtxt + "'");
                        }
                        else
                        {
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where changedate <  '" + end_searchtxt + "' and title = '" + title + "'");
                        }
                    }
                    else if (end_searchtxt == "")
                    {
                        if (title == "")
                        {
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "'");
                        }
                        else
                        {
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and title = '" + title + "'");
                        }
                    }
                    else
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "'");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "' and title = '" + title + "'");
                    }
                }                
            }
            else
            {
                if (title == "")
                    PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents");
                else
                    PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where title = '" + title + "'");
            }

            int count1 = PageDataSource.Tables[0].Rows.Count;
            if(count1 > 0)
            {
                totalpage = Convert.ToInt32(Math.Ceiling(count1 / 5.0));

                string pagedata = "<table cellpadding='0' cellspacing='0' width='427' align='center'><tbody><tr>"
                    + "<td width='25' height='70'><p><a onclick='GoPrevPage("
                    + curpage
                    + ")' style='cursor:pointer'><font color='#666666'>◀</font></a></p></td><td width='377' height='70'><p align='center'>";

                int curtimepage = (curpage - 1) / 5;

                for (int i = curtimepage * 5 + 1; i <= (curtimepage + 1) * 5; i++)
                {
                    if (i > totalpage) break;
                    if (i == curpage)
                    {
                        pagedata += "<a onclick='GotoPage("
                                + Convert.ToString(i)
                                + ","
                                + Convert.ToString(totalpage)
                                + ")' style='cursor:pointer' ><span style='font-size:15pt;'><b>"
                                + "<font face='돋움' color='#111111'>"
                                + Convert.ToString(i)
                                + "&nbsp;&nbsp;&nbsp;</font></b></span></a>";
                    }
                    else
                    {
                        pagedata += "<a onclick='GotoPage("
                                + Convert.ToString(i)
                                + ","
                                + Convert.ToString(totalpage)
                                + ")' style='cursor:pointer' ><span style='font-size:11pt;'><b>"
                                + "<font face='돋움' color='#666666'>"
                                + Convert.ToString(i)
                                + "&nbsp;&nbsp;&nbsp;</font></b></span></a>";
                    }
                }

                pagedata += "</p></td><td width='25' height='70'><p align='right'><a onclick='GoNextPage("
                    + curpage
                    + ", "
                    + totalpage
                    + ")' style='cursor:pointer'><font color='#666666'>▶</font></a></p></td></tr></tbody></table></td>";
                statpageData.Text = pagedata;
            }
        }
        void Load_DataPerpage()
        {
            string statCampainstr = "<td width='890' height='629' style='vertical-align:top;'>"
               + "<table cellpadding='0' cellspacing='0' width='888' style='border-collapse:collapse;'>"
               + "<thead><tr>"
               + "<td width='239' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
               + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>캠페인 명</font></b></span></p>"
               + "</td>"
               + "<td width='159' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
               + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>등록일</font></b></span></p>"
               + "</td><td width='161' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
               + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>총 유저 수</font></b></span></p>"
               + "</td><td width='161' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
               + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>총 실행 수</font></b></span></p>"
//               + "</td><td width='162' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
//               + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>총 액션 수</font></b></span></p></td>"
               + "</tr></thead>";

            if (!string.IsNullOrEmpty(Request.Params["stype"]))
            {
                string start_searchtxt = Request.Params["searchtxt1"];
                string end_searchtxt = Request.Params["searchtxt2"];
                string stype = Request.Params["stype"];
                if (stype == "1")
                {
                    if(start_searchtxt == "" && end_searchtxt == "")
                    {
                        if(title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where title = '" + title + "'");
                    }
                    else if (start_searchtxt == "")
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where changedate <  '" + end_searchtxt + "'");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where changedate <  '" + end_searchtxt + "' and title = '" + title + "'");
                    }
                    else if (end_searchtxt == "")
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "'");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and title = '" + title + "'");
                    }
                    else
                    {
                        if(title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "'");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "' and title = '" + title + "'");
                    }
                }
                else if (stype == "2")
                {
                    if (start_searchtxt == "" && end_searchtxt == "")
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where title = '" + title + "'");
                    }
                    else if (start_searchtxt == "")
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where changedate <  '" + end_searchtxt + "'");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where changedate <  '" + end_searchtxt + "' and title = '" + title + "'");
                    }
                    else if (end_searchtxt == "")
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "'");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and title = '" + title + "'");
                    }
                    else
                    {
                        if (title == "")
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "'");
                        else
                            PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where regdate >  '" + start_searchtxt + "' and changedate < '" + end_searchtxt + "' and title = '" + title + "'");
                    }
                }
            }
            else
            {
                if(title == "")
                    PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents");
                else
                    PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents where title='" + title + "'");
            }


            int count1 = PageDataSource.Tables[0].Rows.Count;
            statCampainstr += "<tbody>";
            if (count1 > 0)
            {
                for (int i = 5 * (curpage - 1); i < 5 * curpage; i++)
                {
                    if (i >= count1) break;
                    string title1 = PageDataSource.Tables[0].Rows[i][3].ToString();
                    string regdate = PageDataSource.Tables[0].Rows[i][9].ToString();
                    string scans = PageDataSource.Tables[0].Rows[i][7].ToString();
//                    string actions = "0";
                    statCampainstr += "<tr height='100'><td width='239' height='5' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
                    + title1
                    + "</font></b></span></p></td>"
                    + "<td width='159' height='50' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
                    + regdate
                    + "</font></b></span></p></td>"
                    + "<td width='161' height='50' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
                    + sumuser
                    + " ( "
                    + activesumusers
                    + " / "
                    + deactivesumusers
                    + " )"
                    + "</font></b></span></p></td>"
                    + "<td width='161' height='50' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
                    + scans
                    + "</font></b></span></p></td>"
//                    + "<td width='162' height='50' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
//                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
//                    + actions
//                    + "</font></b></span></p></td>"
                    + "</tr>";
                }
            }
            statCampainData.Text = statCampainstr + "</tbody></table>";
        }
        private int GetCampaignCount(string uid)
        {
            try
            {
                PageDataSource = DBConn.RunSelectQuery("SELECT COUNT(DISTINCT contentid) AS some_alias FROM contentsusehist where userid='" + uid + "'");
                int ct = Convert.ToInt32(PageDataSource.Tables[0].Rows[0][0].ToString());
//                if (ct > 0)
//                    ct = Convert.ToInt32(PageDataSource.Tables[0].Rows[0][11]);
                return ct;
            }
            catch (Exception) {
                return 0;
            }
        }
        private int GetUserCount(string uid)
        {
            try
            {
                PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contentsusehist where userid='" + uid + "'");
                int ct = PageDataSource.Tables[0].Rows.Count;
                return ct;
            }
            catch(Exception)
            {
                return 0;
            }
        }
        private int GetUserCount1(string uid)
        {
            try
            {
                PageDataSource = DBConn.RunSelectQuery("SELECT * FROM users where user_type=0 and loginid='" + uid + "'");
                int ct = PageDataSource.Tables[0].Rows.Count;
                int userct = 0;
                if (ct > 0)
                {
                    userct = Convert.ToInt32(PageDataSource.Tables[0].Rows[0][16].ToString());
                    return userct;
                }
                else
                {
                    return 0;
                }
            }
            catch (Exception)
            {
                return 0;
            }
        }
        private void prev_Process()
        {
            for(int i = 1900; i < 2018; i ++)
            {
                ListItem l1 = new ListItem(Convert.ToString(i), Convert.ToString(i - 1900), true);
                birth_year_dropdownlist.Items.Add(l1);
            }

            ListItem l = new ListItem("종로구", "0", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("중구", "1", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("용산구", "2", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("성동구", "3", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("광진구", "4", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("동대문구", "5", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("중랑구", "6", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("성북구", "7", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("강북구", "8", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("도봉구", "9", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("노원구", "10", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("은평구", "11", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("서대문구", "12", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("마포구", "13", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("양천구", "14", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("강서구", "15", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("구로구", "16", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("금천구", "17", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("영등포구", "18", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("동작구", "19", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("관악구", "20", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("서초구", "21", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("강남구", "22", true);
            place2_dropdownlist.Items.Add(l);    
            l = new ListItem("송파구", "23", true);
            place2_dropdownlist.Items.Add(l);
            l = new ListItem("강동구", "24", true);
            place2_dropdownlist.Items.Add(l);

            for (int i = 1900; i < 2018; i++)
            {
                ListItem l2 = new ListItem(Convert.ToString(i), Convert.ToString(i - 1900), true);
                birthyear_DropDownList1.Items.Add(l2);
            }

            l = new ListItem("종로구", "0", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("중구", "1", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("용산구", "2", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("성동구", "3", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("광진구", "4", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("동대문구", "5", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("중랑구", "6", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("성북구", "7", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("강북구", "8", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("도봉구", "9", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("노원구", "10", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("은평구", "11", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("서대문구", "12", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("마포구", "13", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("양천구", "14", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("강서구", "15", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("구로구", "16", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("금천구", "17", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("영등포구", "18", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("동작구", "19", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("관악구", "20", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("서초구", "21", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("강남구", "22", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("송파구", "23", true);
            place2_DropDownList1.Items.Add(l);
            l = new ListItem("강동구", "24", true);
            place2_DropDownList1.Items.Add(l);

            l = new ListItem("종로구", "0", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("중구", "1", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("용산구", "2", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("성동구", "3", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("광진구", "4", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("동대문구", "5", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("중랑구", "6", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("성북구", "7", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("강북구", "8", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("도봉구", "9", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("노원구", "10", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("은평구", "11", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("서대문구", "12", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("마포구", "13", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("양천구", "14", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("강서구", "15", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("구로구", "16", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("금천구", "17", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("영등포구", "18", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("동작구", "19", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("관악구", "20", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("서초구", "21", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("강남구", "22", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("송파구", "23", true);
            Place2DropDown.Items.Add(l);
            l = new ListItem("강동구", "24", true);
            Place2DropDown.Items.Add(l);    

        }
        private void LoadCampaignData()
        {
            if (!string.IsNullOrEmpty(Request.Params["type"]) && Request.Params["type"] != "0")
            {
                stat_search1.Visible = false;
                stat_search2.Visible = true;

                title = Request.Params["type"];

                string topmenu = "<td width='289' height='50'>"
                    + "<p><b><font face='돋움' color='#555555'><span style='font-size:11pt;'>캠페인별 통계"
                    + " > " + title
                    + "</span></font></b></p></td>";
                Campain_title.Text = topmenu;

                string statSumListstr = "<table cellpadding='0' cellspacing='0' width='888' style='border-collapse:collapse;'>"
                    + "<tbody><tr>"
                    + "<td width='296' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>총 유저 수</font></b></span></p>"
                    + "</td><td width='296' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>총 실행 수</font></b></span></p></td>"
//                    + "<td width='296' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
//                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>총 액션 수</font></b></span></p></td>"
                    + "</tr>"
                    + "<tr><td width='296' height='63' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
                    + Convert.ToString(sumuser)
                    + "( "
                    + Convert.ToString(activesumusers)
                    + " / "
                    + Convert.ToString(deactivesumusers)
                    + " )"
                    + "</font></b></span></p>"
                    + "</td><td width='296' height='63' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
                    + Convert.ToString(sumscans)
                    + "</font></b></span></p></td>"
//                    + "<td width='296' height='63' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
//                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
//                    + Convert.ToString(sumactions)
//                    + "</font></b></span></p></td>"
                    + "</tr></tbody></table>";
                statSumListData.Text = statSumListstr;
            }
            else
            {
                stat_search2.Visible = false;
                stat_search1.Visible = true;
                title = "";
                string topmenu = "<td width='289' height='50'><p><b><font face='돋움' color='#555555'><span style='font-size:11pt;'>캠페인별 통계</span></font></b></p></td>";
                Campain_title.Text = topmenu;

                string statSumListstr = "<table cellpadding='0' cellspacing='0' width='888' style='border-collapse:collapse;'>"
                    + "<tbody><tr>"
                    + "<td width='296' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>총 유저 수</font></b></span></p>"
                    + "</td><td width='296' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>총 실행 수</font></b></span></p>"
//                    + "<td width='296' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'></td>"
//                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#CCCCCC'>총 액션 수</font></b></span></p></td>"
                    + "</tr>"
                    + "<tr><td width='296' height='63' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
                    + Convert.ToString(sumuser)
                    + "( "
                    + Convert.ToString(activesumusers)
                    + " / "
                    + Convert.ToString(deactivesumusers)
                    + " )"
                    + "</font></b></span></p>"
                    + "</td><td width='296' height='63' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
                    + Convert.ToString(sumscans)
                    + "</font></b></span></p></td>"
//                    + "<td width='296' height='63' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
//                    + "<p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#666666'>"
//                    + Convert.ToString(sumactions)
//                    + "</font></b></span></p></td>"
                    + "</tr></tbody></table>";
                statSumListData.Text = statSumListstr;
            }
            LoadPages();
            Load_DataPerpage();
        }
        private void LoadCampaignStatContents()
        {
            sumuser = 0;
            sumscans = 0;
//            sumactions = 0;
            activesumusers = 0;
            deactivesumusers = 0;
            curpage = 1;

            LoadFooter();
            LoadLeftMenu();
            loadCampains();
            LoadCampaignData();
        }
        private void LoadFooter()
        {
            string strFooterpage = "<table width='1240' style='bottom:0px;' bgcolor='#595959'><tbody><tr><td width='1240' height='40' bgcolor='#595959'><p align='right'  style='margin-top:0px; margin-bottom:0px; '>"
            + "<b><font face='돋움' color='#FFE4F2'  style='padding-right: 10px;'><span style='font-size:10pt;'>powered by coarsoft</span></font><span style='font-size:10pt;'><font face='돋움' color='#CCCCC'></font></span></b>"
            + "<font face='돋움' color='#CCCCCC'><span style='font-size:10pt;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font>"
            + "</p></td></tr></tbody></table>";

            statFooterPage.Text = strFooterpage;
        }
        private void LoadLeftMenu()
        {
            string statListstr = "";
            int page_type;
            string type = "";
            if(!string.IsNullOrEmpty(Request.Params["page_type"]))
            {
                page_type = Convert.ToInt32(Request.Params["page_type"]);
                if(page_type == 1)
                {
                    statListstr = "<table cellpadding='0' cellspacing='0' align='center' width='226'>"
                    + "                  <tbody><tr>"
                    + "                      <td width='226' height='90'>"
                    + "                         <p align='center'><b><font face='돋움' color='#555555'><span style='font-size:15pt;'>통계 홈</span></font></b></p>"
                    + "</td>"
                    + "</tr><tr><td width='226' height='50'><a onclick='onGetUserStat(\"\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#555555'>유저 통계</font></b></span></p></a></td></tr>"
                    + "<tr><td width='226' height='70'>"
                    + "<a onclick='onGetStat(\"\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#999999'>캠페인별 통계</font></b></span></p></a>"
                    + "</td></tr><tr><td width='226' height='397' valign='top'>";
                }
                else
                {
                    if(!string.IsNullOrEmpty(Request.Params["type"]))
                    {
                        type = Request.Params["type"];
                        statListstr = "<table cellpadding='0' cellspacing='0' align='center' width='226'>"
                        + "                  <tbody><tr>"
                        + "                      <td width='226' height='90'>"
                        + "                         <p align='center'><b><font face='돋움' color='#555555'><span style='font-size:15pt;'>통계 홈</span></font></b></p>"
                        + "</td>"
                        + "</tr><tr><td width='226' height='50'><a onclick='onGetUserStat(\"\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#999999'>유저 통계</font></b></span></p></a></td></tr>"
                        + "<tr><td width='226' height='70'>"
                        + "<a onclick='onGetStat(\"\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#999999'>캠페인별 통계</font></b></span></p></a>"
                        + "</td></tr><tr><td width='226' height='397' valign='top'>";
                    }
                    else
                    {
                        statListstr = "<table cellpadding='0' cellspacing='0' align='center' width='226'>"
                        + "                  <tbody><tr>"
                        + "                      <td width='226' height='90'>"
                        + "                         <p align='center'><b><font face='돋움' color='#555555'><span style='font-size:15pt;'>통계 홈</span></font></b></p>"
                        + "</td>"
                        + "</tr><tr><td width='226' height='50'><a onclick='onGetUserStat(\"\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#999999'>유저 통계</font></b></span></p></a></td></tr>"
                        + "<tr><td width='226' height='70'>"
                        + "<a onclick='onGetStat(\"\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#555555'>캠페인별 통계</font></b></span></p></a>"
                        + "</td></tr><tr><td width='226' height='397' valign='top'>";
                    }
                }
            }
            else
            {
                statListstr = "<table cellpadding='0' cellspacing='0' align='center' width='226'>"
                + "                  <tbody><tr>"
                + "                      <td width='226' height='90'>"
                + "                         <p align='center'><b><font face='돋움' color='#555555'><span style='font-size:15pt;'>통계 홈</span></font></b></p>"
                + "</td>"
                + "</tr><tr><td width='226' height='50'><a onclick='onGetUserStat(\"\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#999999'>유저 통계</font></b></span></p></a></td></tr>"
                + "<tr><td width='226' height='70'>"
                + "<a onclick='onGetStat(\"\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><b><font face='돋움' color='#555555'>캠페인별 통계</font></b></span></p></a>"
                + "</td></tr><tr><td width='226' height='397' valign='top'>";
            }

            PageDataSource = DBConn.RunSelectQuery("SELECT title FROM contents");
            int count1 = PageDataSource.Tables[0].Rows.Count;
            if (count1 > 0)
            {
                for (int i = 0; i < count1; i++)
                {
                    string title = PageDataSource.Tables[0].Rows[i][0].ToString();
                    if(type == title)
                    {
                        statListstr += "<a onclick='onGetStat(\""
                        + title
                        + "\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><font face='돋움' color='#555555'>"
                        + title
                        + "</font></span></p></a>";
                    }
                    else
                    {
                        statListstr += "<a onclick='onGetStat(\""
                        + title
                        + "\")' style='cursor:pointer'><p align='center'><span style='font-size:11pt;'><font face='돋움' color='#999999'>"
                        + title
                        + "</font></span></p></a>";
                    }
                }
            }
            statListData.Text += statListstr + "</td></tr></tbody></table>";
        }
        private void LoadUserData()
        {
            string userStatlist = "<table cellpadding='0' cellspacing='0' width='888' style='border-collapse:collapse;'>"
            + "<tbody><tr height='60'><td width='40' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'>&nbsp;</p></td>"
            + "<td width='88' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'><b><font face='돋움' color='#CCCCCC'><span style='font-size:11pt;'>가입일</span></font></b></p>"
            + "</td><td width='89' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'><b><font face='돋움' color='#CCCCCC'><span style='font-size:11pt;'>아이디</span></font></b></p>"
            + "</td><td width='129' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'><b><font face='돋움' color='#CCCCCC'><span style='font-size:11pt;'>이메일</span></font></b></p>"
            + "</td><td width='69' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'><b><font face='돋움' color='#CCCCCC'><span style='font-size:11pt;'>출생년도</span></font></b></p>"
            + "</td><td width='49' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'><b><font face='돋움' color='#CCCCCC'><span style='font-size:11pt;'>결혼</span></font></b></p>"
            + "</td><td width='49' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'><b><font face='돋움' color='#CCCCCC'><span style='font-size:11pt;'>성별</span></font></b></p>"
            + "</td><td width='136' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'><b><font face='돋움' color='#CCCCCC'><span style='font-size:11pt;'>사는 곳</span></font></b></p></td>"
            + "<td width='57' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'><b><font face='돋움' color='#CCCCCC'><span style='font-size:11pt;'>캠페인</span></font></b></p>"
            + "</td><td width='56' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>"
            + "<p align='center'><b><font face='돋움' color='#CCCCCC'><span style='font-size:11pt;'>실행수</span></font></b></p>"
            + "</td><td width='114' height='42' bgcolor='#666666' style='border-width:1; border-color:white; border-style:solid;'>&nbsp;</td>"
            + "</tr>";

            string query;

            if(!string .IsNullOrEmpty(Request.Params["search_type"]))
            {
                string startdate = "";
                string enddate = "";
                int ismarried = 0;
                int sex = 0;
                string place = "";

                if (!string.IsNullOrEmpty(Request.Params["regdate"]))
                    startdate = Request.Params["regdate"];
                if (!string.IsNullOrEmpty(Request.Params["changedate"]))
                    enddate = Request.Params["changedate"];
                if (!string.IsNullOrEmpty(Request.Params["married"]))
                {
                    if (Request.Params["married"] == "기혼")
                        ismarried = 1;
                    else
                        ismarried = 2;
                }
                if (!string.IsNullOrEmpty(Request.Params["sex"]))
                {
                    if (Request.Params["sex"] == "남자")
                        sex = 1;
                    else
                        sex = 2;
                }
                string place1 = "";
                string place2 = "";
                if (!string.IsNullOrEmpty(Request.Params["place1"]))
                {
                    place1 = Request.Params["place1"];
                }
                if (!string.IsNullOrEmpty(Request.Params["place2"]))
                {
                    place2 = Request.Params["place2"];
                }
                place = place1 + " " + place2;

                if (enddate == "" && startdate == "")
                {
                    query = "select * from users where user_type=0 and ismarried = '" + ismarried + "' and sex = '" + sex + "'and address = '" + place + "'";
                }
                else if (enddate == "")
                {
                    query = "select * from users where user_type=0 and logindate > '" + startdate + "' and ismarried = '" + ismarried + "' and sex = '" + sex + "'and address = '" + place + "'";
                }
                else if (startdate == "")
                {
                    query = "select * from users where user_type=0 and logindate < '" + enddate + "' and ismarried = '" + ismarried + "' and sex = '" + sex + "'and address = '" + place + "'";
                }
                else
                {
                    query = "select * from users where user_type=0 and logindate > '" + startdate + "' and logindate < '" + enddate + "' and ismarried = '" + ismarried + "' and sex = '" + sex + "'and address = '" + place + "'";
                }
            }
            else
            {
                query = "select * from users where user_type=0";
            }

            LoadUserPages(query);
            DataSet PageDataSource = DBConn.RunSelectQuery(query);
            int ct = PageDataSource.Tables[0].Rows.Count;
            if (ct > 0)
            {
                for (int i = 5 * (cur_userpage - 1); i < 5 * cur_userpage; i++)
                {
                    if (i >= ct) break;
                    string regdate = PageDataSource.Tables[0].Rows[i][26].ToString();
                    string uid = PageDataSource.Tables[0].Rows[i][1].ToString();
                    string id = PageDataSource.Tables[0].Rows[i][0].ToString();
                    string email = PageDataSource.Tables[0].Rows[i][20].ToString();
                    string birth_year = PageDataSource.Tables[0].Rows[i][27].ToString();
                    string married = PageDataSource.Tables[0].Rows[i][28].ToString();
                    if (married == "1")
                        married = "기혼";
                    else
                        married = "미혼";
                    string sex1 = PageDataSource.Tables[0].Rows[i][29].ToString();
                    if (sex1 == "1")
                        sex1 = "남";
                    else
                        sex1 = "여";
                    string place11 = PageDataSource.Tables[0].Rows[i][7].ToString();
                    int campaign_count = GetCampaignCount(id);
                    int user_count = GetUserCount(id);
                    int user_count1 = GetUserCount1(id);
                    if (birth_year == "")
                        birth_year = "0";
                    userStatlist += "<tr height='100'><td width='40' height='5' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + Convert.ToString(i + 1)
                        + "</span></font></p>"
                        + "</td><td width='88' height='5' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + regdate.Substring(0, 10)
                        + "</span></font></p>"
                        + "</td><td width='89' height='50' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                        + "<p align='center'><a onclick='onDetailUser(\""
                        + uid
                        + "\",\""
                        + campaign_count
                        + "\",\""
                        + user_count
                        + "\")"
                        + "' style='cursor:pointer' ><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + uid
                        + "</span></font></a></p>"
                        + "</td><td width='129' height='50' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + email
                        + "</span></font></p>"
                        + "</td><td width='69' height='50' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + birth_year + "(" + Convert.ToString(2017 - Convert.ToInt32(birth_year)) + "세)"
                        + "</span></font></p>"
                        + "</td><td width='49' height='50' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + married
                        + "</span></font></p>"
                        + "</td><td width='49' height='50' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + sex1
                        + "</span></font></p>"
                        + "</td><td width='136' height='50' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + place11
                        + "</span></font></p>"
                        + "</td><td width='57' height='50' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + Convert.ToString(campaign_count)
                        + "개</span></font></p>"
                        + "</td><td width='56' height='50' style='border-width:1; border-color:white; border-style:solid;' bgcolor='#F1F2F6'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'>"
                        + Convert.ToString(user_count)
//                        + "( "
//                        + Convert.ToString(user_count1)
//                        + "/"
//                        + Convert.ToString(user_count - user_count1)
//                        + ")"
                        + "번</span></font></p>"
                        + "</td><td width='114' height='50' bgcolor='#F1F2F6' style='border-width:1; border-color:white; border-style:solid;'>"
                        + "<p align='center'><font face='돋움' color='#666666'><span style='font-size:9pt;'><b>"
                        + "<a onclick='OnChange(\""
                        + uid
                        + "\",\""
                        + campaign_count
                        + "\",\""
                        + user_count
                        + "\")"
                        + "' style='cursor:pointer'>수정</a> ㅣ <a onclick='OnDelete(\""
                        + uid
                        + "\")' style='cursor:pointer'>삭제</a></b></span></font></a></p>"
                        + "</td></tr>";
                }
            }
            userStatlist += "</tbody></table>"
                + "<table cellpadding='0' cellspacing='0' align='center' width='875'>"
                + "<tbody><tr><td width='875' height='49' valign='bottom'>"
                + "<p align='right'><a onclick='onRegNewUser()' style='cursor:pointer'>"
                + "<img src='img/bt_resister.png' width='121' height='37' border='0' name='image2'></a></p>"
                + "</td></tr></tbody></table>";

            userStatListData.Text = userStatlist;
        }
        private void LoadUserStatContents()
        {
            prev_Process();
            LoadFooter();
            LoadLeftMenu();
            LoadUserData();
        }
        protected override void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.Params["page_type"]))
            {
                page_type = false;
            }
            else
            {
                if (Request.Params["page_type"].ToString() == "1")
                {
                    page_type = true;
                }
                else
                    page_type = false;
            }

            if(page_type)
            {
                campaignStat.Visible = false;
                userstatdata.Visible = true;
                LoadUserStatContents();
            }
            else
            {
                campaignStat.Visible = true;
                userstatdata.Visible = false;
                LoadCampaignStatContents();
            }
        }
    }
}