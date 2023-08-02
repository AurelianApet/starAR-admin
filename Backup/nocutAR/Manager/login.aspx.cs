﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using nocutAR.Common;
using DataAccess;

namespace nocutAR.Manager
{
    public partial class login : Common.PageBase
    {
        protected override void Page_Init(object sender, EventArgs e)
        {
        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            //아이디저장쿠키가 있다면
            if (!IsPostBack)
            {
                if (Request.Cookies[Constants.COOKIE_KEY_REMEBERID] != null)
                {
                    string strCookie = Request.Cookies[Constants.COOKIE_KEY_REMEBERID][Constants.COOKIE_KEY_REMEBERID];
                    strCookie = CryptSHA256.Decrypt(strCookie);
                    string[] arrTemp = strCookie.Split(';');
                    if (arrTemp.Length == 2)
                    {
                        UserName.Text = arrTemp[1].ToString();
                        chkRememberMe.Checked = true;
                    }

                }
            }

            //자동로그인쿠키가 있다면
            if (Request.Cookies[Constants.COOKIE_KEY_AUTOLOGIN] != null)
            {
                if (AuthUser != null)
                    Response.Redirect(Defines.URL_PREFIX_MANAGE + "/MemberMng.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (chkRememberMe.Checked)
            {
                isRememberMe = true;
            }
            else
            {
                isRememberMe = false;
            }
            if (chkAutoLogin.Checked)
            {
                isAutoLogin = true;
            }
            else
            {
                isAutoLogin = false;
            }
            if (string.IsNullOrEmpty(UserName.Text))
            {
                ShowMessageBox(Resources.Err.ERR_LOGINID_INPUT);
                return;
            }
            if (string.IsNullOrEmpty(Password.Text))
            {
                ShowMessageBox(Resources.Err.ERR_LOGINPWD_INPUT);
                return;
            }

            if (!UserLogin(UserName.Text, Password.Text))
            {
                ShowMessageBox(Resources.Err.ERR_LOGIN_FAILED);
                return;
            }
            else
            {
                Response.Redirect(Defines.URL_PREFIX_MANAGE + "/MemberMng.aspx");
            }
        }

    }
}