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
    public partial class addnewuser : Common.PageBase
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

            int type = 0;
            string id = "", pwd = "", email = "";
            if (string.IsNullOrEmpty(Request.Params["id"]) || string.IsNullOrEmpty(Request.Params["pwd"]) || string.IsNullOrEmpty(Request.Params["email"]) || string.IsNullOrEmpty(Request.Params["birthyear"])
                || string.IsNullOrEmpty(Request.Params["married"]) || string.IsNullOrEmpty(Request.Params["sex"]) || string.IsNullOrEmpty(Request.Params["place1"]) || string.IsNullOrEmpty(Request.Params["place2"]))
            {
//                ShowMessageBox("모든 마당을 정확히 입력하세요.");
                type = 1;
//                return;
            }

            if(type == 0)
            {
                id = Request.Params["id"];
                if (IsExist(id))
                {
                    type = 2;
//                    ShowMessageBox("동일한 아이디가 이미 존재합니다.");
//                    return;
                }
            }

            if(type == 0)
            {
                if (Request.Params["pwd"].Length < 6)
                {
                    type = 3;
//                    ShowMessageBox("비밀번호는 6자리이상 영문자, 숫자를 입력하십시오.");
//                    return;
                }
            }

            if(type == 0)
            {
                pwd = CryptSHA256.Encrypt(Request.Params["pwd"].ToString());
                email = Request.Params["email"];
                if (email.IndexOf("@") == -1 || email.IndexOf(".") == -1)
                {
                    type = 4;
//                    ShowMessageBox("이메일을 정확히 입력하십시오");
//                    return;
                }
            }

            if(type == 0)
            {
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

                string query = "insert into users(loginid, loginpwd, email, birth_year, ismarried, sex, address, contract_mode, regdate, use_product, test_req, user_type) values('"
                    + id + "','" + pwd + "','" + email + "','" + birthyear + "','" + ismarried + "','" + sex + "','" + place + "', '1', '" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + "', '0', '0', '0')";

                try
                {
                    dsContent = DBConn.RunSelectQuery(query);
                }
                catch (Exception)
                {
                    type = 5;
//                    ShowMessageBox("유저등록과정에 알지 못할 오류가 발생했습니다.");
                }
            }

            string str = "{\"type\":" + "\"" + type + "\"}";
            Response.Write(str);
            Response.End();
        }

        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}