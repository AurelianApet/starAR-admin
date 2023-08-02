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
    public partial class m_register : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.Params["userid"]) || string.IsNullOrEmpty(Request.Params["pwd"]))
            {
                return;
            }

            string userid = Request.Params["userid"];
            string pwd = CryptSHA256.Encrypt(Request.Params["pwd"]);

            string email = Request.Params["email"];
            string birth_year = Request.Params["birth_year"];
            string ismarried = Request.Params["married"];
            string sex = Request.Params["sex"];
            string place = Request.Params["place"];


            DataSet dsContent = null;

            string query = "insert into users(loginid, loginpwd, email, birth_year, ismarried, sex, address, contract_mode, regdate, use_product, test_req, user_type) values('"
            + userid + "','" + pwd + "','" + email + "','" + birth_year + "','" + ismarried + "','" + sex + "','" + place + "', '1', '" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "', '0', '0', '0')";

            try
            {
                dsContent = DBConn.RunSelectQuery(query);
                string responseXml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><contents>1</contents>";
                Response.Write(responseXml);
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

        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}