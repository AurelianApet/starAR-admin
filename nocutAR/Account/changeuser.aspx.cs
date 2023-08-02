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
    public partial class changeuser : Common.PageBase
    {
        private bool IsExist(string id)
        {
            DataSet dsContent = null;
            string query = "select * from users where loginid='" + id + "'";

            dsContent = DBConn.RunSelectQuery(query);
            if (DataSetUtil.IsNullOrEmpty(dsContent))
            {
                return false;
            }
            return true;
        }
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = System.Text.Encoding.UTF8;

            bool fieldMes = false;
            bool pwdMes = false;
            string pwd = CryptSHA256.Encrypt(Request.Params["pwd"]);
            bool proMes = false;
            bool emailMes = false;
            string email = Request.Params["email"];
            string id = "";
            if (string.IsNullOrEmpty(Request.Params["id"]) || string.IsNullOrEmpty(Request.Params["pwd"]) || string.IsNullOrEmpty(Request.Params["email"]) || string.IsNullOrEmpty(Request.Params["birthyear"])
                || string.IsNullOrEmpty(Request.Params["married"]) || string.IsNullOrEmpty(Request.Params["sex"]) || string.IsNullOrEmpty(Request.Params["place1"]) || string.IsNullOrEmpty(Request.Params["place2"]))
            {
                fieldMes = true;
                return;
            }
            else if (Request.Params["pwd"].Length < 6)
            {
                pwdMes = true;
            }
            else if(email.IndexOf("@") == -1 || email.IndexOf(".") == -1)
            {
                emailMes = true;
            }
            else
            {
                id = Request.Params["id"];
                string birthyear = Request.Params["birthyear"];
                string married = Request.Params["married"];
                int ismarried = 0;
                if (married == "기혼")
                    ismarried = 1;

                int sex = 1;
                string sexstr = Request.Params["sex"];
                if (sexstr == "여자")
                    sex = 0;
                string place = Request.Params["place1"] + " " + Request.Params["place2"];

                DataSet dsContent = null;

                string query = "update users set loginpwd='" + pwd + "', email='" + email + "', birth_year='" + birthyear + "', ismarried='" + ismarried + "', sex='" + sex + "', address='" + place + "' where loginid='" +  id + "'";

                try
                {
                    dsContent = DBConn.RunSelectQuery(query);
                }
                catch (Exception)
                {
                    proMes = true;
                    //                Response.Write("<script>alert('유저변경과정에 알지 못할 오류가 발생했습니다.')</script>");
                }

            }
            string strItemFormat = "{{\"fieldMes\":\"{0}\", " +
                           "\"pwdMes\":\"{1}\", " +
                           "\"emailMes\":\"{2}\", " +
                           "\"proMes\":\"{3}\" " +
                           "}}";

            string strData = string.Format(strItemFormat,
            fieldMes, pwdMes, emailMes, proMes);

            Response.Write(strData);
            Response.End();
        }

        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}