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
    public partial class getXML : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            long IID = 0;
            string server_id;
            //if (string.IsNullOrEmpty(Request.Params["server_id"]) && string.IsNullOrEmpty(Request.Params["content_id"]))
            //{
            //    return;
            //}
            //if (string.IsNullOrEmpty(Request.Params["server_id"]))
            //    IID = Int32.Parse(Request.Params["content_id"]);
            if (string.IsNullOrEmpty(Request.Params["content_id"]))
                return;
            server_id = Request.Params["content_id"];

            string uid = "";
            if (!string.IsNullOrEmpty(Request.Params["uid"]))
                uid = Request.Params["uid"];

            DataSet dsContent = null;
            DataSet dsUsedStatus = null;
            DataSet dsUsedProduct = null;
            DataSet dsContent1 = null;

            try
            {
                dsContent1 = DBConn.RunSelectQuery("SELECT id FROM users WHERE loginid='" + uid + "'");
                if (!DataSetUtil.IsNullOrEmpty(dsContent1))
                    uid = dsContent1.Tables[0].Rows[0][0].ToString();

                //켐페인자료 디비로부터 조회하여 xml을 만들어 내려보낸다.
                dsContent = DBConn.RunSelectQuery("SELECT contents.xml, contents.userid FROM contents WHERE server_id={0}",
                    new string[] { "@server_id" },
                    new object[] { server_id });
                if (!DataSetUtil.IsNullOrEmpty(dsContent))
                {
                    IID = DataSetUtil.RowLongValue(dsContent, "userid", 0);
                    StringBuilder responseXml = new StringBuilder();
                    dsUsedStatus = DBConn.RunSelectQuery("SELECT SUM(api_requests) AS api_requests, SUM(size) AS usedhard, COUNT(*) AS markers FROM contents WHERE userid = {0}",
                    new string[] { "@userid" },
                    new object[] { IID });
                    dsUsedProduct = DBConn.RunSelectQuery("SELECT products.* FROM products INNER JOIN users ON users.use_product = products.id WHERE users.id = {0}",
                        new string[] { "@id" },
                        new object[] { IID });
                    if (DataSetUtil.RowIntValue(dsUsedProduct, "api_requests", 0) <= DataSetUtil.RowIntValue(dsUsedStatus, "api_requests", 0))
                    {
                        //마커갯수가 초과되었다는 xml출력
                        responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                        responseXml.Append("<contents>");
                        responseXml.Append("<apis_over>1</apis_over>");
                        responseXml.Append("</contents>");

                    }
                    else
                    {
                        responseXml.Append(DataSetUtil.RowStringValue(dsContent, "xml", 0));
                    }
                    Response.Write(responseXml.ToString());
                }
            }
            catch (Exception)
            {
                StringBuilder responseXml = new StringBuilder();
                responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                responseXml.Append("<contents >");
                responseXml.Append("</contents>");

                Response.Write(responseXml.ToString());
            }

            //api_requests API요청수 증가시키는 부분
            if (!string.IsNullOrEmpty(Request.Params["isscan"]) && Request.Params["isscan"] == "1")
            {
                DBConn.RunUpdateQuery("UPDATE contents SET api_requests=api_requests+1 WHERE server_id={0}",
                new string[] { "@server_id" },
                new object[] { server_id });

                //컨텐츠 사용내역에 추가한다.
                string query  = "SELECT id FROM contents WHERE server_id='" + server_id + "'";
                string contentid = DBConn.RunSelectQuery(query).Tables[0].Rows[0][0].ToString();

                query = "INSERT INTO contentsusehist (userid, contentid) values('" + uid + "', '" + contentid + "')"  ;
                DBConn.RunInsertQuery(query);

/*
                DBConn.RunInsertQuery("INSERT INTO contentsusehist (userid, contentid) values('" + uid + "',  SELECT id FROM contents WHERE (server_id = {0}))",
                    new string[] { "@server_id" },
                    new object[] { server_id });
 */
            }            
        }
        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}