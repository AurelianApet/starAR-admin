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
    public partial class CampainList : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected override void BindData()
        {
            base.BindData();

            string strLtrData = "";

            string strItem = "<td width='280' height='307' ><div style='position:relative;text-align:center;'> "
                + "  <table cellpadding='0' cellspacing='0' align='center' style='border-collapse:collapse;' bgcolor='white' width='250'>"
                + "     <tr>"
                + "         <td width='242' height='220' style='border-width:1px; border-top-color:rgb(195,197,201); border-right-color:rgb(195,197,201); border-bottom-color:black; border-left-color:rgb(195,197,201); border-top-style:solid; border-right-style:solid; border-bottom-style:none; border-left-style:solid;'>"
                + "         <table cellpadding='0' cellspacing='0' align='center' width='242'>"
                + "             <tr>"
                + "             <td width='242' height='220' bgcolor='#EEEEEE'>"
                + "                 <div style='width:242px; height:220px; overflow:hidden; margin:1px; position:relative' >"
                + "                     <img class='marker_img' {6} id='{5}' style='position:absolute;left: -100%;right: -100%;top: -100%;bottom: -100%;margin: auto; min-height: 100%; min-width: 100%;'src='{0}' border='1' onClick='onShowDetail(\"{0}\",\"{1}\",\"{2}\",\"{3}\",{4});'/>"
                + "                     <a id='aEdit_{5}' class='marker_edt' style='position:absolute;right:5px;top:5px;' href='javascript:onEditCampaign({5})' >"
                + "                        <img class='image-btn' id='{5}' src='IMG/_0008_캠페인편집.png' border='0' align='right'>"
                + "                     </a>"
                + "                     <a id='aDel_{5}' class='marker_edt' style='position:absolute;right:15px;bottom:15px;' href='javascript:onDelCampaign({5})' >"
                + "                         <img src='IMG/_0009_trashcan.png' class='image-btn' width='41' height='41' border='0' name='image1'>"
                + "                     </a>"
                + "                 </div>"
                + "             </td>"
                + "             </tr>"
                + "         </table>"
                + "         </td>"
                + "     </tr>"
                + "     <tr>"
                + "         <td width='250' height='85' style='border-width:2;border-style:solid;'>"
                + "             <table width='227' cellpadding='0' cellspacing='0' align='center'>"
                + "                 <tbody>"
                + "                     <tr>"
                + "                         <td width='174' height='28'>"
                + "                             <p align='left'>"
                + "                                 <font face='돋움' color='#595959'>{1}</font>"
                + "                             </p>"
                + "                         </td>"
                + "                         <td width='53' height='28' valign='middle'>"
                + "                             <p align='left'>"
                + "                                 <font face='KoPub돋움체 Bold'>"
                + "                                     <span style='font-size:10pt;'>"
                + "                                         <img src='IMG/_0011_eye.png' border='0' align='middle' 135"
                + "                                     </span>"
                + "                                 </font>"
                + "                             </p>"
                + "                         </td><td>{4}</td>"
                + "                     </tr>"
                + "                     <tr>"
                + "                         <td width='174' height='41'>"
                + "                             <p align='left' style='line-height:110%;'>"
                + "                                 <span style='font-size:8pt; word-spacing:0px;letter-spacing:0px;'>"
                + "                                     <font face='돋움'>"
                + "                                         캠페인수정일:{2}<br>"
                + "                                         최종수정일:{3}<br>"
                + "                                     </font>"
                + "                                 </span>"
                + "                             </p>"
                + "                         </td>"
                + "                         <td width='53' height='41'>"
                + "                             <p align='left'>"
                + "                                 <font face='KoPub돋움체 Bold'>"
                + "                                     <span style='font-size:10pt;'>"
                + "                                         <img src='IMG/_0010_touch.png' border='0' align='middle'>"
                + "                                     </span>"
                + "                                 </font>"
                + "                             </p>"
                + "                         </td><td></td>"
                + "                     </tr>"
                + "                 </tbody>"
                + "             </table>"
                + "         </td>"
                + "     </tr>"
                +" </table>"
		        + " </td>";

                string strEmptyItem = "<td width='280' height='307'>"
                + "                     <p align='center'>"
                + "                         <img onclick='onAddCampain();' class='image-btn' src='img/studio_1(14).png' width='128' height='128' border='0'>"
                + "                     </p>"
                + " </td>";
            for (int i = 0; i < DataSetUtil.RowCount(PageDataSource); i+=4)
            {
                string strTable = "<table cellpadding='0' cellspacing='0' align='center' width='1240'> "
                   + "<tr>" ;
                for(int j = 0 ; j < 4 ; j++) {
                    int row = i+j;
                    if(row < DataSetUtil.RowCount(PageDataSource)) {
                        string url = DataSetUtil.RowStringValue(PageDataSource, "marker_url", row);
                       string strSize="height=220";
                        if (!url.Equals(""))
                        {
                            try
                            {
                                System.Drawing.Image image = System.Drawing.Image.FromFile(this.Server.MapPath("../markers/" + url));
                                if (image.Width <= image.Height)
                                    strSize = "width=280";
                            }
                            catch(Exception)
                            {

                            }
                        }
                        string item = string.Format(strItem, url==""?"":("/markers/" + url)
                            , DataSetUtil.RowStringValue(PageDataSource, "title", row)
                            , DateTime.Parse(DataSetUtil.RowStringValue(PageDataSource, "regdate", row)).ToString("yyyy-MM-dd")
                            , DateTime.Parse(DataSetUtil.RowStringValue(PageDataSource, "changedate", row)).ToString("yyyy-MM-dd")
                            , DataSetUtil.RowStringValue(PageDataSource, "api_requests", row)
                            , DataSetUtil.RowStringValue(PageDataSource, "id", row)
                            , strSize
                            );
                        strTable += item; 
                    }
                    else {
                        strTable += strEmptyItem;
                        for(int k = j+1 ; k < 4 ; k++) {
                            strTable += "<td width='280' height='220'></td>";
                        }
                        break;
                    }
                }
                strTable += "</tr></table>";
                string addEmpty;
                if(DataSetUtil.RowCount(PageDataSource) >= 4)
                    addEmpty = "<table cellpadding='0' cellspacing='0' width='1036' align='center'><tbody><tr><td width='1036' height='25'></td></tr></tbody></table>";
                else
                    addEmpty = "<table cellpadding='0' cellspacing='0' width='1036' align='center' height='345'><tbody><tr><td width='1036' height='25'></td></tr></tbody></table>";
                strLtrData += strTable + addEmpty;
            }

            if (DataSetUtil.RowCount(PageDataSource) % 4 == 0)
            {
                string strTable = "<table cellpadding='0' cellspacing='0' align='center' width='1036'> "
                   + "<tr>";
                strTable += strEmptyItem;
                for (int k = 1; k < 4; k++)
                {
                    strTable += "<td width='280' height='307'></td>";
                }
                strTable += "</tr></table>";
                strLtrData += strTable;
            }

            string footerpage = "<table width='1240' style='bottom:0px;' bgcolor='#595959'><tbody><tr><td width='1240' height='40' bgcolor='#595959'><p align='right'  style='margin-top:0px; margin-bottom:0px; '>"
                      + "<b><font face='돋움' color='#FFE4F2' style='padding-right: 10px;'><span style='font-size:10pt;'>powered by coarsoft</span></font><span style='font-size:10pt;'><font face='돋움' color='#CCCCC'></font></span></b>"
                + "<font face='돋움' color='#CCCCCC'><span style='font-size:10pt;'></span></font>"
                + "</p></td></tr></tbody></table>";

            strLtrData += footerpage.Trim();
            ltrData.Text = strLtrData;
        }

        protected override void LoadData()
        {
            base.LoadData();

            if (txtSearchKey.Text.Trim().Length > 0)
            {
                PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents WHERE userid={0} AND CHARINDEX({1}, title) > 0 ORDER BY id",
                    new string[] { "@userid", "@key" },
                    new object[] { AuthUser.ID, txtSearchKey.Text.Trim() }
                );
            }
            else
            {
                PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents WHERE userid={0} ORDER BY id",
                    new string[] { "@userid" },
                    new object[] { AuthUser.ID }
                );
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            PageDataSource = null;
            BindData();
        }

        protected void btnRegCampain_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            if (title.Length == 0)
            {
                ShowMessageBox("컴페인명을 입력하세요.");
                return;
            }
            long content_id = DataSetUtil.GetID(DBConn.RunStoreProcedure(Constants.SP_ADDCONTENT,
            new string[] {
                                "@userid",
                                "@project_id",
                                "@title"
                            },
            new object[] {
                                AuthUser.ID,
                                0,
                                title
                            }));
            DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                new object[] {
                        Constants.EVENT_ADDCAMPAIGN,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
            Response.Redirect("CampainList.aspx");
        }
        
        protected void btnDelCampain_Click1(object sender, EventArgs e)
        {
            long content_id = Int32.Parse(hdCampainID.Value);
            if (content_id < 0)
            {
                ShowMessageBox("비정상적인 접근입니다.", "CampainList.aspx");
                return;
            }

            DataSet dsContent = DBConn.RunSelectQuery("SELECT contents.regdate, GETDATE() AS curdate FROM contents WHERE id={0}",
                new string[] { "@id" }, new object[] { content_id });

            if (DataSetUtil.IsNullOrEmpty(dsContent))
            {
                ShowMessageBox("비정상적인 접근입니다.", "ProjectList.aspx");
                return;
            }

            TimeSpan timeDiff = DateTime.Parse(DataSetUtil.RowStringValue(dsContent, "curdate", 0)) - DateTime.Parse(DataSetUtil.RowStringValue(dsContent, "regdate", 0));
            if (timeDiff.TotalMinutes < 10)
            {
                ShowMessageBox("마커등록중이므로 마커를 삭제할수 없습니다. 잠시후 다시 시도해 주십시오.", "CampainList.aspx");
                return;
            }

            DBConn.RunStoreProcedure(Constants.SP_DELETECONTENT,
                new string[] {
                "@id"                
            },
                new object[] {
                content_id
            });
            DBConn.RunStoreProcedure(Constants.SP_ADDEVENTLOG,
                    new string[] {
                        "@event",
                        "@userid",
                        "@user_ip"
                    },
                    new object[] {
                        Constants.EVENT_DELCAMPAIGN,
                        AuthUser.ID,
                        Request.ServerVariables["REMOTE_ADDR"]
                    });
            RunVUpload("COAR remove " + "star_" + content_id);
            Response.Redirect("CampainList.aspx");
        }
    }
}