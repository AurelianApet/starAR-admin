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
    public partial class getdetailuser : Common.AjaxPageBase
    {
        private int GetExcCount(string id, string userid)
        {
            try
            {
                DataSet dsContent1 = DBConn.RunSelectQuery("SELECT count(*) FROM contentsusehist WHERE contentid = '" + id + "' and userid = '" + userid + "'");
                int count = Convert.ToInt32(dsContent1.Tables[0].Rows[0][0].ToString());
                return count;
            }
            catch(Exception)
            {
                return 0;
            }
        }

        private string GetContentTitle(string id)
        {
            try
            {
                DataSet dsContent1 = DBConn.RunSelectQuery("SELECT title FROM contents WHERE id = '" + id + "'");
                string title = dsContent1.Tables[0].Rows[0][0].ToString();
                return title;
            }
            catch(Exception)
            {
                return "";
            }
        }

        private string GetContentDatetime(string id)
        {
            try
            {
                DataSet dsContent1 = DBConn.RunSelectQuery("SELECT regdate FROM contents WHERE id = '" + id + "'");
                string content_datetime = dsContent1.Tables[0].Rows[0][0].ToString();

                return content_datetime;
            }
            catch(Exception)
            {
                return "";
            }
        }
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            DataSet dsContent = null;
            string strData = null;
            string strData1 = null;
            string uid = Request.Params["uid"];
            string id = "";
            string ismarried = "";
            string sex = "";
            string pwd = "";
            try
            {
                dsContent = DBConn.RunSelectQuery("SELECT * FROM users WHERE user_type=0 and loginid = '" + uid + "'");

                id = DataSetUtil.RowStringValue(dsContent, "id", 0);

                if (DataSetUtil.RowIntValue(dsContent, "ismarried", 0) == 1)
                    ismarried = "기혼";
                else
                    ismarried = "미혼";

                if (DataSetUtil.RowIntValue(dsContent, "sex", 0) == 1)
                    sex = "남자";
                else
                    sex = "여자";
            }            
            catch(Exception)
            {

            }

            try{
                if(DataSetUtil.RowStringValue(dsContent, "loginpwd", 0) != "")
                {
                    pwd = CryptSHA256.Decrypt(DataSetUtil.RowStringValue(dsContent, "loginpwd", 0));
                }
            }
            catch(Exception)
            {

            }
            try{
                if (!DataSetUtil.IsNullOrEmpty(dsContent))
                {
                    string strItemFormat = "{{\"email\":\"{0}\", " + "\"birth_year\":\"{1}\", " +  "\"married\":\"{2}\", " +
                                       "\"sex\":\"{3}\", " +    "\"pwd\":\"{4}\", " + "\"address\":\"{5}\" " +
                                       "}}";

                    strData = string.Format(strItemFormat,
                        DataSetUtil.RowStringValue(dsContent, "email", 0),
                        DataSetUtil.RowStringValue(dsContent, "birth_year", 0),
                        ismarried,
                        sex,
                        pwd,
                        DataSetUtil.RowStringValue(dsContent, "address", 0));
                }

                DataSet dsContent1 = DBConn.RunSelectQuery("SELECT DISTINCT contentid AS some_alias FROM contentsusehist WHERE userid = '" + id + "'");
                
                int count = dsContent1.Tables[0].Rows.Count;

                if(count > 0)
                {
                    string strItemFormat = "";
                    strData1 = "\"detailData\":[";
                    if(count >= 1)
                    {
                        string strtitle;
                        string strregdate;
                        string strrequest;
                        for (int i = 0; i < count - 1; i++)
                        {
                            strtitle = "\"title" + "\"";
                            strregdate = "\"regdate" + "\"";
                            strrequest = "\"request" + "\"";
                            strItemFormat += "{" + strtitle + ":" + "\"" + GetContentTitle(dsContent1.Tables[0].Rows[i][0].ToString()) + "\"" + ", "
                                + strregdate + ":" + "\"" + GetContentDatetime(dsContent1.Tables[0].Rows[i][0].ToString()) + "\"" + ", "
                                + strrequest + ":" + "\"" + GetExcCount(dsContent1.Tables[0].Rows[i][0].ToString(), id) + "\"" + "}, ";
                        }
                        strData1 += strItemFormat;
                        strData1 += "{" + "\"title" + "\"" + ":" + "\"" + GetContentTitle(dsContent1.Tables[0].Rows[count - 1][0].ToString()) + "\"" + ", "
                            + "\"regdate" + "\"" + ":" + "\"" + GetContentDatetime(dsContent1.Tables[0].Rows[count - 1][0].ToString()) + "\"" + ", "
                            + "\"request" + "\"" + ":" + "\"" + GetExcCount(dsContent1.Tables[0].Rows[count - 1][0].ToString(), id) + "\"" + " }]}";
                    }
                    else
                    {
                        string strtitle = "title";
                        string strregdate = "regdate";
                        string strrequest = "request";
                        strItemFormat = "\"detailData\":[" + "{" + "\"" + strtitle + "\"" + ":" + "\"" + GetContentTitle(dsContent1.Tables[0].Rows[0][0].ToString()) + "\"" + ", "
                            + "\"" + strregdate + "\"" + ":" + "\"" + GetContentDatetime(dsContent1.Tables[0].Rows[0][0].ToString()) + "\"" + ", "
                            + "\"" + strrequest + "\"" + ":" + "\"" + GetExcCount(dsContent1.Tables[0].Rows[0][0].ToString(), id) + "\"" + "}]}";
                        strData1 = strItemFormat;
                    }
                    strData = strData.Replace(" }", ",") + strData1;
                }
            }
            catch(Exception)
            {

            }

            Response.Write(strData);
            Response.End();
        }
    }
}