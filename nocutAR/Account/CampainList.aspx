<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true" CodeBehind="CampainList.aspx.cs" Inherits="nocutAR.Account.CampainList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    var timeid;
    $(document).ready(function () {
        selTopMenu(2);
        $("#campain_menu1").html('<b>캠페인</b>');
        $("#stat_menu1").html('통계');
        $("#adv_menu1").html('광고');
        $("#campain_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(93,129,236); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');
        $("#stat_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(235,235,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');
        $("#adv_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(235,235,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');

        $(".marker_img").mouseover(function () {
            clearTimeout(timeid);
            $("#td_" + $(this).attr("id")).css("display", "");
            $("#aDel_" + $(this).attr("id")).css("display", "");
        });
        $(".marker_edt").mouseover(function () {
            clearTimeout(timeid);
        });

        $(".marker_edt").mouseout(function () {
            var id = $(this).attr("id");
            var id2 = $(this).attr("id").replace("td", "aDel") ;
            if($(this).attr("id").indexOf("aDel") >=0)
                id2 = $(this).attr("id").replace("aDel", "td") ;
            timeid = setTimeout(function () { onMarkerImgOut(id,id2); }, 1);
        });
        $(".marker_img").mouseout(function () {
            var id = "td_" + $(this).attr("id");
            var id2 = "aDel_" + $(this).attr("id");
            timeid = setTimeout(function () { onMarkerImgOut(id, id2); }, 1);
        });
        $(".marker_img").one("load", function () {
            if ($(this).css('width') <= $(this).css('height'))
                $(this).css('width', '280px');
            else
                $(this).css('height', '298px');
        }).each(function () {
            if (this.complete) $(this).load();
        });

    });

    function onMarkerImgOut(id,id2) {
        clearTimeout(timeid);
        $("#" + id).css("display", "none");
        $("#" + id2).css("display", "none");  
    }

    function onAddCampain() {
        $("#<%=txtTitle.ClientID %>").val("");
        showPopup("dvAddCampain");
    }

    function onDelCampaign(id) {
        showPopup("dvDelCampaign");
        $("#<%=hdCampainID.ClientID %>").val(id);
    }

    function checkCampain() {
        if ($("#<%=txtTitle.ClientID %>").val().trim() == "") {
            alert("제목을 입력하세요.");
            return false;
        }
        return true;
    }

    function onShowDetail(marker_url, title, regdate, changedate, api_requests) {
        $("#spTitle").html(title);
        $("#spRegdate").html("캠페인생성일: " + regdate.substr(0, 10) + "<br>최종 수정일: " + changedate.substr(0, 10));
        $("#spScans").html(api_requests);
        $("#imgMarker").attr("src", marker_url);
        showPopup("dvDetail");
    }

    function onConfirmCopyCampain(id) {
        showPopup("dvCopyCampaign");
        $("#<%=hcCampainID.ClientID %>").val(id);

    }

    function onCopyCampain() {
        $.ajax({
            url: "CopyCampain.aspx?id=" + $("#<%=hcCampainID.ClientID %>").val(),
            dataType: 'json',
            type: 'POST',
            success: function (data) {
                location.href = "campainlist.aspx";
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("컴페인 복사중 오류가 발생하였습니다.");
            }
        });
    }

    function na_restore_img_src(name, nsdoc)
    {
      var img = eval((navigator.appName.indexOf('Netscape', 0) != -1) ? nsdoc+'.'+name : 'document.all.'+name);
      if (name == '')
        return;
      if (img && img.altsrc) {
        img.src    = img.altsrc;
        img.altsrc = null;
      } 
    }

    function na_preload_img()
    { 
      var img_list = na_preload_img.arguments;
      if (document.preloadlist == null) 
        document.preloadlist = new Array();
      var top = document.preloadlist.length;
      for (var i=0; i < img_list.length-1; i++) {
        document.preloadlist[top+i] = new Image;
        document.preloadlist[top+i].src = img_list[i+1];
      } 
    }

    function na_change_img_src(name, nsdoc, rpath, preload)
    { 
      var img = eval((navigator.appName.indexOf('Netscape', 0) != -1) ? nsdoc+'.'+name : 'document.all.'+name);
      if (name == '')
        return;
      if (img) {
        img.altsrc = img.src;
        img.src    = rpath;
      } 
    }


    function onEditCampaign(id) {
        location.href = "detailContent.aspx?id=" + id;
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
    <table style="width:100%;height:100%">
          <tr>
            <td>
                <div style="background-image: url(IMG/_0015_search_box.png);width:90%;height:54%;display:flex;">
                    <asp:TextBox ID="txtSearchKey" CssClass="control campainListclsSearchKey" MaxLength="20"   runat="server"></asp:TextBox>         
                    <asp:ImageButton CssClass="control campainListclsSearchBtn" runat="server" ImageUrl="IMG/search-icon.png" OnClick="btnSearch_Click" />   
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
    <table cellpadding="0" cellspacing="0" width="1240" align="center" bgcolor="#F7F8F8" style="border-collapse:collapse;">
        <tr>
            <td width="1199" height="73">
                <table cellpadding="0" cellspacing="0" align="center" width="1022" align="center">
                    <tbody>
                    <tr>
                        <td width="822" height="69">
                        </td>
                        <td width="200" height="69" style="cursor:pointer" onclick="onAddCampain()">
                            <p align="right">
                                <span style="font-size:11pt;"><font face="돋움" color="#ACACAC"><b> + 캠페인 추가</b></font></span>
                            </p>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td width="1199" height="720" valign="top">
                <table cellpadding="0" cellspacing="0" align="center" width="1120">
                    <tbody>
                        <tr>
                            <asp:Literal runat="server" ID="ltrData"></asp:Literal>
                         </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
    </div>
    <div id="dvDetail" class="clspopup">
    <table cellpadding="0" cellspacing="0" width="566" >
        <tr>
            <td width="566" height="468" valign="top">
                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="540">
                    <tr>
                        <td width="538" height="82" style="border-width:1px; border-top-color:black; border-right-color:black; border-bottom-color:rgb(229,233,235); border-left-color:black; border-style:none;">
                            <table cellpadding="0" cellspacing="0" align="center" width="521">
                                <tr>
                                    <td width="295" height="80">
                                    <div align="left">
                                        <table cellpadding="0" cellspacing="0" width="276">
                                            <tr>
                                                <td width="276" height="29">
                                                    <font face="돋움" color="white"><b><span style="font-size:12pt;" id="spTitle">캠페인1 이름</span></b></font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="276" height="46">
                                                    <table cellpadding="0" cellspacing="0" width="265">
                                                        <tr>
                                                            <td width="265" height="43">
                                                                <font face="돋움" color="white"><span style="font-size:10pt;" id="spRegdate">캠페인생성일: 2015-03-01<br>최종 수정일: 2015-03-02</span></font>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    </td>
                                    <td width="226" height="80">
                                        <div align="right">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="52" height="26">&nbsp;</td>
                                                    <td width="52" height="26">&nbsp;</td>
                                                    <td width="52" height="26" align="right">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                            <table cellpadding="0" cellspacing="0" width="156">
                                                <tr>
                                                    <td width="37" height="33"><img src="img/icon_view2.png" width="31" height="22" border="0"></td>
                                                        <td width="67" height="33">
                                                            <font face="돋움" color="white"><b><span style="font-size:12pt;" id="spScans">325</span></b></font>
                                                        </td>
                                                        <td width="52" height="33" align="right">
                                                            <b><font face="돋움" color="white"><span style="font-size:11pt; cursor:pointer;" onclick="closePopup()">닫기</span></font></b>
                                                        </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="538" height="366" style="border-width:1px; border-top-color:rgb(229,233,235); border-right-color:black; border-bottom-color:black; border-left-color:black; border-style:none;">
                            <table cellpadding="0" cellspacing="0" align="center" width="521">
                                <tr>
                                    <td width="521" height="362" bgcolor="#CCCCCC" align='center'>
                                        <img id='imgMarker' style='width:521px; height:auto' border='0'/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </div>
    <div id="dvAddCampain" class="clspopup">
    <table cellpadding="0" cellspacing="0" width="550" align="center" style="background-color:White">
        <tbody><tr>
                    <td width="514" height="10" bgcolor="#5D81EC"></td>
                </tr>

                <tr>
                    <td width="514" height="114">
                        <p align="center" style="margin-bottom:3px;margin-top:3px;"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">캠페인 등록</font></span></b></p>
                        <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="475">
                            <tbody><tr>
                                <td width="493" height="41" align="center">
                                    <asp:TextBox runat="server" ID="txtTitle" Width="100%" Font-Size="12" Height="32" CssClass="control" style="border-width:1px; border-style:solid; border-color:Black;" MaxLength="20"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvProjectName" runat="server" ValidationGroup="vGroup01" CssClass="error-message"
                                        ControlToValidate="txtTitle" Font-Size="10pt" ErrorMessage="컴페인명을 입력해주세요." Display="Dynamic"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>

                <tr>
                    <td width="514" height="49">
                        <table cellpadding="0" cellspacing="0" align="center" width="290">
                            <tbody><tr>
                                <td width="145" height="36">
                                    <p align="center">
                                        <asp:ImageButton runat="server" ID="btnRegCampain" ValidationGroup="vGroup01" onclick="btnRegCampain_Click" OnClientClick="return checkCampain();" ImageUrl="IMG/bt_confirm.png"/>
                                    </p>
                                </td>
                                <td width="145" height="36">
                                    <p align="center"><a onclick="closePopup();" onmouseout="na_restore_img_src('image2', 'document')" onmouseover="na_change_img_src('image2', 'document', 'IMG/bt_cancel_r.png', true)">
                                        <img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image2" alt="" /></a>
                                    </p>
                                </td>

                                <td width="100" align="left">
                                    <asp:ValidationSummary ID="vSummary01" runat="server" ValidationGroup="vGroup01"
                                        ShowMessageBox="false"
                                        ShowSummary="false"
                                        DisplayMode="BulletList" />
                                </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody></table>
    </div>
    <div id="dvDelCampaign" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tbody><tr>
                    <td width="450" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="450" height="199" bgcolor="white">

                        <table cellpadding="0" cellspacing="0" width="410" align="center">
                            <tbody><tr>
                                <td width="410" height="114">
                                    <asp:HiddenField ID="hdCampainID" Value="0" runat="server" />
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">캠페인을 삭제합니다.</font></span></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="410" height="49">
                                    <table cellpadding="0" cellspacing="0" align="center" width="290">
                                        <tbody><tr>
                                            <td width="145" height="36">
                                                <asp:ImageButton runat="server" ID="btnDelCampain" Width="122" Height="37"  onclick="btnDelCampain_Click1" ImageUrl="IMG/bt_confirm.png"/>
                                            </td>
                                            <td width="145" height="36">
                                                <a style="cursor:pointer" onclick="closePopup();"><img src="IMG/bt_cancel.png"/></a>
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

    <div id="dvCopyCampaign" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="449" height="163" style="border-width:1; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" align="center" width="387">
                        <tr>
                            <td width="387" height="77" valign="middle" align="center">
                                <asp:HiddenField ID="hcCampainID" Value="0" runat="server" />
                                <font face="돋움" color="#666666"><span style="font-size:12pt;"><b>캠페인을 복사하시겠습니까?</b></span></font>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black" width="419" align="center">
                        <tr>
                            <td width="419" height="59" valign="bottom" align="right">
                                <table cellpadding="0" cellspacing="0" width="234">
                                    <tr>
                                        <td width="113" height="48">
                                            <input type="button" class="clsBigButton" onclick="closePopup()" value="취소" style=" width:107px; height:33px; background-color:#7F7F7F;" />
                                        </td>
                                        <td width="121" height="48">
                                            <asp:Button runat="server" ID="btnCopyCampain" width="107" height="33" Text="확인" 
                                            CssClass="clsButton" style=" font-weight:bold;"  
                                                OnClientClick="onCopyCampain()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
