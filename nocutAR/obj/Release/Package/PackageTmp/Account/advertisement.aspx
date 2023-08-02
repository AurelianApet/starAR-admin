<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true"
    CodeBehind="advertisement.aspx.cs" Inherits="nocutAR.Account.advertisement" %>

<asp:Content ID="Content10" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/toolbar.js" type="text/javascript"></script>
    <link href="/Styles/Account.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#adv_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(93,129,236); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');
            $("#campain_menu1").html('캠페인');
            $("#stat_menu1").html('통계');
            $("#adv_menu1").html('<b>광고</b>');
            if (!$("#StartDate1") && !$("#EndDate1"))
                $("#unlimitedTime1").checked = true;
            $("#campain_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(235,235,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');
            $("#stat_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(235,235,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');
            
            if ($("#<%=unlim1.ClientID%>").val() == '1')
            { 
                document.getElementById("unlimitedTime1").checked = "checked";
                $("#<%= StartDate1.ClientID  %>").val('');
                $("#<%= EndDate1.ClientID  %>").val('');
            }
            if ($("#<%=unlim2.ClientID%>").val() == '1') {
                document.getElementById("unlimitedTime2").checked = "checked";
                $("#<%= StartDate2.ClientID  %>").val('');
                $("#<%= EndDate2.ClientID  %>").val('');
            }

        });

        function onBanner()
        {
            document.getElementById("FullADDiv").innerHTML = "<span style='font-size:12pt;'>FULL AD</span>";
            document.getElementById("BannerDiv").innerHTML = "<span style='font-size:12pt;'><b>Banner</b></span>";
            document.getElementById("viewBanner").style = "";
            document.getElementById("viewFullAD").style = "display:none";
        }

        function onFullAD()
        {
            document.getElementById("FullADDiv").innerHTML = "<span style='font-size:12pt;'><b>FULL AD</b></span>";
            document.getElementById("BannerDiv").innerHTML = "<span style='font-size:12pt;'>Banner</span>";
            document.getElementById("viewFullAD").style = "";
            document.getElementById("viewBanner").style = "display:none";
        }

        function onCancel_Banner()
        {
            document.getElementById("adv_name2").value = "";
            document.getElementById("adv_master2").value = "";
//            document.getElementById("period_start2").value = "";
//            document.getElementById("period_end2").value = "";
            document.getElementById("adv_file_text2").value = "";
            $("#<%= StartDate2.ClientID  %>").val('');
            $("#<%= EndDate2.ClientID  %>").val('');
            $("#<%=Liter_imageurl2%>").html('');
            document.getElementById("image2").src = "";

        }

        function onPost_Banner()
        {
            if ($("#adv_file2").val() == "") {
                alert("광고이미지를 지정하세요.");
                return false;
            }

            if (!checkImgExtention("adv_file2", "img")) {
                return false;
            }
            var file = document.getElementById("adv_file2");
            if (file.files[0] != null) {
                if ((file.files[0].size / 1053317.6) > 5) {
                    alert("5MB 이상의 이미지는 등록하실수 없습니다.");
                    return false;
                }
                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                // add the file intended to be upload to the created FormData instance
                data.append("upfile", file.files[0]);
//                setTimeout(function () {
                    $.ajax({
                        url: 'PostUpload.aspx?type=20',
                        type: "post",
                        data: data,
                        // cache: false,
                        processData: false,
                        contentType: false,
                        async: false,
                        success: function (data, textStatus, jqXHR) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            HideProgress();
                            alert("광고이미지 등록과정에 오류가 발생하였습니다.");
                        }
                    });
//                }, 500);
            }

            var adv_name = document.getElementById("adv_name2").value;
            var adv_master = document.getElementById("adv_master2").value;
//            var period_start = document.getElementById("period_start2").value;
//            var period_end = document.getElementById("period_end2").value;
            var filename = document.getElementById("adv_file_text2").value;
            var starttime = $("#<%= StartDate2.ClientID  %>").val();
            var endtime = $("#<%= EndDate2.ClientID  %>").val();

            var unlimited;
            if (document.getElementById("unlimitedTime2").checked == true) {
                unlimited = 1;
            }
            else {
                unlimited = 0;
            }

            var url = "saveAdvertisement.aspx?adv_name=" + adv_name + "&adv_master=" + adv_master + "&period_start=" + starttime +
                "&period_end=" + endtime + "&file=" + filename + "&type=2&unlimited=" + unlimited;

            $.ajax({
                url: url,
                type: "post",
                processData: false,
                contentType: false,
                async: false,
                success: function (data, textStatus, jqXHR) {
                    alert("성공적으로 등록되었습니다.");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("광고이미지 등록과정에 오류가 발생하였습니다.");
                }
            });

        }

        function onPost_AD() {
            if ($("#adv_file1").val() == "") {
                alert("광고이미지를 지정하세요.");
                return false;
            }

            if (!checkImgExtention("adv_file1", "img")) {
                return false;
            }
            var file = document.getElementById("adv_file1");
            if (file.files[0] != null) {
                if ((file.files[0].size / 1053317.6) > 5) {
                    alert("5MB 이상의 이미지는 등록하실수 없습니다.");
                    return false;
                }
                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                // add the file intended to be upload to the created FormData instance
                data.append("upfile", file.files[0]);
//                setTimeout(function () {
                    $.ajax({
                        url: 'PostUpload.aspx?type=20',
                        type: "post",
                        data: data,
                        // cache: false,
                        processData: false,
                        contentType: false,
                        async: false,
                        success: function (data, textStatus, jqXHR) {
//                            alert("abc");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            HideProgress();
                            alert("광고이미지 등록과정에 오류가 발생하였습니다.");
                        }
                    });
//                }, 500);
            }
            var adv_name = document.getElementById("adv_name1").value;
            var adv_master = document.getElementById("adv_master1").value;
//            var period_start = document.getElementById("period_start1").value;
//            var period_end = document.getElementById("period_end1").value;
            var filename = document.getElementById("adv_file_text1").value;
            var starttime = $("#<%= StartDate1.ClientID  %>").val();
            var endtime = $("#<%= EndDate1.ClientID  %>").val();
            
            var unlimited;
            if (document.getElementById("unlimitedTime1").checked == true)
            {
                unlimited = 1;
            }
            else
            {
                unlimited = 0;
            }

            var url = "saveAdvertisement.aspx?adv_name=" + adv_name + "&adv_master=" + adv_master + "&period_start=" + starttime +
                "&period_end=" + endtime + "&file=" + filename + "&type=1&unlimited=" + unlimited;

            $.ajax({
                url: url,
                type: "post",
                processData: false,
                contentType: false,
                async: false,
                success: function (data, textStatus, jqXHR) {
                    alert("성공적으로 등록되었습니다.");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("광고이미지 등록과정에 오류가 발생하였습니다.");
                }
            });
        }

        function onCancel_AD() {
            document.getElementById("adv_name1").value = "";
            document.getElementById("adv_master1").value = "";
            $("#<%= StartDate1.ClientID  %>").val('');
            $("#<%= EndDate1.ClientID  %>").val('');
//            document.getElementById("period_start1").value = "";
//            document.getElementById("period_end1").value = "";
            document.getElementById("adv_file_text1").value = "";

            document.getElementById("image1").src = "";
            //            $("#<%=Liter_imageurl1%>").attr("style","display:none");

        }

        function delAdvertisement1()
        {
            var url = "delAdvertisement.aspx?type=1";
            $.ajax({
                url: url,
                type: "post",
                processData: false,
                contentType: false,
                async: false,
                success: function (data, textStatus, jqXHR) {
                    alert("성공적으로 삭제되었습니다.");
                    closePopup();
                    onCancel_AD();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("삭제과정에 오류가 발생하였습니다.");
                    closePopup();
                }
            });
        }

        function delAdvertisement2() {
            var url = "delAdvertisement.aspx?type=2";
            $.ajax({
                url: url,
                type: "post",
                processData: false,
                contentType: false,
                async: false,
                success: function (data, textStatus, jqXHR) {
                    alert("성공적으로 삭제되었습니다.");
                    closePopup();
                    onCancel_Banner();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("삭제과정에 오류가 발생하였습니다.");
                    closePopup();
                }
            });
        }

        function del_Banner()
        {
            showPopup("delAdver2");
        }

        function del_FullAD()
        {
            showPopup("delAdver1");
        }

        function onUnlimitedTime1()
        {
            if (document.getElementById("unlimitedTime1").checked == true)
            {
                $("#<%= StartDate1.ClientID  %>").hide(true);
                $("#<%= EndDate1.ClientID  %>").hide(true);

                $("#<%= StartDate1.ClientID  %>").val('');
                $("#<%= EndDate1.ClientID  %>").val('');

//                document.getElementById("period_start1").disabled = true;
//                document.getElementById("period_end1").disabled = true;
            }
            else {
                $("#<%= StartDate1.ClientID  %>").show(true);
                $("#<%= EndDate1.ClientID  %>").show(true);
            }
        }

        function onUnlimitedTime2() {
            if (document.getElementById("unlimitedTime2").checked == true)
            {
                $("#<%= StartDate2.ClientID  %>").hide(true);
                $("#<%= EndDate2.ClientID  %>").hide(true);

                $("#<%= StartDate2.ClientID  %>").val('');
                $("#<%= EndDate2.ClientID  %>").val('');
            }
            else
            {
                $("#<%= StartDate2.ClientID  %>").show(true);
                $("#<%= EndDate2.ClientID  %>").show(true);
            }
        }

        function readURL1(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#image1').attr('src', e.target.result);
                    $('#image1').attr('style', 'width:100%;height:100%');
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function readURL2(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#image2').attr('src', e.target.result);
                    $('#image2').attr('style', 'width:100%;height:100%');
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>
</asp:Content>

    <asp:Content ID="Content11" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <table cellpadding="0" cellspacing="0" align="center" width="1240" style="border-collapse: collapse;">
            <tr>
                <td width="1240" height="849" valign="top">
                    <table cellpadding="0" cellspacing="0" width="1240" height="100%">
                        <tbody><tr>
                            <td width="250" valign="top" bgcolor="#F9FAFE" height="883" style="border-width:1; border-right-color:rgb(235,235,235); border-top-style:none; border-right-style:solid; border-bottom-style:none; border-left-style:none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="230" style="border-collapse:collapse;">
                                    <tbody><tr>
                                        <td width="230" height="75" style="border-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(235,235,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;" align="center">
                                            <a onclick="onFullAD()" style="cursor:pointer">
                                                <div id="FullADDiv"><font face="돋움" color="#777777"><span style="font-size:12pt;"><b>FULL AD</b></span></font></div>
                                                <input type="hidden" id="unlim1" runat="server" value="0" />
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="230" height="75" style="border-width:1; border-top-color:rgb(235,235,235); border-right-color:black; border-bottom-color:rgb(235,235,235); border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:solid; border-left-style:none;" align="center">
                                            <a onclick="onBanner()" style="cursor:pointer">
                                                <div id="BannerDiv"><font face="돋움" color="#777777"><span style="font-size:12pt;">BANNER</span></font></div>
                                                <input type="hidden" id="unlim2" runat="server" value="0" />
                                            </a>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                            <td width="950" valign="top" height="883" style="background-color:#FFFFFF">
                                <div id = "viewFullAD">
                                    <table style = "width:100%;height:100%;align-items:center">
                                        <td width = "948" valign = "top" height = "883">
                                             <table cellpadding = "0" cellspacing = "0" width = "891" align = "center">
                                                  <tbody><tr>
                                                     <td width = "891"> &nbsp;</td>
                                                    </tr>
                                                   </tbody></table>
                                                <p> &nbsp;</p>
                                             <table cellpadding = "0" cellspacing = "0" width = "880" align = "center">
                                                <tbody><tr>
                                                    <td width = "420" height = "578" bgcolor = "#E5E5E5">
                                                        <div style = "width:415px; height:578px; overflow:hidden; margin:1px; position:relative">
                                                            <asp:Literal runat="server" ID="Liter_imageurl1"></asp:Literal>
                                                        </div>
                                                    </td>
                                                    <td width = "460" height = "578">
                                                        <div align = "right">
                                                            <table cellpadding = "0" cellspacing = "0" width = "425">
                                                                <tbody><tr>
                                                                    <td width = "425" height = "55">
                                                                        <a onclick = "del_FullAD();" style = "cursor:pointer">
                                                                            <img src = "IMG/_0009_trashcan.png" border = "0" align = "right" width = "41" height = "41" alt = "" />
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                            <table cellpadding = "0" cellspacing = "0" width = "420" style = "border-collapse:collapse;">
                                                                <tbody><tr>
                                                                    <td width = "418" height = "42" bgcolor = "#666666" style = "border-width:1; border-color:white; border-style:solid;">
                                                                        <p align = "left"><span style = "font-size:11pt;"><b><font face = "돋움" color = "#CCCCCC"> &nbsp; &nbsp; &nbsp; 광고명 </font></b></span></p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width = "418" height = "85" style = "border-width:1; border-color:white; border-style:solid;" bgcolor = "#F1F2F6" align = "center">
                                                                         <asp:Literal runat="server" ID="Liter_name1"></asp:Literal>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                            <table cellpadding = "0" cellspacing = "0" width = "420" style = "border-collapse:collapse;">
                                                                <tbody><tr>
                                                                    <td width = "418" height = "42" bgcolor = "#666666" style = "border-width:1; border-color:white; border-style:solid;">
                                                                        <p align = "left"><span style = "font-size:11pt;"><b><font face = "돋움" color = "#CCCCCC"> &nbsp; &nbsp; &nbsp; 광고주 </ font></ b></ span></ p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width = "418" height = "85" style = "border-width:1; border-color:white; border-style:solid;" bgcolor = "#F1F2F6" align = "center">
                                                                         <asp:Literal runat="server" ID="Liter_master1"></asp:Literal>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                            <table cellpadding = "0" cellspacing = "0" width = "420" style = "border-collapse:collapse;">
                                                                <tbody><tr>
                                                                    <td width = "418" height = "42" bgcolor = "#666666" style = "border-width:1; border-color:white; border-style:solid;">
                                                                        <p align = "left"><span style = "font-size:11pt;"><b><font face = "돋움" color = "#CCCCCC"> &nbsp; &nbsp; &nbsp; 노출기간 </ font></ b></ span></ p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width = "418" height = "85" style = "border-width:1; border-color:white; border-style:solid;" bgcolor = "#F1F2F6">
                                                                        <table cellpadding = "0" cellspacing = "0" align = "center" width = "388">
                                                                            <tbody><tr>
                                                                                <td width = "139" height = "41">
                                                                                    <asp:TextBox ID="StartDate1" runat="server" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="130px"></asp:TextBox>
                                                                                    <ajax:CalendarExtender ID="cldStartDate1" runat="server" TargetControlID="StartDate1" Format="yyyy-MM-dd" />
<!--                                                                                     <asp:Literal runat="server" ID="Liter_start1"></asp:Literal>-->
                                                                                </td>
                                                                                <td width = "32" height = "41">
                                                                                    <p align = "center"> ~</p>
                                                                                </td>
                                                                                <td width = "138" height = "41">
                                                                                    <asp:TextBox ID="EndDate1" runat="server" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="130px"></asp:TextBox>
                                                                                    <ajax:CalendarExtender ID="cldEndDate1" runat="server" TargetControlID="EndDate1"
                                                                                        Format="yyyy-MM-dd" />
<!--                                                                                    <asp:Literal runat="server" ID="Liter_end1"></asp:Literal>
-->
                                                                                </td>
                                                                                <td width = "79" height = "41">
                                                                                    <p align = "right">
                                                                                        <input type = "checkbox" id = "unlimitedTime1" onclick = "onUnlimitedTime1()" name = "formcheckbox1" />
                                                                                        <span style = "font-size:11pt;"><font face = "돋움" color = "#666666"> 무기한 </ font></ span>
                                                                                    </p>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody></table>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                            <table cellpadding = "0" cellspacing = "0" width = "420" style = "border-collapse:collapse;">
                                                                <tbody><tr>
                                                                    <td width = "418" height = "42" bgcolor = "#666666" style = "border-width:1; border-color:white; border-style:solid;">
                                                                        <p align = "left"><span style = "font-size:11pt;"><b><font face = "돋움" color = "#CCCCCC"> &nbsp; &nbsp; &nbsp; 파일 </ font></ b></ span></ p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width = "418" height = "97" style = "border-width:1; border-color:white; border-style:solid;" bgcolor = "#F1F2F6">
                                                                        <table cellpadding = "0" cellspacing = "0" align = "center" width = "382">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td width = "289" height = "43">
                                                                                        <div align = "left">
                                                                                             <asp:Literal runat="server" ID="Liter_imgurl1"></asp:Literal>
                                                                                        </div>
                                                                                    </td>
                                                                                    <td width = "93" height = "43">
                                                                                        <table cellpadding = "0" cellspacing = "0">
                                                                                            <tbody><tr>
                                                                                                <td width = "85" height = "28" style = "border-width:1; border-color:black; border-style:none;" bgcolor = "#999999">
                                                                                                    <input id = "adv_file1" type = "file" name = "" accept = "image/png, image/jpeg" class="clsBrowser" style="display: none" 
                                                                                                    size="35" onchange="document.getElementById('adv_file_text1').value=this.value; readURL1(this);" />
                                                                                                    <a onclick = "javascript:OnBrowse('adv_file1')" style="cursor: pointer;">
                                                                                                        <img id = "btnSelectFile1" class="" src="IMG/bt_file.png" alt="" />
                                                                                                    </a>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </tbody></table>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody></table>
                                                                        </td>
                                                                    </tr>
                                                                </tbody></table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                                <table cellpadding = "0" cellspacing="0" align="center" width="290">
                                                    <tbody><tr>
                                                        <td width = "145" height="141">
                                                            <p align = "center"><a onclick="onPost_AD()" style="cursor:pointer">
                                                            <img src = "IMG/bt_confirm.png" border="0" width="122" height="37" alt="" />
                                                            </a></p>
                                                        </td>
                                                        <td width = "145" height="141">
                                                        <p align = "center"><a onclick="onCancel_AD()" style="cursor:pointer">
                                                        <img src = "IMG/bt_cancel.png" border="0" width="122" height="37" alt="" /></a></p>
                                                        </td>
                                                    </tr></tbody>
                                                </table>
                                            </td>
                                    </table>
                                </div>
                                <div id = "viewBanner" style="display:none;">
                                    <table cellpadding = "0" cellspacing="0" width="891" align="center">
                                        <tbody><tr>
                                            <td width = "891"> &nbsp;</td>
                                        </tr>
                                    </tbody></table>
                                    <p>&nbsp;</p>
                                    <table cellpadding = "0" cellspacing="0" width="770" align="center">
                                        <tbody><tr>
                                            <td width = "770" height="265" bgcolor="#E5E5E5">
                                                <div style = "width:770px; height:265px; overflow:hidden; margin:1px; position:relative">
                                                    <asp:Literal runat="server" ID="Liter_imageurl2"></asp:Literal>
                                            </div></td>
                                        </tr><tr>
                                            <td width = "770" height="343">
                                                <div align = "right">
                                                    <table cellpadding="0" cellspacing="0">
                                                        <tbody><tr>
                                                            <td width = "760" height="48">
                                                                <a onclick = "del_Banner()" style="cursor:pointer">
                                                                <img src = "IMG/_0009_trashcan.png" border="0" align="right" width="41" height="41" alt="" />
                                                            </a></td>
                                                        </tr></tbody></table>
                                                </div>
                                                <table cellpadding = "0" cellspacing="0" width="769" style="border-collapse:collapse;">
                                                    <tbody><tr>
                                                        <td width = "180" height="60" bgcolor="#666666" style="border-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(232,232,232); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                                                            <p align = "center"><span style="font-size:11pt;"><b><font face = "돋움" color="#CCCCCC">광고명</font></b></span></p>
                                                        </td>
                                                        <td width = "589" height="60" bgcolor="#F1F2F6" style="border-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(232,232,232); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;" align="center">
                                                            <asp:Literal runat="server" ID="Liter_name2"></asp:Literal>
                                                        </td></tr>
                                                    <tr>
                                                        <td width = "180" height="60" bgcolor="#666666" style="border-width:1; border-top-color:rgb(232,232,232); border-right-color:black; border-bottom-color:rgb(232,232,232); border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                                                            <p align = "center"><span style="font-size:11pt;"><b><font face = "돋움" color="#CCCCCC">광고주</font></b></span></p>
                                                        </td>
                                                        <td width = "589" height="60" bgcolor="#F1F2F6" style="border-width:1; border-top-color:rgb(232,232,232); border-right-color:black; border-bottom-color:rgb(232,232,232); border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:solid; border-left-style:none;"  align="center">
                                                            <asp:Literal runat="server" ID="Liter_master2"></asp:Literal>
                                                        </td>
                                                    </tr><tr>
                                                        <td width = "180" height="60" bgcolor="#666666" style="border-width:1; border-top-color:rgb(232,232,232); border-right-color:black; border-bottom-color:rgb(232,232,232); border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                                                            <p align = "center"><span style="font-size:11pt;"><b><font face = "돋움" color="#CCCCCC">노출기간</font></b></span></p>
                                                        </td>
                                                        <td width = "589" height="60" bgcolor="#F1F2F6" style="border-width:1; border-top-color:rgb(232,232,232); border-right-color:black; border-bottom-color:rgb(232,232,232); border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:solid; border-left-style:none;" align="center">
                                                            <table cellpadding = "0" cellspacing="0" align="center" width="542">
                                                                <tbody><tr>
                                                                    <td width = "215" height="41">
                                                                        <div align = "left">
                                                                            <asp:TextBox ID="StartDate2" runat="server" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="210px"></asp:TextBox>
                                                                            <ajax:CalendarExtender ID="cldStartDate2" runat="server" TargetControlID="StartDate2" Format="yyyy-MM-dd" />
<!--                                                                            <asp:Literal runat="server" ID="Liter_start2"></asp:Literal>
-->
                                                                        </div></td>
                                                                    <td width = "30" height="41">
                                                                        <p align = "center"> ~</p>
                                                                    </td><td width="222" height="41">
                                                                            <asp:TextBox ID="EndDate2" runat="server" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="200px"></asp:TextBox>
                                                                            <ajax:CalendarExtender ID="cldEndDate2" runat="server" TargetControlID="EndDate2"
                                                                                Format="yyyy-MM-dd" />
<!--                                                                            <asp:Literal runat="server" ID="Liter_end2"></asp:Literal>
-->
                                                                    </td><td width = "75" height="41">
                                                                        <p align = "right">
                                                                            <input type="checkbox" id="unlimitedTime2" onclick="onUnlimitedTime2()" name="formcheckbox2" /> <span style = "font-size:11pt;"><font face="돋움" color="#666666">무기한</font></span></p>
                                                                    </td>                                                                    
                                                                </tr></tbody>
                                                            </table></td></tr>
                                                        <tr>
                                                            <td width = "180" height="80" bgcolor="#666666" style="border-width:1; border-top-color:rgb(232,232,232); border-right-color:black; border-bottom-color:black; border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
                                                                <p align = "center"><span style="font-size:11pt;"><b><font face = "돋움" color="#CCCCCC">파일</font></b></span></p>
                                                            </td>
                                                            <td width = "589" height="80" bgcolor="#F1F2F6" style="border-width:1; border-top-color:rgb(232,232,232); border-right-color:black; border-bottom-color:black; border-left-color:black; border-top-style:solid; border-right-style:none; border-bottom-style:none; border-left-style:none;">
                                                                <table cellpadding = "0" cellspacing="0" align="center" width="544">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td width = "454" height="43">
                                                                                <div align = "left">
                                                                                    <asp:Literal runat="server" ID="Lister_imgurl2"></asp:Literal>
                                                                                </div></td>
                                                                            <td width = "90" height="43">
                                                                                <table cellpadding = "0" cellspacing="0"><tbody>
                                                                                    <tr>
                                                                                        <td width = "85" height="28" style="border-width:1; border-color:black; border-style:none;" bgcolor="#999999" align="center">
                                                                                            <input id = "adv_file2" type="file" name="image_path2" accept="image/png, image/jpeg" class="clsBrowser" style="display: none" size="35" onchange="document.getElementById('adv_file_text2').value=this.value; readURL2(this);" />
                                                                                            <a onclick = "javascript:OnBrowse('adv_file2')" style="cursor: pointer;">
                                                                                                <img src = "IMG/bt_file.png" alt="" />
                                                                                            </a></td></tr>
                                                                                </tbody></table></td>
                                                                            </tbody></table>
                                                            </td></tr></tbody></table></td>
                                             </tr></tbody>
                                    </table>
                                    <table cellpadding = "0" cellspacing="0" align="center" width="290">
                                        <tbody><tr><td width = "145" height="115">
                                            <p align = "center"><a onclick="onPost_Banner()" style="cursor:pointer"><img src = "IMG/bt_confirm.png" border="0" width="122" height="37" alt="" /></a></p>
                                                </td><td width = "145" height="115">
                                            <p align = "center"><a onclick="onCancel_Banner()" style="cursor:pointer"><img src = "IMG/bt_cancel.png" border="0" width="122" height="37" alt="" /></a></p>
                                            </td></tr>
                                        </tbody></table>
                                </div>
                            </td>
                        </tr>
                    </tbody></table>
                </td>
            </tr>            
            <tr>
                <td colspan="2" width="1200" height="40" bgcolor="#595959">
                        <p align="right" style="margin-top: 0px;margin-bottom: 0px;"><b><font face="돋움" color="#FFE4F2" style="padding-right: 10px;">
                            <span style="font-size:10pt;">powered by coarsoft</span></font><span style="font-size:10pt;">
                                <font face="돋움" color="#CCCCCC"> </font></span></b><font face="돋움" color="#CCCCCC"><span style="font-size:10pt;">&nbsp;&nbsp;</span></font></p>
                </td>
            </tr>
        </table>

        <div id="delAdver1" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tbody><tr>
                    <td width="450" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="450" height="199" bgcolor="white">
                        <table cellpadding="0" cellspacing="0" width="410" align="center">
                            <tbody><tr>
                                <td width="410" height="114">
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">광고를 삭제합니다.</font></span></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="410" height="49">
                                    <table cellpadding="0" cellspacing="0" align="center" width="290">
                                        <tbody><tr>
                                            <td width="145" height="36">
                                                <a style="cursor:pointer" onclick="delAdvertisement1()">
                                                    <img src="IMG/bt_confirm.png" alt="" />
                                                </a>
                                            </td>
                                            <td width="145" height="36">
                                                <a style="cursor:pointer" onclick="closePopup();"><img src="IMG/bt_cancel.png"  alt=""/></a>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="delAdver2" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tbody><tr>
                    <td width="450" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="450" height="199" bgcolor="white">
                        <table cellpadding="0" cellspacing="0" width="410" align="center">
                            <tbody><tr>
                                <td width="410" height="114">
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">광고를 삭제합니다.</font></span></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="410" height="49">
                                    <table cellpadding="0" cellspacing="0" align="center" width="290">
                                        <tbody><tr>
                                            <td width="145" height="36">
                                                <a style="cursor:pointer" onclick="delAdvertisement2()">
                                                    <img src="IMG/bt_confirm.png" alt="" />
                                                </a>
                                            </td>
                                            <td width="145" height="36">
                                                <a style="cursor:pointer" onclick="closePopup();"><img src="IMG/bt_cancel.png"  alt=""/></a>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
