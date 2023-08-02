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
    public partial class m_login : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.Params["userid"]) || string.IsNullOrEmpty(Request.Params["pwd"]))
            {
                return;
            }
            string userid = Request.Params["userid"];
//            string pwd = Request.Params["pwd"];
            string pwd = CryptSHA256.Encrypt(Request.Params["pwd"]);
            
            DataSet dsContent = null;
            string query = "select * from users where loginid='" + userid + "' and loginpwd='" + pwd + "'";
            dsContent = DBConn.RunSelectQuery(query);
            if (!DataSetUtil.IsNullOrEmpty(dsContent))
            {
                try
                {
                    if(dsContent.Tables[0].Rows[0][30].ToString() == "0")
                    {
                        string email = dsContent.Tables[0].Rows[0][20].ToString();
                        string birthyear = dsContent.Tables[0].Rows[0][27].ToString();
                        string sex = dsContent.Tables[0].Rows[0][29].ToString();
                        string married = dsContent.Tables[0].Rows[0][28].ToString();
                        string place = dsContent.Tables[0].Rows[0][7].ToString();

                        string xmlstr = "<?xml version=\"1.0\" encoding=\"utf-8\"?><contents><data>1</data><email>"
                            + email
                            + "</email><birthyear>"
                            + birthyear
                            + "</birthyear><sex>"
                            + sex
                            + "</sex><married>"
                            + married
                            + "</married><place>"
                            + place
                            + "</place>"
                            + "</contents>";
                        query = "update users set contract_mode=1 where loginid='" + userid + "'";
                        dsContent = DBConn.RunSelectQuery(query);
                        Response.Write(xmlstr);
                    }
                    else
                    {
                        StringBuilder responseXml = new StringBuilder();
                        responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                        responseXml.Append("<contents >");
                        responseXml.Append("</contents>");
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
            }
            else
            {
                StringBuilder responseXml = new StringBuilder();
                responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                responseXml.Append("<contents >");
                responseXml.Append("</contents>");
                Response.Write(responseXml.ToString());
            }
        }

        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}