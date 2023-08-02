﻿using System;
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
    public partial class detailContent : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.Params["id"]))
                {
                    ShowMessageBox("잘못된 접근입니다.", "CampainList.aspx");
                    return;
                }
                int id = Int32.Parse(Request.Params["id"]);
                
                PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents WHERE userid={0} AND id={1}",
                    new string[] { "@userid", "@id" },
                    new object[] { AuthUser.ID, id }
                    );
                if (DataSetUtil.IsNullOrEmpty(PageDataSource))
                {
                    ShowMessageBox("잘못된 접근입니다.", "CampainList.aspx");
                    return;
                }

                outputRes2JS(
                    new string[] {
                        "USER_ID",
                        "CONTENT_ID",
                        "SERVER_ID",
                        "CAMPAIN_NAME"
                    },
                    new string[] {
                        AuthUser.ID.ToString(),
                        id.ToString(),
                        DataSetUtil.RowStringValue(PageDataSource,"server_id",0),
                        DataSetUtil.RowStringValue(PageDataSource,"title",0)
                    }
                );
            }
        }

        protected void btnRenameCampain_Click(object sender, EventArgs e)
        {
            string name = RenameCampainText.Text.Trim();
            if (name.Length == 0)
            {
                ShowMessageBox("변경할 컴페인명을 입력하세요.");
                return;
            }

            if (string.IsNullOrEmpty(Request.Params["id"]))
            {
                ShowMessageBox("잘못된 접근입니다.", "CampainList.aspx");
                return;
            }
            int id = Int32.Parse(Request.Params["id"]);
            try
            {
                string query = "Update contents set title='" + Convert.ToString(name) + "' WHERE id='" + Convert.ToString(id) + "'";
                DBConn.RunSelectQuery(query);
            }
            catch(Exception)
            {

            }

            Response.Redirect("detailContent.aspx?id=" + Convert.ToString(id));
        }

        public void outputRes2JS(string[] strNames, string[] strValues)
        {
            if (strNames.Length != strValues.Length)
                return;

            string strRet = "<script language=\"javascript\" type=\"text/javascript\">\n";
            for (int i = 0; i < strNames.Length; i++)
            {
                strRet += "var " + strNames[i] + " = \"" + strValues[i] + "\";\n";
            }
            strRet += "</script>";

            ltlScript.Text += strRet;
        }
    }
}