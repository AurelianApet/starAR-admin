<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="nocutAR.Account.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Scripts/jquery-1.11.2.js"></script>
    <script type="text/javascript" language="javascript">
//        var STR_LOGINID = "아이디";
//        var STR_LOGINPWD = "12345678";
//        $(document).ready(function () {
//            $(".textEntry").focus(function () {
//                var oldValue = $(this).attr("value");
//                if (oldValue == STR_LOGINID) {
//                    $(this).val("");
//                }
//            });
//            $(".textEntry").blur(function () {
//                var oldValue = $(this).attr("value");
//                if (oldValue == "" || oldValue == STR_LOGINID) {
//                    $(this).val(STR_LOGINID);
//                }
//            });
//            $(".passwordEntry").focus(function () {
//                var oldValue = $(this).attr("value");
//                if (oldValue == STR_LOGINPWD) {
//                    $(this).val("");
//                }
//            });

//            $(".passwordEntry").blur(function () {
//                var oldValue = $(this).attr("value");
//                if (oldValue == "" || oldValue == STR_LOGINPWD) {
//                    $(this).val(STR_LOGINPWD);
//                    //$(this).css("color", "#CCCCCC");
//                }
//            });
//            $(".textEntry").blur();
//            $(".passwordEntry").blur();
        //        });
        function na_restore_img_src(name, nsdoc) {
            var img = eval((navigator.appName.indexOf('Netscape', 0) != -1) ? nsdoc + '.' + name : 'document.all.' + name);
            if (name == '')
                return;
            if (img && img.altsrc) {
                img.src = img.altsrc;
                img.altsrc = null;
            }
        }

        function na_preload_img() {
            var img_list = na_preload_img.arguments;
            if (document.preloadlist == null)
                document.preloadlist = new Array();
            var top = document.preloadlist.length;
            for (var i = 0; i < img_list.length - 1; i++) {
                document.preloadlist[top + i] = new Image;
                document.preloadlist[top + i].src = img_list[i + 1];
            }
        }

        function na_change_img_src(name, nsdoc, rpath, preload) {
            var img = eval((navigator.appName.indexOf('Netscape', 0) != -1) ? nsdoc + '.' + name : 'document.all.' + name);
            if (name == '')
                return;
            if (img) {
                img.altsrc = img.src;
                img.src = rpath;
            }
        }

    </script>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>로그인</title>
    <meta name="generator" content="Namo WebEditor v6.0" />
</head>
<body>
    <form id="form1" runat="server">      
        <table cellpadding="0" cellspacing="0" width="100%" height="100%" bgcolor="#F3F4F6">    
            <tr>
        <td width="100%">

            <table cellpadding="0" cellspacing="0" width="400" align="center" bgcolor="#83A0F3" height="400" background="IMG/_0010_로그인창.png">
                <tr>
                    <td width="400" height="28" colspan="2">
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td width="400" height="71" colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td width="400" height="49" colspan="2">
                        <p align="center">&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td width="400" height="51" colspan="2">
                        <table cellpadding="0" cellspacing="0" width="300" align="center" bgcolor="white">
                            <tr>
                                <td width="300" height="40" align="center" class="textinput">
                                    <asp:TextBox ID="tbxUserName" runat="server" CssClass="textEntry" MaxLength="20" placeholder="ID" Text=""></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="400" height="54" colspan="2">
                        <table cellpadding="0" cellspacing="0" width="300" align="center" bgcolor="white">
                            <tr>
                                <td width="300" height="40" align="center" class="textinput">
                                    <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password" placeholder="Password"  MaxLength="50" Text="" ></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="400" height="66" colspan="2" align="center">
                        <asp:Button ID="LoginButton" runat="server" CommandName="login" 
                                                    ValidationGroup="LoginUserValidationGroup" CssClass="clsLoginButton"
                                                    OnClick="btnLogin_Click" />                    
                    </td>
                </tr>
                <tr height="20">
                    <td width="200" height="40" align="center">
                        <asp:CheckBox ID="chkAutoLogin" runat="server"/>
                        <asp:Label ID="Label3" runat="server" AssociatedControlID="chkAutoLogin" CssClass="inline" Font-Size="11pt" Font-Names="SpoqaHanSans" ForeColor="#FFFFFF">자동로그인</asp:Label>                        
                    </td>
                    <td width="200" height="40" align="center">
                        <asp:CheckBox ID="chkRememberMe" runat="server" />
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="chkRememberMe" CssClass="inline" Font-Size="11pt" Font-Names="SpoqaHanSans" ForeColor="#FFFFFF">아이디저장</asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        </tr>
        </table>        
    </form>
</body>
</html>
