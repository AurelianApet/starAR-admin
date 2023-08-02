<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true"
    CodeBehind="statstics.aspx.cs" Inherits="nocutAR.Account.statstics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/toolbar.js" type="text/javascript"></script>
    <script src="/Scripts/detailcontents_opt.js" type="text/javascript"></script>
    <link href="/Styles/Account.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        function onRegNewUser()
        {
            showPopup("dvAddUser");
        }

        $(document).ready(function () {
            $("#campain_menu1").html('캠페인');
            $("#stat_menu1").html('<b>통계</b>');
            $("#adv_menu1").html('광고');
            $("#stat_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(93,129,236); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');
            $("#campain_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(235,235,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');
            $("#adv_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(235,235,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');
        });

        function OnChangeuser_confirm()
        {
            var id = $("#changeid").html();
            var pwd = $("#changepwd").val();
            var email = $("#changeemail").val();
            var birthyear = $("#<%=birthyear_DropDownList1.ClientID%> option:selected").text();
            var married = $("#changemarried").html();
            var sex = $("#changesex").html();
            var place1 = $("#<%=place1_DropDownList1.ClientID%> option:selected").text();
            var place2 = $("#<%=place2_DropDownList1.ClientID%> option:selected").text();
            var url = 'changeuser.aspx?id=' + id + '&pwd=' + pwd + '&email=' + email + '&birthyear=' + birthyear + "&married=" + married + "&sex=" + sex + "&place1=" + place1 + "&place2=" + place2;
            $.ajax({
                url: url,
                type: "post",
                dataType: 'json',
                Type:'POST',
                async: false,
                success: function (data) {
                    if (data.fieldMes == true)
                        alert("모든 마당을 정확히 입력하십시오");
                    if (data.pwdMes == true)
                        alert("암호를 6자이상 입력하십시오.");
                    else if (data.emailMes == true)
                        alert("이메일형식이 올바르지 않습니다.");
                    else if (data.proMes == true)
                        alert("유저변경시 알지 못할 오류가 발생했습니다.");
                    else
                        alert("유저가 성공적으로 변경되었습니다");
                    location.href = "statstics.aspx?page_type=1";
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("유저변경시 오류가 발생했습니다.");
                }
            });
        }

        function OnNewUser() {
            var id = $("#<%=useridTxt.ClientID%>").val();
            var pwd = $("#<%=userpwdTxt.ClientID%>").val();
            var email = $("#<%=emailTxt.ClientID%>").val();
            var birthyear = $("#<%=birth_year_dropdownlist.ClientID%> option:selected").text();
            var married = $("#<%=married_dropdownlist.ClientID%> option:selected").text();
            var sex = $("#<%=sex_dropdownlist.ClientID%> option:selected").text();
            var place1 = $("#<%=place1_dropdownlist.ClientID%> option:selected").text();
            var place2 = $("#<%=place2_dropdownlist.ClientID%> option:selected").text();
            var url = 'addnewuser.aspx?id=' + id + '&pwd=' + pwd + '&email=' + email + '&birthyear=' + birthyear + "&married=" + married + "&sex=" + sex + "&place1=" + place1 + "&place2=" + place2;
            $.ajax({
                url: url,
                type: "post",
                dataType: 'json',
                contentType: false,
                async: false,
                success: function (data) {
                    var type = data.type;
                    if (type == '0'){
                        alert("유저가 성공적으로 등록되었습니다.");
                        location.reload();
                    }
                    else if (type == "1")
                        alert("모든 마당을 정확히 입력하세요.");
                    else if (type == "2")
                        alert("동일한 아이디가 이미 존재합니다..");
                    else if (type == "3")
                        alert("비밀번호는 6자리이상 영문자, 숫자를 입력하십시오.");
                    else if (type == "4")
                        alert("이메일을 정확히 입력하십시오");
                    else if (type == "5") {
                        alert("유저등록과정에 알지 못할 오류가 발생했습니다.");
                        location.reload();
                    }
                    
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("유저등록시 오류가 발생했습니다.");
                }
            });
        }

        var title = "";
        var request = "";
        var regdate = "";
        var count = 0;
        var curpage = 1;        
        var totalpage = 1;

        function onDetailUser(uid, campaigncount, usercount)
        {
            $("#detailTitle").html('아이디 : [ ' + uid + ' ]');
            $("#detailcampaigncount").html('참여 캠페인 : ' + campaigncount + '개 (' + usercount + '회)');
            var url = "getdetailuser.aspx?uid=" + uid;
            $.ajax({
                url: url,
                dataType: 'json',
                async: false,
                type: 'POST',
                success: function (data) {
                    var pwd = data.pwd;
                    var email = data.email;
                    var birth_year = data.birth_year;
                    var married = data.married;
                    var sex = data.sex;
                    var place = data.address;
                    try
                    {
                        count = data.detailData.length;
                        totalpage = Math.ceil(count / 5);
                        for (i = 0; i < count; i++) {
                            title += data.detailData[i].title + ",";
                            request += data.detailData[i].request + ",";
                            regdate += data.detailData[i].regdate + ",";
                        }
                    }
                    catch(Exception)
                    {
                        count = 0;
                    }
                    $("#detailpwd").html('비밀번호 : ' + pwd);
                    $("#detailemail").html(email);
                    $("#detailbirthyear").html( birth_year );
                    $("#detailmarried").html( married );
                    $("#detailsex").html( sex );
                    $("#detailplace").html(place);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
            curpage = 1;
            ShowDetailUser("detail111");

            showPopup("dvDetailUser");
        }

        function ShowDetailUser(detailContent)
        {
            var content = '<table cellpadding="0" cellspacing="0" width="578" style="border-collapse:collapse;">'
            + '<thead><tr>'
            + '<td width="43" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">&nbsp;</td>'
            + '<td width="232" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">'
            + '<p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">캠페인명</font></b></span></p>'
            + '</td>'
            + '<td width="146" " bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">'
            + '<p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">캠페인 등록일</font></b></span></p>'
            + '</td><td width="152" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">'
            + '<p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">실행 횟수</font></b></span></p>'
            + '</td></tr></thead><tbody>';
            var title1 = title.split(',');
            var regdate1 = regdate.split(',');
            var request1 = request.split(',');
            for (i = (curpage - 1) * 5 + 1; i < curpage * 5 + 1; i++) {
                if (i > count)
                {
                    content += '<tr>'
                    + '<td width="43" height="22" style="border-width:1; border-color:white; border-style:solid;" bgcolor="#F1F2F6">'
                    + '<p align="center"><font face="돋움" color="#666666"><span style="font-size:10pt;">'
                    + '</span></font></p>'
                    + '</td><td width="232" height="45" style="border-width:1; border-color:white; border-style:solid;" bgcolor="#F1F2F6">'
                    + '<p align="center"><font face="돋움" color="#666666"><span style="font-size:10pt;">'
                    + '</span></font></p>'
                    + '</td><td width="146" height="45" style="border-width:1; border-color:white; border-style:solid;" bgcolor="#F1F2F6">'
                    + '<p align="center"><font face="돋움" color="#666666"><span style="font-size:10pt;">'
                    + '</span></font></p>'
                    + '</td><td width="152" height="45" bgcolor="#F1F2F6" style="border-width:1; border-color:white; border-style:solid;">'
                    + '<p align="center"><font face="돋움" color="#666666"><span style="font-size:10pt;">'
                    + '</span></font></p></td>'
                    + '</tr>';
                }
                else
                {
                    content += '<tr>'
                    + '<td width="43" height="22" style="border-width:1; border-color:white; border-style:solid;" bgcolor="#F1F2F6">'
                    + '<p align="center"><font face="돋움" color="#666666"><span style="font-size:10pt;">'
                    + i
                    + '</span></font></p>'
                    + '</td><td width="232" height="45" style="border-width:1; border-color:white; border-style:solid;" bgcolor="#F1F2F6">'
                    + '<p align="center"><font face="돋움" color="#666666"><span style="font-size:10pt;">'
                    + title1[i - 1]
                    + '</span></font></p>'
                    + '</td><td width="146" height="45" style="border-width:1; border-color:white; border-style:solid;" bgcolor="#F1F2F6">'
                    + '<p align="center"><font face="돋움" color="#666666"><span style="font-size:10pt;">'
                    + regdate1[i - 1]
                    + '</span></font></p>'
                    + '</td><td width="152" height="45" bgcolor="#F1F2F6" style="border-width:1; border-color:white; border-style:solid;">'
                    + '<p align="center"><font face="돋움" color="#666666"><span style="font-size:10pt;">'
                    + request1[i - 1]
                    + '</span></font></p></td>'
                    + '</tr>';
                }
            }
            content += '</tbody></table></td></tr><tr><td>';
            if (count > 0)
            {
                content += '<table cellpadding="0" cellspacing="0" width="427" align="center">'
                + '<tbody><tr><td width="25" height="67">'
                + '<p><a onclick="ondetail_GotoPrev('
                + curpage
                + ', \''
                + detailContent
                + '\')" style="cursor:pointer"><font color="#666666">◀</font></a></p></td><td width="377" height="67"><p align="center">';
                for (i = 1; i <= totalpage; i++) {
                    if (i == curpage) {
                        content += '<a onclick="ondetail_GotoPage('
                        + i
                        + ', \''
                        + detailContent
                        + '\')" style="cursor:pointer"><span style="font-size:15pt;"><b><font face="돋움" color="#666666">'
                        + i
                        + '</font></b></span></a>&nbsp;&nbsp;&nbsp;';
                    }
                    else {
                        content += '<a onclick="ondetail_GotoPage('
                        + i
                        + ', \''
                        + detailContent
                        + '\')" style="cursor:pointer"><span style="font-size:11pt;"><b><font face="돋움" color="#666666">'
                        + i
                        + '</font></b></span></a>&nbsp;&nbsp;&nbsp;';
                    }
                }

                content += '</p></td><td width="25" height="67">'
                + '<p align="right"><a onclick="ondetail_GotoNext('
                + curpage
                + ', \''
                + detailContent
                + '\')" style="cursor:pointer"><font color="#666666">▶</font></a></p></td></tr></tbody></table>';
            }
            document.getElementById(detailContent).innerHTML = content;
        }

        function ondetail_GotoPage(page, detailContent)
        {
            curpage = page;
            ShowDetailUser(detailContent);
        }

        function ondetail_GotoPrev(page, detailContent)
        {
            if (page > 1)
            {
                curpage--;
                ShowDetailUser(detailContent);
            }
        }

        function ondetail_GotoNext(page, detailContent)
        {
            if (page < totalpage)
            {
                curpage++;
                ShowDetailUser(detailContent);
            }
        }

        function OnChange(uid, campaigncount, usercount)
        {
            $("#changeid").html(uid);
            $("#changecampaigncount").html('참여 캠페인 : ' + campaigncount + '개 (' + usercount + '회)');

            var url = "getdetailuser.aspx?uid=" + uid;
            $.ajax({
                url: url,
                dataType: 'json',
                async: false,
                type: 'POST',
                success: function (data) {
                    var pwd = data.pwd;
                    var email = data.email;
                    var birth_year = data.birth_year;
                    var married = data.married;
                    var sex = data.sex;
                    var place = data.address;
                    var place1 = place.substring(0, place.indexOf(" "));
                    var place2 = place.substring(place.indexOf(" "));
                    
                    try{
                        count = data.detailData.length;
                        for (i = 0; i < count; i++) {
                            title += data.detailData[i].title + ",";
                            request += data.detailData[i].request + ",";
                            regdate += data.detailData[i].regdate + ",";
                        }
                    }
                    catch(Exception)
                    {
                        count = 0;
                    }

                    totalpage = Math.ceil(count / 5);

                    $("#changepwd").val(pwd);
                    $("#changeemail").val(email);
                    $("#changemarried").html(married);
                    $("#changesex").html(sex);
                    $("#<%=birthyear_DropDownList1.ClientID%> option:selected").text(birth_year);
                    var no = 0;
                    if (place1 == "서울특별시") { 
                        no = 0;}
                    else if (place1 == "부산광역시") {
                        no = 2;
                    }
                    else if (place1 == "대구광역시") {
                        no = 3;

                    }
                    else if (place1 == "인천광역시") {
                        no = 4;

                    }
                    else if (place1 == "광주광역시") {
                        no = 5;

                    }
                    else if (place1 == "대전광역시") {
                        no = 6;

                    }
                    else if (place1 == "울산광역시") {
                        no = 7;

                    }
                    else if (place1 == "세종특별자치시") {
                        no = 8;

                    }
                    else if (place1 == "경기도") {
                        no = 9;

                    }
                    else if (place1 == "강원도") {
                        no = 10;

                    }
                    else if (place1 == "충청북도") {
                        no = 11;

                    }
                    else if (place1 == "충청남도") {
                        no = 12;

                    }
                    else if (place1 == "전라북도") {
                        no = 13;

                    }
                    else if (place1 == "전라남도") {
                        no = 14;

                    }
                    else if (place1 == "경상북도") {
                        no = 15;

                    }
                    else if (place1 == "경상남도") {
                        no = 16;

                    }
                    else if (place1 == "제주특별자치도") {
                        no = 17;

                    }
                    $("#<%=place1_DropDownList1.ClientID%>").val(no - 1);
                    $("#<%=place2_DropDownList1.ClientID%> option:selected").text(place2);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
            curpage = 1;
            ShowDetailUser("detail222");

            showPopup("dvChangeUser");
        }

        function onChangeMarrid()
        {
            if ($("#changemarried").text() == "기혼")
                $("#changemarried").html("미혼");
            else
                $("#changemarried").html("기혼");
        }

        function onChangeSex() {
            if ($("#changesex").text() == "남자")
                $("#changesex").text("여자");
            else
                $("#changesex").text("남자");
        }

        function OnDelete(uid)
        {
            showPopup("dvDeleteUser");
            $("#<%=userID.ClientID %>").val(uid);
        }

        function onGetUserStat() {
            location.href = "statstics.aspx?page_type=1";
        }

        function onGetStat(title)
        {
            location.href = "statstics.aspx?page_type=2&type=" + title;
        }
        
        function onSearch(pp)
        {
            var data = new FormData();

            if(pp == 1)
            {
                var stxt1 = $("#<%= StartDate1.ClientID  %>").val();
                var stxt2 = $("#<%= EndDate1.ClientID  %>").val();

                $.ajax({
                    url: 'statstics.aspx?searchtxt1=' + stxt1 + '&searchtxt2=' + stxt2 + '&stype=1',
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        location.href = "statstics.aspx?searchtxt1=" + stxt1 + "&searchtxt2=" + stxt2 + "&stype=1";
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            }
            else if(pp == 2)
            {
                var stxt1 = $("#<%= StartDate2.ClientID  %>").val();
                var stxt2 = $("#<%= EndDate2.ClientID  %>").val();
                $.ajax({
                    url: 'statstics.aspx?searchtxt1=' + stxt1 + '&searchtxt2=' + stxt2 + '&stype=2',
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        location.href = "statstics.aspx?searchtxt1=" + stxt1 + "&searchtxt2=" + stxt2 + "&stype=2";
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            }
        }

        function GoPrevUserPage(curpage) {
            var data = new FormData();

            var page = curpage - 1;

            if (page >= 1) {
                $.ajax({
                    url: 'statstics.aspx?page_type=1&user_page=' + page,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        location.href = "statstics.aspx?page_type=1&user_page=" + page;
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            }
        }


        function GoPrevPage(curpage)
        {
            var data = new FormData();
            
            var page = curpage - 1;

            if (page >= 1)
            {
                $.ajax({
                    url: 'statstics.aspx?page=' + page,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        location.href = "statstics.aspx?page=" + page;
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            }
        }

        function GoNextPage(curpage, totalpage)
        {
            var data = new FormData();

            var page = curpage + 1;

            if (page <= totalpage)
            {
                $.ajax({
                    url: 'statstics.aspx?page=' + page,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        location.href = "statstics.aspx?page=" + page;
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            }
//            document.location = "statstics.aspx?page=" + page;
        }

        function GoNextUserPage(curpage, totalpage) {
            var data = new FormData();

            var page = curpage + 1;

            if (page <= totalpage) {
                $.ajax({
                    url: 'statstics.aspx?page_type=1&user_page=' + page,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        location.href = "statstics.aspx?page_type=1&user_page=" + page;
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            }
            //            document.location = "statstics.aspx?page=" + page;
        }

        function GotoPage(curpage, totalpage)
        {
            var data = new FormData();
            if (curpage >= 1 && curpage <= totalpage)
            {
                $.ajax({
                    url: 'statstics.aspx?page=' + curpage,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        location.href = "statstics.aspx?page=" + curpage;
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            }
        }

        function GotoUserPage(curpage, totalpage) {
            var data = new FormData();
            if (curpage >= 1 && curpage <= totalpage) {
                $.ajax({
                    url: 'statstics.aspx?page_type=1&user_page=' + curpage,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        location.href = "statstics.aspx?page_type=1&user_page=" + curpage;
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    }
                });
            }
        }

        function  search_UserStat()
        {
            var regdate = $("#<%=RegStartDate1.ClientID%>").val();
            var changedate = $("#<%=RegEndDate1.ClientID%>").val();
            var married = $("#<%=MarriedDropDown.ClientID%> option:selected").text();
            var sex = $("#<%=SexDropDown.ClientID%> option:selected").text();
            var place1 = $("#<%=Place1DropDown.ClientID%> option:selected").text();
            var place2 = $("#<%=Place2DropDown.ClientID%> option:selected").text();
            var url = 'statstics.aspx?page_type=1&search_type=1&regdate=' + regdate + '&changedate=' + changedate + "&married=" + married + "&sex=" + sex + "&place1=" + place1 + "&place2=" + place2;
            location.href = url;
        }

        function onChangePlace() {
            $("#<%=Place2DropDown.ClientID%>").html("");
//            if (document.getElementById("<%=Place1DropDown.ClientID %>").options[0].selected) {
                if($("#<%=Place1DropDown.ClientID%> option:selected").text() == "서울특별시"){
                    //            if (document.getElementById("<%=Place1DropDown.ClientID %>").options[0].selected) {
                    var option = document.createElement("option");
                    option.text = "종로구";
                    option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "중구";
                    option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "용산구";
                    option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "성동구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "광진구"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동대문구"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "중랑구"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "성북구"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "강북구"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동북구"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "노원구"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "은평구"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서대문구"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "마포구"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "양천구"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "강서구"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "구로구"; option.value = "16";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "금천구"; option.value = "17";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영등포구"; option.value = "18";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동작구"; option.value = "19";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "관악구"; option.value = "20";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서초구"; option.value = "21";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "강남구"; option.value = "22";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "송파구"; option.value = "23";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "강동구"; option.value = "24";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);

                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "부산광역시") {
                    var option = document.createElement("option");
                    option.text = "중구"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영도구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "부산진구"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동래구"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남구"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "북구"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "해운대구"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "사하구"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "금정구"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "강서구"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "연제구"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "수영구"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "사상구"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "기장군"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "대구광역시") {
                    var option = document.createElement("option");
                    option.text = "중구"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "북구"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "수성구"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "달서구"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "달성군"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "인천광역시") {
                    var option = document.createElement("option");
                    option.text = "중구"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "연수구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남동구"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "북구"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "부평구"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "계양구"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서구"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "강화군"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "옹진군"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "광주광역시") {
                    var option = document.createElement("option");
                    option.text = "동구"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "북구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "광산구"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "대전광역시") {
                    var option = document.createElement("option");
                    option.text = "동구"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "중구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "유성구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "대덕구"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "울산광역시") {
                    var option = document.createElement("option");
                    option.text = "중구"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "북구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "울주군"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);

                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "세종특별자치시") {
                    var option = document.createElement("option");
                    option.text = "세종시"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "경기도") {
                    var option = document.createElement("option");
                    option.text = "수원시"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "장안구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "권선구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "팔달구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영통구"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "성남시"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "수정구"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "중원구"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "분당구"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "의정부시"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "안양시"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "만안구"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동안구"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "부천시"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "원미구"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "소사구"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "오정구"; option.value = "16";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "광명시"; option.value = "17";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "평택시"; option.value = "18";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "송탄시"; option.value = "19";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동두천시"; option.value = "20";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "안산시"; option.value = "21";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "상록구"; option.value = "22";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "단원구"; option.value = "23";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "고양시"; option.value = "24";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "덕양구"; option.value = "25";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "일산구"; option.value = "26";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "일산동구"; option.value = "27";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "일산서구"; option.value = "28";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "과천시"; option.value = "29";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "구리시"; option.value = "30";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "미금시"; option.value = "31";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남양주시"; option.value = "32";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "오산시"; option.value = "33";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "시흥시"; option.value = "34";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "군포시"; option.value = "35";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "의왕시"; option.value = "36";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "하남시"; option.value = "37";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "용인시"; option.value = "38";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "처인구"; option.value = "39";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "기흥구"; option.value = "40";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "수지구"; option.value = "41";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "파주시"; option.value = "42";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "이천시"; option.value = "43";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "안성시"; option.value = "44";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "김포시"; option.value = "45";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "화성시"; option.value = "46";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "광주시"; option.value = "47";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "양주시"; option.value = "48";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "포천시"; option.value = "49";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "여주시"; option.value = "50";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "양주군"; option.value = "51";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남양주군"; option.value = "52";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "여주군"; option.value = "53";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "평택군"; option.value = "54";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "화성군"; option.value = "55";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "파주군"; option.value = "56";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "광주군"; option.value = "57";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "연천군"; option.value = "58";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "포천군"; option.value = "59";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "가평군"; option.value = "60";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "양평군"; option.value = "61";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "이천군"; option.value = "62";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "용인군"; option.value = "63";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "안성군"; option.value = "64";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "김포군"; option.value = "65";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "강화군"; option.value = "66";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "옹진군"; option.value = "67";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "강원도") {
                    var option = document.createElement("option");
                    option.text = "춘천시"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "원주시"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "강릉시"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동해시"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "태백시"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "속초시"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "삼척시"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "춘천군"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "홍천군"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "횡성군"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "원주군"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영월군"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "평창군"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "정선군"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "철원군"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "화천군"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "양구군"; option.value = "16";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "인제군"; option.value = "17";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "고성군"; option.value = "18";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "양양군"; option.value = "19";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "명주군"; option.value = "20";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "삼척군"; option.value = "21";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "충청북도") {
                    var option = document.createElement("option");
                    option.text = "청주시 서원구"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "청주시 청원구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "상당구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "흥덕구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동부출장소"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서부출장소"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "충주시"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "제천시"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "청원군"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "보은군"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "옥천군"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영동군"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "증평군"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "진천군"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "괴산군"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "음성군"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "중원군"; option.value = "16";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "제천군"; option.value = "17";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "단양군"; option.value = "18";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "증평출장소"; option.value = "19";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "충청남도") {
                    var option = document.createElement("option");
                    option.text = "당진시"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "천안시"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동남구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서북구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "공주시"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "대천시"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "보령시"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "온양시"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "아산시"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서산시"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "계룡출장소"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "논산시"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "계룡시"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "금산군"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "연기군"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "공주군"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "논산군"; option.value = "16";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "부여군"; option.value = "17";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서천군"; option.value = "18";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "보령군"; option.value = "19";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "청양군"; option.value = "20";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "홍성군"; option.value = "21";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "예산군"; option.value = "22";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "서산군"; option.value = "23";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "태안군"; option.value = "24";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "당진군"; option.value = "25";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "아산군"; option.value = "26";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "천안군"; option.value = "27";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "전라북도") {
                    var option = document.createElement("option");
                    option.text = "전주시"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "완산구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "덕진구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "효자출장소"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "군산시"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "익산시"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "보령시"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "온양시"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "아산시"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "정읍시"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남원시"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "김제시"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "완주군"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "진안군"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "무주군"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "장수군"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "임실군"; option.value = "16";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남원군"; option.value = "17";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "순창군"; option.value = "18";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "정읍군"; option.value = "19";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "고창군"; option.value = "20";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "부안군"; option.value = "21";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "김제군"; option.value = "22";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "옥구군"; option.value = "23";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "익산군"; option.value = "24";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "전라남도") {
                    var option = document.createElement("option");
                    option.text = "목포시"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "여수시"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "순천시"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "나주시"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "여천시"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "동광양시"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "담양군"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "곡성군"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "구례군"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "광양군"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "여천군"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "승주군"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "고흥군"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "보성군"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "화순군"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "장흥군"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "강진군"; option.value = "16";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "해남군"; option.value = "17";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영암군"; option.value = "18";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "무안군"; option.value = "19";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "나주군"; option.value = "20";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "함평군"; option.value = "21";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영광군"; option.value = "22";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "장성군"; option.value = "23";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "완도군"; option.value = "24";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "진도군"; option.value = "25";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "신안군"; option.value = "26";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "경상북도") {
                    var option = document.createElement("option");
                    option.text = "포항시"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "북구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "경주시"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "김천시"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "안동시"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "구미시"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영주시"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영천시"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "상주시"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "점촌시"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "문경시"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "경산시"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "달성군"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "군위군"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "의성군"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "안동군"; option.value = "16";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "청송군"; option.value = "17";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영양군"; option.value = "18";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영덕군"; option.value = "19";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영일군"; option.value = "20";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "경주군"; option.value = "21";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영천군"; option.value = "22";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "경산군"; option.value = "23";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "청도군"; option.value = "24";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "고령군"; option.value = "25";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "성주군"; option.value = "26";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "칠곡군"; option.value = "27";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "금릉군"; option.value = "28";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "선산군"; option.value = "29";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "상주군"; option.value = "30";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "문경군"; option.value = "31";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "예천군"; option.value = "32";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "영풍군"; option.value = "33";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "봉화군"; option.value = "34";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "울진군"; option.value = "35";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "울릉군"; option.value = "36";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "경상남도") {
                    var option = document.createElement("option");
                    option.text = "창원시"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "의창구"; option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "성산구"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "마산합포구"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "마산회원구"; option.value = "4";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "진해구"; option.value = "5";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "창원시"; option.value = "6";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "울산시"; option.value = "7";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "합포구"; option.value = "8";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "회원구"; option.value = "9";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "마산시"; option.value = "10";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "진주시"; option.value = "11";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "진해시"; option.value = "12";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "충무시"; option.value = "13";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "통영시"; option.value = "14";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "삼천포시"; option.value = "15";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "사천시"; option.value = "16";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "김해시"; option.value = "17";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "밀양시"; option.value = "18";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "장승포시"; option.value = "19";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "거제시"; option.value = "20";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "양산시"; option.value = "21";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "진양군"; option.value = "22";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "의령군"; option.value = "23";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "함안군"; option.value = "24";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "창녕군"; option.value = "25";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "밀양군"; option.value = "26";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "양산군"; option.value = "27";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "울산군"; option.value = "28";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "김해군"; option.value = "29";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "창원군"; option.value = "30";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "통영군"; option.value = "31";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "거제군"; option.value = "32";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "고성군"; option.value = "33";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "사천군"; option.value = "34";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "남해군"; option.value = "35";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "하동군"; option.value = "36";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "산청군"; option.value = "37";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "함양군"; option.value = "38";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "거창군"; option.value = "39";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option"); option.text = "합천군"; option.value = "40";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);

                }
                else if ($("#<%=Place1DropDown.ClientID%> option:selected").text() == "제주특별자치도") {
                    var option = document.createElement("option");
                    option.text = "제주시"; option.value = "0";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option");
                    option = document.createElement("option"); option.text = "서귀포";
                    option.value = "1";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option");
                    option = document.createElement("option"); option.text = "북제주군"; option.value = "2";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                    option = document.createElement("option");
                    option = document.createElement("option"); option.text = "남제주군"; option.value = "3";
                    document.getElementById("<%=Place2DropDown.ClientID %>").options.add(option);
                }

            }

        function onChangePlace11() {            
         
        $("#<%=place2_DropDownList1.ClientID%>").html("");

            if($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "서울특별시"){
//            if (document.getElementById("<%=place1_DropDownList1.ClientID %>").options[0].selected) {
                var option = document.createElement("option");
                option.text = "종로구";
                option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중구";
                option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "용산구";
                option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성동구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광진구"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동대문구"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중랑구"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성북구"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강북구"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동북구"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "노원구"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "은평구"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서대문구"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "마포구"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양천구"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강서구"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "구로구"; option.value = "16";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "금천구"; option.value = "17";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영등포구"; option.value = "18";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동작구"; option.value = "19";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "관악구"; option.value = "20";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서초구"; option.value = "21";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강남구"; option.value = "22";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "송파구"; option.value = "23";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강동구"; option.value = "24";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);

            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "부산광역시") {
                var option = document.createElement("option");
                option.text = "중구"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영도구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부산진구"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동래구"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "해운대구"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "사하구"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "금정구"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강서구"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "연제구"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "수영구"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "사상구"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "기장군"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "대구광역시") {
                var option = document.createElement("option");
                option.text = "중구"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "수성구"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "달서구"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "달성군"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "인천광역시") {
                var option = document.createElement("option");
                option.text = "중구"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "연수구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남동구"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부평구"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "계양구"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강화군"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "옹진군"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "광주광역시") {
                var option = document.createElement("option");
                option.text = "동구"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광산구"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "대전광역시") {
                var option = document.createElement("option");
                option.text = "동구"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "유성구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "대덕구"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "울산광역시") {
                var option = document.createElement("option");
                option.text = "중구"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울주군"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);

            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "세종특별자치시") {
                var option = document.createElement("option");
                option.text = "세종시"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "경기도") {
                var option = document.createElement("option");
                option.text = "수원시"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장안구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "권선구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "팔달구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영통구"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성남시"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "수정구"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중원구"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "분당구"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의정부시"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안양시"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "만안구"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동안구"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부천시"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "원미구"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "소사구"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "오정구"; option.value = "16";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광명시"; option.value = "17";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "평택시"; option.value = "18";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "송탄시"; option.value = "19";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동두천시"; option.value = "20";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안산시"; option.value = "21";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "상록구"; option.value = "22";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "단원구"; option.value = "23";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고양시"; option.value = "24";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "덕양구"; option.value = "25";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "일산구"; option.value = "26";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "일산동구"; option.value = "27";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "일산서구"; option.value = "28";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "과천시"; option.value = "29";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "구리시"; option.value = "30";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "미금시"; option.value = "31";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남양주시"; option.value = "32";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "오산시"; option.value = "33";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "시흥시"; option.value = "34";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "군포시"; option.value = "35";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의왕시"; option.value = "36";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "하남시"; option.value = "37";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "용인시"; option.value = "38";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "처인구"; option.value = "39";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "기흥구"; option.value = "40";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "수지구"; option.value = "41";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "파주시"; option.value = "42";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "이천시"; option.value = "43";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안성시"; option.value = "44";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김포시"; option.value = "45";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "화성시"; option.value = "46";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광주시"; option.value = "47";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양주시"; option.value = "48";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "포천시"; option.value = "49";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여주시"; option.value = "50";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양주군"; option.value = "51";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남양주군"; option.value = "52";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여주군"; option.value = "53";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "평택군"; option.value = "54";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "화성군"; option.value = "55";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "파주군"; option.value = "56";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광주군"; option.value = "57";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "연천군"; option.value = "58";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "포천군"; option.value = "59";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "가평군"; option.value = "60";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양평군"; option.value = "61";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "이천군"; option.value = "62";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "용인군"; option.value = "63";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안성군"; option.value = "64";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김포군"; option.value = "65";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강화군"; option.value = "66";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "옹진군"; option.value = "67";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "강원도") {
                var option = document.createElement("option");
                option.text = "춘천시"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "원주시"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강릉시"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동해시"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "태백시"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "속초시"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "삼척시"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "춘천군"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "홍천군"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "횡성군"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "원주군"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영월군"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "평창군"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "정선군"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "철원군"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "화천군"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양구군"; option.value = "16";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "인제군"; option.value = "17";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고성군"; option.value = "18";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양양군"; option.value = "19";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "명주군"; option.value = "20";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "삼척군"; option.value = "21";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "충청북도") {
                var option = document.createElement("option");
                option.text = "청주시 서원구"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청주시 청원구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "상당구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "흥덕구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동부출장소"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서부출장소"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "충주시"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "제천시"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청원군"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보은군"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "옥천군"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영동군"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "증평군"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진천군"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "괴산군"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "음성군"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중원군"; option.value = "16";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "제천군"; option.value = "17";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "단양군"; option.value = "18";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "증평출장소"; option.value = "19";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "충청남도") {
                var option = document.createElement("option");
                option.text = "당진시"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "천안시"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동남구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서북구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "공주시"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "대천시"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보령시"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "온양시"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "아산시"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서산시"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "계룡출장소"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "논산시"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "계룡시"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "금산군"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "연기군"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "공주군"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "논산군"; option.value = "16";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부여군"; option.value = "17";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서천군"; option.value = "18";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보령군"; option.value = "19";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청양군"; option.value = "20";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "홍성군"; option.value = "21";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "예산군"; option.value = "22";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서산군"; option.value = "23";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "태안군"; option.value = "24";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "당진군"; option.value = "25";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "아산군"; option.value = "26";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "천안군"; option.value = "27";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "전라북도") {
                var option = document.createElement("option");
                option.text = "전주시"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "완산구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "덕진구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "효자출장소"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "군산시"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "익산시"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보령시"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "온양시"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "아산시"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "정읍시"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남원시"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김제시"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "완주군"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진안군"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "무주군"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장수군"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "임실군"; option.value = "16";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남원군"; option.value = "17";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "순창군"; option.value = "18";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "정읍군"; option.value = "19";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고창군"; option.value = "20";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부안군"; option.value = "21";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김제군"; option.value = "22";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "옥구군"; option.value = "23";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "익산군"; option.value = "24";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "전라남도") {
                var option = document.createElement("option");
                option.text = "목포시"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여수시"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "순천시"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "나주시"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여천시"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동광양시"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "담양군"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "곡성군"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "구례군"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광양군"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여천군"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "승주군"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고흥군"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보성군"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "화순군"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장흥군"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강진군"; option.value = "16";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "해남군"; option.value = "17";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영암군"; option.value = "18";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "무안군"; option.value = "19";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "나주군"; option.value = "20";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "함평군"; option.value = "21";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영광군"; option.value = "22";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장성군"; option.value = "23";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "완도군"; option.value = "24";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진도군"; option.value = "25";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "신안군"; option.value = "26";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "경상북도") {
                var option = document.createElement("option");
                option.text = "포항시"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "경주시"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김천시"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안동시"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "구미시"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영주시"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영천시"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "상주시"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "점촌시"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "문경시"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "경산시"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "달성군"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "군위군"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의성군"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안동군"; option.value = "16";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청송군"; option.value = "17";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영양군"; option.value = "18";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영덕군"; option.value = "19";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영일군"; option.value = "20";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "경주군"; option.value = "21";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영천군"; option.value = "22";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "경산군"; option.value = "23";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청도군"; option.value = "24";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고령군"; option.value = "25";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성주군"; option.value = "26";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "칠곡군"; option.value = "27";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "금릉군"; option.value = "28";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "선산군"; option.value = "29";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "상주군"; option.value = "30";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "문경군"; option.value = "31";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "예천군"; option.value = "32";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영풍군"; option.value = "33";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "봉화군"; option.value = "34";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울진군"; option.value = "35";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울릉군"; option.value = "36";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "경상남도") {
                var option = document.createElement("option");
                option.text = "창원시"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의창구"; option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성산구"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "마산합포구"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "마산회원구"; option.value = "4";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진해구"; option.value = "5";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "창원시"; option.value = "6";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울산시"; option.value = "7";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "합포구"; option.value = "8";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "회원구"; option.value = "9";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "마산시"; option.value = "10";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진주시"; option.value = "11";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진해시"; option.value = "12";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "충무시"; option.value = "13";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "통영시"; option.value = "14";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "삼천포시"; option.value = "15";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "사천시"; option.value = "16";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김해시"; option.value = "17";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "밀양시"; option.value = "18";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장승포시"; option.value = "19";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "거제시"; option.value = "20";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양산시"; option.value = "21";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진양군"; option.value = "22";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의령군"; option.value = "23";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "함안군"; option.value = "24";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "창녕군"; option.value = "25";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "밀양군"; option.value = "26";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양산군"; option.value = "27";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울산군"; option.value = "28";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김해군"; option.value = "29";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "창원군"; option.value = "30";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "통영군"; option.value = "31";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "거제군"; option.value = "32";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고성군"; option.value = "33";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "사천군"; option.value = "34";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남해군"; option.value = "35";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "하동군"; option.value = "36";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "산청군"; option.value = "37";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "함양군"; option.value = "38";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "거창군"; option.value = "39";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "합천군"; option.value = "40";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);

            }
            else if ($("#<%=place1_DropDownList1.ClientID%> option:selected").text() == "제주특별자치도") {
                var option = document.createElement("option");
                option.text = "제주시"; option.value = "0";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option");
                option = document.createElement("option"); option.text = "서귀포";
                option.value = "1";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option");
                option = document.createElement("option"); option.text = "북제주군"; option.value = "2";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
                option = document.createElement("option");
                option = document.createElement("option"); option.text = "남제주군"; option.value = "3";
                document.getElementById("<%=place2_DropDownList1.ClientID %>").options.add(option);
            }

        }

        function onChangePlace1() {
            $("#<%=place2_dropdownlist.ClientID%>").html("");            
            if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "서울특별시") {
                //            if (document.getElementById("<%=place1_dropdownlist.ClientID %>").options[0].selected) {
                var option = document.createElement("option");
                option.text = "종로구";
                option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중구";
                option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "용산구";
                option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성동구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광진구"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동대문구"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중랑구"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성북구"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강북구"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동북구"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "노원구"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "은평구"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서대문구"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "마포구"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양천구"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강서구"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "구로구"; option.value = "16";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "금천구"; option.value = "17";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영등포구"; option.value = "18";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동작구"; option.value = "19";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "관악구"; option.value = "20";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서초구"; option.value = "21";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강남구"; option.value = "22";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "송파구"; option.value = "23";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강동구"; option.value = "24";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);

            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "부산광역시") {
                var option = document.createElement("option");
                option.text = "중구"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영도구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부산진구"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동래구"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "해운대구"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "사하구"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "금정구"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강서구"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "연제구"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "수영구"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "사상구"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "기장군"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "대구광역시") {
                var option = document.createElement("option");
                option.text = "중구"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "수성구"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "달서구"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "달성군"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "인천광역시") {
                var option = document.createElement("option");
                option.text = "중구"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "연수구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남동구"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부평구"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "계양구"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강화군"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "옹진군"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "광주광역시") {
                var option = document.createElement("option");
                option.text = "동구"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광산구"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "대전광역시") {
                var option = document.createElement("option");
                option.text = "동구"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "유성구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "대덕구"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "울산광역시") {
                var option = document.createElement("option");
                option.text = "중구"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울주군"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);

            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "세종특별자치시") {
                var option = document.createElement("option");
                option.text = "세종시"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "경기도") {
                var option = document.createElement("option");
                option.text = "수원시"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장안구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "권선구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "팔달구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영통구"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성남시"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "수정구"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중원구"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "분당구"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의정부시"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안양시"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "만안구"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동안구"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부천시"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "원미구"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "소사구"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "오정구"; option.value = "16";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광명시"; option.value = "17";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "평택시"; option.value = "18";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "송탄시"; option.value = "19";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동두천시"; option.value = "20";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안산시"; option.value = "21";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "상록구"; option.value = "22";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "단원구"; option.value = "23";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고양시"; option.value = "24";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "덕양구"; option.value = "25";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "일산구"; option.value = "26";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "일산동구"; option.value = "27";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "일산서구"; option.value = "28";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "과천시"; option.value = "29";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "구리시"; option.value = "30";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "미금시"; option.value = "31";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남양주시"; option.value = "32";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "오산시"; option.value = "33";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "시흥시"; option.value = "34";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "군포시"; option.value = "35";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의왕시"; option.value = "36";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "하남시"; option.value = "37";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "용인시"; option.value = "38";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "처인구"; option.value = "39";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "기흥구"; option.value = "40";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "수지구"; option.value = "41";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "파주시"; option.value = "42";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "이천시"; option.value = "43";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안성시"; option.value = "44";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김포시"; option.value = "45";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "화성시"; option.value = "46";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광주시"; option.value = "47";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양주시"; option.value = "48";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "포천시"; option.value = "49";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여주시"; option.value = "50";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양주군"; option.value = "51";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남양주군"; option.value = "52";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여주군"; option.value = "53";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "평택군"; option.value = "54";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "화성군"; option.value = "55";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "파주군"; option.value = "56";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광주군"; option.value = "57";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "연천군"; option.value = "58";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "포천군"; option.value = "59";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "가평군"; option.value = "60";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양평군"; option.value = "61";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "이천군"; option.value = "62";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "용인군"; option.value = "63";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안성군"; option.value = "64";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김포군"; option.value = "65";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강화군"; option.value = "66";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "옹진군"; option.value = "67";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "강원도") {
                var option = document.createElement("option");
                option.text = "춘천시"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "원주시"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강릉시"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동해시"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "태백시"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "속초시"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "삼척시"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "춘천군"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "홍천군"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "횡성군"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "원주군"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영월군"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "평창군"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "정선군"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "철원군"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "화천군"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양구군"; option.value = "16";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "인제군"; option.value = "17";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고성군"; option.value = "18";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양양군"; option.value = "19";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "명주군"; option.value = "20";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "삼척군"; option.value = "21";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "충청북도") {
                var option = document.createElement("option");
                option.text = "청주시 서원구"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청주시 청원구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "상당구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "흥덕구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동부출장소"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서부출장소"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "충주시"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "제천시"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청원군"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보은군"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "옥천군"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영동군"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "증평군"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진천군"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "괴산군"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "음성군"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "중원군"; option.value = "16";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "제천군"; option.value = "17";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "단양군"; option.value = "18";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "증평출장소"; option.value = "19";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "충청남도") {
                var option = document.createElement("option");
                option.text = "당진시"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "천안시"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동남구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서북구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "공주시"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "대천시"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보령시"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "온양시"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "아산시"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서산시"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "계룡출장소"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "논산시"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "계룡시"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "금산군"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "연기군"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "공주군"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "논산군"; option.value = "16";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부여군"; option.value = "17";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서천군"; option.value = "18";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보령군"; option.value = "19";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청양군"; option.value = "20";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "홍성군"; option.value = "21";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "예산군"; option.value = "22";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "서산군"; option.value = "23";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "태안군"; option.value = "24";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "당진군"; option.value = "25";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "아산군"; option.value = "26";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "천안군"; option.value = "27";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "전라북도") {
                var option = document.createElement("option");
                option.text = "전주시"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "완산구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "덕진구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "효자출장소"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "군산시"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "익산시"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보령시"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "온양시"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "아산시"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "정읍시"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남원시"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김제시"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "완주군"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진안군"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "무주군"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장수군"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "임실군"; option.value = "16";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남원군"; option.value = "17";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "순창군"; option.value = "18";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "정읍군"; option.value = "19";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고창군"; option.value = "20";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "부안군"; option.value = "21";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김제군"; option.value = "22";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "옥구군"; option.value = "23";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "익산군"; option.value = "24";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "전라남도") {
                var option = document.createElement("option");
                option.text = "목포시"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여수시"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "순천시"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "나주시"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여천시"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "동광양시"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "담양군"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "곡성군"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "구례군"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "광양군"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "여천군"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "승주군"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고흥군"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "보성군"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "화순군"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장흥군"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "강진군"; option.value = "16";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "해남군"; option.value = "17";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영암군"; option.value = "18";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "무안군"; option.value = "19";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "나주군"; option.value = "20";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "함평군"; option.value = "21";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영광군"; option.value = "22";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장성군"; option.value = "23";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "완도군"; option.value = "24";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진도군"; option.value = "25";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "신안군"; option.value = "26";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "경상북도") {
                var option = document.createElement("option");
                option.text = "포항시"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "북구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "경주시"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김천시"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안동시"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "구미시"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영주시"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영천시"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "상주시"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "점촌시"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "문경시"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "경산시"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "달성군"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "군위군"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의성군"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "안동군"; option.value = "16";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청송군"; option.value = "17";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영양군"; option.value = "18";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영덕군"; option.value = "19";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영일군"; option.value = "20";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "경주군"; option.value = "21";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영천군"; option.value = "22";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "경산군"; option.value = "23";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "청도군"; option.value = "24";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고령군"; option.value = "25";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성주군"; option.value = "26";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "칠곡군"; option.value = "27";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "금릉군"; option.value = "28";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "선산군"; option.value = "29";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "상주군"; option.value = "30";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "문경군"; option.value = "31";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "예천군"; option.value = "32";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "영풍군"; option.value = "33";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "봉화군"; option.value = "34";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울진군"; option.value = "35";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울릉군"; option.value = "36";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "경상남도") {
                var option = document.createElement("option");
                option.text = "창원시"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의창구"; option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "성산구"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "마산합포구"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "마산회원구"; option.value = "4";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진해구"; option.value = "5";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "창원시"; option.value = "6";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울산시"; option.value = "7";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "합포구"; option.value = "8";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "회원구"; option.value = "9";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "마산시"; option.value = "10";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진주시"; option.value = "11";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진해시"; option.value = "12";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "충무시"; option.value = "13";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "통영시"; option.value = "14";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "삼천포시"; option.value = "15";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "사천시"; option.value = "16";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김해시"; option.value = "17";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "밀양시"; option.value = "18";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "장승포시"; option.value = "19";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "거제시"; option.value = "20";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양산시"; option.value = "21";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "진양군"; option.value = "22";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "의령군"; option.value = "23";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "함안군"; option.value = "24";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "창녕군"; option.value = "25";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "밀양군"; option.value = "26";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "양산군"; option.value = "27";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "울산군"; option.value = "28";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "김해군"; option.value = "29";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "창원군"; option.value = "30";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "통영군"; option.value = "31";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "거제군"; option.value = "32";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "고성군"; option.value = "33";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "사천군"; option.value = "34";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "남해군"; option.value = "35";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "하동군"; option.value = "36";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "산청군"; option.value = "37";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "함양군"; option.value = "38";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "거창군"; option.value = "39";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option"); option.text = "합천군"; option.value = "40";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);

            }
            else if ($("#<%=place1_dropdownlist.ClientID%> option:selected").text() == "제주특별자치도") {
                var option = document.createElement("option");
                option.text = "제주시"; option.value = "0";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option");
                option = document.createElement("option"); option.text = "서귀포";
                option.value = "1";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option");
                option = document.createElement("option"); option.text = "북제주군"; option.value = "2";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
                option = document.createElement("option");
                option = document.createElement("option"); option.text = "남제주군"; option.value = "3";
                document.getElementById("<%=place2_dropdownlist.ClientID %>").options.add(option);
            }
}




    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="edtObjID" />
        <table cellpadding="0" cellspacing="0" width="1240" align="center">
            <tr>
                <td width="1240" height="849" valign="top">
                    <table cellpadding="0" cellspacing="0" width="1240" style="height:100%">
                        <tbody><tr>
                            <td width="252" valign="top" bgcolor="#F9FAFE" height="997" style="border-width:1; border-right-color:rgb(235,235,235); border-top-style:none; border-right-style:solid; border-bottom-style:none; border-left-style:none;">
                                <asp:Literal runat="server" ID="statListData"></asp:Literal>
                            </td>

                            <td width="948" valign="top" height="997" style="background-color: white;">
                                <div id="campaignStat" runat="server">
                                <table cellpadding="0" cellspacing="0" width="891" align="center">
                                    <tbody><tr>
                                        <td width="891">&nbsp;</td>
                                    </tr>
                                </tbody></table>
                                <table cellpadding="0" cellspacing="0" width="890" align="center">
                                    <tbody><tr>
                                        <td width="890" height="57">
                                            <table cellpadding="0" cellspacing="0" width="886" align="center">
                                                <tbody>
                                                    <tr>
                                                        <asp:Literal runat="server" ID="Campain_title"></asp:Literal>
                                                        <td width="456" height="50">
                                                            <div id ="stat_search1" runat="server">
                                                                <table cellpadding="0" cellspacing="0" width="365">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td>
                                                                                <div style="width:170px;height:38px; background-image:url('IMG/search_txtbox.png'); height:37px;">
                                                                                    <div id="stat_searchtxt1">
                                                                                        <asp:TextBox ID="StartDate1" runat="server" Height="23px" style="margin-left:12px;margin-top:5px;" BorderStyle="None" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="140px"></asp:TextBox>
                                                                                        <ajax:CalendarExtender ID="cldStartDate1" runat="server" TargetControlID="StartDate1" Format="yyyy-MM-dd" />
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                            <td width="27" height="38"><p align="center"><b><font color="#999999">-</font></b></p>
                                                                            </td>
                                                                            <td>
                                                                                <div style="width:170px;height:38px; background-image:url('IMG/search_txtbox.png'); height:37px;">
                                                                                    <div id="stat_searchtxt2">
                                                                                        <asp:TextBox ID="EndDate1" runat="server" Height="23px" style="margin-left:12px;margin-top:5px;" BorderStyle="None" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="140px"></asp:TextBox>
                                                                                        <ajax:CalendarExtender ID="cldEndDate1" runat="server" TargetControlID="EndDate1" Format="yyyy-MM-dd" />
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                            <td width="141" height="50" style="padding-left:30px">
                                                                                <p align="right"><a onclick="onSearch(1)" style="cursor:pointer">
                                                                                <img src="IMG/bt_search.png" width="122" height="37" border="0" name="image2" alt="" />
                                                                                </a></p>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="890" height="134">
                                            <asp:Literal runat="server" ID="statSumListData"></asp:Literal>
                                        </td>
                                    </tr>
                                </tbody></table>
                                <table cellpadding="0" cellspacing="0" width="891" align="center">
                                    <tbody><tr>
                                        <td width="891" height="70">
                                            <div id="stat_search2" align="right"  runat="server">
                                                <table cellpadding="0" cellspacing="0" >
                                                    <tbody><tr>
<!--                                                        <td width="169" height="50">
                                                            <div style="background-image:url('IMG/search_box.png');height: 39px;width: 150px;line-height: 39px;text-align: center;">
                                                                <span style="font-size:11pt;"><font face="돋움" color="#666666">유저</font></span>
                                                                <span style="float:right;margin-right:15px;"><font color="#666666">▼</font></span>
                                                            </div>
                                                        </td>
-->
                                                    <td width="169">
                                                        <div style="background-image:url('IMG/search_txtbox.png');height: 38px;width: 169px;line-height: 39px;text-align: center;">
                                                            <div id="stat_searchtxt3">
                                                                <asp:TextBox ID="StartDate2" runat="server" Height="23px" style="margin-left:12px;margin-top:5px;" BorderStyle="None" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="140px"></asp:TextBox>
                                                                <ajax:CalendarExtender ID="cldStartDate2" runat="server" TargetControlID="StartDate2" Format="yyyy-MM-dd" />
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td width="27" height="38"><p align="center"><b><font color="#999999">-</font></b></p></td>
                                                    <td width="169">
                                                        <div style="background-image:url('IMG/search_txtbox.png');height: 38px;width: 169px;line-height: 39px;text-align: center;">
                                                            <div id="stat_searchtxt4">
                                                                <asp:TextBox ID="EndDate2" runat="server" Height="23px" style="margin-left:12px;margin-top:5px;" BorderStyle="None" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="140px"></asp:TextBox>
                                                                <ajax:CalendarExtender ID="cldEndDate2" runat="server" TargetControlID="EndDate2" Format="yyyy-MM-dd" />
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td width="132" height="50" style="text-align:right;">
                                                        <a onclick="onSearch(2)" style="cursor:pointer">
                                                            <img src="IMG/bt_search.png" width="122" height="37" border="0" name="image2" alt="" />
                                                        </a>
                                                    </td></tr></tbody>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody></table>
                                <table cellpadding="0" cellspacing="0" width="890" align="center">
                                    <tbody><tr>
                                        <td width="890" height="57">
                                            <table cellpadding="0" cellspacing="0" width="886" align="center">
                                                <tbody><tr>
                                                    <td width="289" height="50">
                                                        <p><b><font face="돋움" color="#555555"><span style="font-size:11pt;">캠페인별 통계</span></font></b></p>
                                                    </td>
                                                    <td width="456" height="50">
                                                    <div align="right">
                                                            <p>&nbsp;</p>
                                                        </div>
                                                    </td>
                                                    <td width="141" height="50">
                                                        <p align="right">&nbsp;</p>
                                                    </td>
                                                </tr>
                                            </tbody></table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <asp:Literal runat="server" ID="statCampainData"></asp:Literal>
                                        <asp:Literal runat="server" ID="statpageData"></asp:Literal>
                                    </tr>
                                </tbody></table>

                                </div>

                                <div id="userstatdata" runat="server">
                                    <table cellpadding="0" cellspacing="0" width="891" align="center">
                                        <tbody><tr>
                                            <td width="891">&nbsp;</td>
                                        </tr>
                                    </tbody></table>
                                    <table cellpadding="0" cellspacing="0" width="890" align="center">
                                        <tbody><tr>
                                            <td width="890" height="57">
                                                <table cellpadding="0" cellspacing="0" width="886" align="center">
                                                    <tbody><tr>
                                                        <td width="289" height="50">
                                                            <p><b><font face="돋움" color="#555555"><span style="font-size:11pt;">유저 통계</span></font></b></p>
                                                        </td>
                                                        <td width="456" height="50">                                                            
                                                            <div align="right">
                                                                <p>&nbsp;</p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="890" height="85">
                                                <table cellpadding="0" cellspacing="0" width="888" align="center">
                                                    <tbody><tr>
                                                        <td width="76" height="53">
                                                            <p align="right" style="width:50px"><font face="돋움" color="#555555"><span style="font-size:11pt;">가입일</span></font></p>
                                                        </td>
                                                        <td width="203" height="33">
                                                            <table cellpadding="0" cellspacing="0" width="195">
                                                                <tbody><tr>
                                                                    <td width="90" height="23">
                                                                        <asp:TextBox ID="RegStartDate1" runat="server" Height="23px" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="90px"></asp:TextBox>
                                                                        <ajax:CalendarExtender ID="clsRegStartDate1" runat="server" TargetControlID="RegStartDate1" Format="yyyy-MM-dd" />
                                                                    </td>
                                                                    <td width="25" height="30">
                                                                        <p align="center">~</p>
                                                                    </td>
                                                                    <td width="90" height="23">
                                                                        <asp:TextBox ID="RegEndDate1" runat="server" Height="23px" style="margin-left:0px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" onblur="checkDateTime(this, true);" CssClass="clsinput" Width="90px"></asp:TextBox>
                                                                        <ajax:CalendarExtender ID="clsRegEndDate1" runat="server" TargetControlID="RegEndDate1" Format="yyyy-MM-dd" />
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                        </td>
                                                        <td width="105" height="33">
                                                            <table cellpadding="0" cellspacing="0" width="121">
                                                                <tbody><tr>
                                                                    <td width="101" height="33">
                                                                        <asp:DropDownList id="MarriedDropDown" runat="server" style="margin-left:10px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;"  AppendDataBoundItems="true" Width="100" Height="25">
                                                                            <asp:ListItem Value="0" Text="기혼" /><asp:ListItem Value="1" Text="미혼" />
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                        </td>
                                                        <td width="105" height="53">
                                                            <table cellpadding="0" cellspacing="0" width="121">
                                                                <tbody><tr>
                                                                    <td width="101" height="33">
                                                                        <asp:DropDownList id="SexDropDown" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" runat="server" AppendDataBoundItems="true" Width="100" Height="25">
                                                                            <asp:ListItem Value="0" Text="남자" /><asp:ListItem Value="1" Text="여자" />
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                        </td>
                                                        <td width="125" height="53">
                                                            <asp:DropDownList id="Place1DropDown" runat="server" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" AppendDataBoundItems="true" Width="125" Height="25" onchange="onChangePlace()">
                                                                <asp:ListItem Value="0" Text="서울특별시" /><asp:ListItem Value="1" Text="부산광역시" /><asp:ListItem Value="2" Text="대구광역시" />
                                                                <asp:ListItem Value="3" Text="인천광역시" /><asp:ListItem Value="4" Text="광주광역시" /><asp:ListItem Value="5" Text="대전광역시" />
                                                                <asp:ListItem Value="6" Text="울산광역시" /><asp:ListItem Value="7" Text="세종특별자치시" /><asp:ListItem Value="8" Text="경기도" />
                                                                <asp:ListItem Value="9" Text="강원도" /><asp:ListItem Value="10" Text="충청북도" /><asp:ListItem Value="11" Text="충청남도" />
                                                                <asp:ListItem Value="12" Text="전라북도" /><asp:ListItem Value="13" Text="전라남도" /><asp:ListItem Value="14" Text="경상북도" />
                                                                <asp:ListItem Value="15" Text="경상남도" /><asp:ListItem Value="16" Text="제주특별자치도" />
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td width="125" height="53" style="padding-left: 10px;" >
                                                            <asp:DropDownList id="Place2DropDown" runat="server" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;"  AppendDataBoundItems="true" Width="125" Height="25">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td width="129" height="53" style="padding-left:10px">
                                                            <p align="right">
                                                                <a onclick="search_UserStat()" style="cursor:pointer">
                                                                    <img src="IMG/bt_search2.png" width="120" height="33" border="0" name="image3" alt="" /></a></p>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                    <table cellpadding="0" cellspacing="0" width="891" align="center">
                                        <tbody><tr>
                                            <td width="891" height="32">&nbsp;</td>
                                        </tr>
                                    </tbody></table>
                                    <table cellpadding="0" cellspacing="0" width="890" align="center">
                                        <tbody><tr>
                                            <td width="890" height="595" valign="top">
                                                <asp:Literal runat="server" ID="userStatListData"></asp:Literal>
                                                <asp:Literal runat="server" ID="userpageData"></asp:Literal>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </div>
                            </td>
                        </tr>
                    </tbody></table>
                    <asp:Literal runat="server" ID="statFooterPage"></asp:Literal>
                </td>
            </tr>
        </table>

    <div id="dvChangeUser"  class="clspopup">
        <table cellpadding="0" cellspacing="0" width="650">
            <tbody><tr>
                <td width="650" height="10" bgcolor="#5D81EC"></td>
            </tr>
            <tr>
                <td width="650" height="670" bgcolor="white">
                    <table cellpadding="0" cellspacing="0" width="580" align="center">
                        <tbody><tr>
                            <td width="580" height="55">
                                <table cellpadding="0" cellspacing="0" width="482">
                                    <tbody><tr>
                                        <td width="213" height="25">
                                            <b><font face="돋움" color="#CCCCCC">아이디 : [ <span style="font-size:11pt;" id="changeid"></span> ]</font></b>
                                        </td>
                                        <td width="299" style="padding-left:20px;" height="25">
                                            <b><font face="돋움" color="#CCCCCC">비밀번호 : <input type="text" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" id="changepwd" /></span> </font></b>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                            <tr>
                            <td width="580" >
                                <table cellpadding="0" cellspacing="0" width="578" style="border-collapse:collapse;">
                                    <tbody><tr>
                                        <td width="251" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                                <p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">이메일</font></b></span></p>
                                        </td>
                                        <td width="125" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                                <p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">출생년도</font></b></span></p>
                                        </td>
                                        <td width="98" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                                <p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">결혼</font></b></span></p>
                                        </td>
                                        <td width="99" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                            <p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">성별</font></b></span></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="251">
                                            <table cellpadding="0" cellspacing="0" width="207" align="center">
                                            <tbody><tr>
                                                <td width="205" height="27">
                                                    <input type="text" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" id="changeemail" />
                                                </td>
                                            </tr>
                                            </tbody></table>
                                        </td>                                    
                                        <td width="125" height="45">
                                                <table cellpadding="0" cellspacing="0" width="100" align="center">
                                                <tbody><tr>
                                                    <td width="98" height="27" >
                                                        <asp:DropDownList id="birthyear_DropDownList1" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" runat="server" AppendDataBoundItems="true" Width="120" Height="25">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                </tbody></table>
                                            </td>                                    
                                            <td width="98" height="45" align="center">
                                                <span style="font-size:11pt;" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;"><b><font face="돋움" color="#999999">
                                                    <a onclick="onChangeMarrid()" id="changemarried" style="cursor:pointer"></a></font></b></span>
                                            </td>
                                        <td width="99" height="45" bgcolor="#F1F2F6"align="center">
                                                <span style="font-size:11pt;" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;"><b><font face="돋움" color="#999999">
                                                    <a onclick="onChangeSex()" id="changesex" style="cursor:pointer"></a></font></b></span>
                                        </td>
                                    </tr>
                                </tbody></table>
                                    <table cellpadding="0" cellspacing="0" width="578" style="border-collapse:collapse;">
                                    <tbody><tr>
                                        <td width="117"  bgcolor="#666666" >
                                                <p align="center"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">주소</font></b></span></p>
                                        </td>
                                        <td width="186" >
                                        <asp:DropDownList AutoPostBack="false" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" id="place1_DropDownList1" runat="server" AppendDataBoundItems="true" Width="180" Height="25" onchange="onChangePlace11()">
                                            <asp:ListItem Value="0" Text="서울특별시" /><asp:ListItem Value="1" Text="부산광역시" /><asp:ListItem Value="2" Text="대구광역시" />
                                            <asp:ListItem Value="3" Text="인천광역시" /><asp:ListItem Value="4" Text="광주광역시" /><asp:ListItem Value="5" Text="대전광역시" />
                                            <asp:ListItem Value="6" Text="울산광역시" /><asp:ListItem Value="7" Text="세종특별자치시" /><asp:ListItem Value="8" Text="경기도" />
                                            <asp:ListItem Value="9" Text="강원도" /><asp:ListItem Value="10" Text="충청북도" /><asp:ListItem Value="11" Text="충청남도" />
                                            <asp:ListItem Value="12" Text="전라북도" /><asp:ListItem Value="13" Text="전라남도" /><asp:ListItem Value="14" Text="경상북도" />
                                            <asp:ListItem Value="15" Text="경상남도" /><asp:ListItem Value="16" Text="제주특별자치도" />
                                        </asp:DropDownList>
                                        </td>
                                        <td width="271">
                                            <asp:DropDownList id="place2_DropDownList1" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" runat="server" AppendDataBoundItems="true" Width="120" Height="25">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    </tbody></table>
                            </td>
                            </tr>
                            <tr>
                            <td width="580" height="21">
                                <p>&nbsp;</p>
                            </td>
                            </tr>
                        <tr>
                            <td width="580" height="33">
                                <p style="margin-bottom:3px;margin-top:3px;"><b><span style="font-size:11pt;" id="changecampaigncount"><font face="돋움" color="#666666"></font></span></b></p>
                            </td>
                        </tr>
                        <tr>
                            <td width="580" height="328" valign="top">
                                <div id="detail222"></div>
                            </td>
                        </tr>
                        <tr>
                            <td width="580" height="70">
                                <table cellpadding="0" cellspacing="0" align="center" width="290">
                                    <tbody><tr>
                                        <td width="145" height="36">
                                            <p align="center"><a onclick = "OnChangeuser_confirm()" style="cursor:pointer" >
                                                <img src="IMG/bt_confirm.png" border="0" width="122" height="37" name="image1" alt="" /></a></p>
                                        </td>
                                        <td width="145" height="36">
                                            <p align="center"><a onclick = "closePopup();" style="cursor:pointer">
                                                <img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image1" alt="" /></a></p>
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

    <div id="dvDeleteUser"  class="clspopup">
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tbody><tr>
                    <td width="450" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="450" height="199" bgcolor="white">
                        <table cellpadding="0" cellspacing="0" width="410" align="center">
                            <tbody><tr>
                                <td width="410" height="114">
                                    <asp:HiddenField ID="userID" Value="0" runat="server" />
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">유저를 삭제합니다.</font></span></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="410" height="49">
                                    <table cellpadding="0" cellspacing="0" align="center" width="290">
                                        <tbody><tr>
                                            <td width="145" height="36">
                                                <asp:ImageButton runat="server" ID="btnDelUser" Width="122" Height="37"  onclick="btnDelUser_Click1" ImageUrl="IMG/bt_confirm.png"/>
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

    <div id="dvDetailUser" class="clspopup">
<table cellpadding="0" cellspacing="0" width="650">
    <tbody><tr>
        <td width="650" height="10" bgcolor="#5D81EC"></td>
    </tr>
    <tr>
        <td width="650" height="670" bgcolor="white">

            <table cellpadding="0" cellspacing="0" width="580" align="center">
                <tbody><tr>
                    <td width="580" height="55">

                        <table cellpadding="0" cellspacing="0" width="482">
                            <tbody><tr>
                                <td width="203" height="40">
                                    <p><b><span style="font-size:11pt;">
                                        <font face="돋움" color="#666666"><div id="detailTitle"></div></font></span></b></p>
                                </td>
                                <td width="269" style="padding-left:20px;" height="40">
                                    <p><b><span style="font-size:11pt;">
                                        <font face="돋움" color="#666666"><div id="detailpwd"></div></font></span></b></p>
                                </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
                    <tr>
                    <td width="580">
                        <table cellpadding="0" cellspacing="0" width="578" style="border-collapse:collapse;">
                            <thead><tr>
                                <td width="251"  bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                        <p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">이메일</font></b></span></p>
                                </td>
                                <td width="125"  bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                        <p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">출생년도</font></b></span></p>
                                </td>
                                <td width="98"  bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                        <p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">결혼</font></b></span></p>
                                </td>
                                <td width="99" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">

                                    <p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">성별</font></b></span></p>
                                </td>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td width="251">
                                        <p align="center"><span style="font-size:11pt;"  id="detailemail"><font face="돋움" color="#666666"></font></span></p>
                    </td>                                    <td width="125">
                                        <p align="center"><span style="font-size:11pt;"  id="detailbirthyear"><font face="돋움" color="#666666"></font></span></p>

                                    </td>                                    <td width="98">
                                        <p align="center"><span style="font-size:11pt;"  id="detailmarried"><font face="돋움" color="#666666"></font></span></p>
                                    </td>
                                <td width="99">

                                    <p align="center"><span style="font-size:11pt;" id="detailsex"><font face="돋움" color="#666666"></font></span></p>
                                </td>
                            </tr>
                        </tbody></table>

                           

                    </td>
                    </tr>
                    <tr><td height="20">
                         <table cellpadding="0" cellspacing="0" width="578" style="border-collapse:collapse;">
                            <tbody><tr>
                                <td width="117" height="30" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;text-align:center;">
                                        <span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">주소</font></b></span>
                                </td>                                <td width="458" height="30" style="border-width:1; border-color:white;text-align:center; border-top-style:solid; border-right-style:none; border-bottom-style:solid; border-left-style:solid;" bgcolor="#F1F2F6">
                                       <span style="font-size:11pt;" id="detailplace"><font face="돋움" color="#666666"></font></span>
                                </td>
                            </tr>
                            </tbody></table>
                        </td>
                    </tr>
                    <tr>
                    <td width="580" height="21">
                        <p>&nbsp;</p>
                    </td>
                    </tr>
                <tr>
                    <td width="580" height="33">
                        <p><b><span style="font-size:11pt;" id="detailcampaigncount"><font face="돋움" color="#666666">참여 캠페인 :</font></span></b></p>
                    </td>
                </tr>
                <tr>
                    <td width="580" height="341" valign="top">
                        <div id="detail111">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="580" height="70">
                        <table cellpadding="0" cellspacing="0" align="center" width="290">
                            <tbody><tr>
                                <td width="145" height="36">
                                    <p align="center"><a onclick="closePopup()" style="cursor:pointer" ><img src="IMG/bt_confirm.png" border="0" width="122" height="37" name="image1"></a></p>
                                </td>
                                <td width="145" height="36">
                                    <p align="center"><a onclick="closePopup()" style="cursor:pointer"><img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image2"></a></p>
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

    <div id="dvAddUser" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="650">
        <tbody><tr>
            <td width="650" height="10" bgcolor="#5D81EC"></td>
        </tr>
        <tr>
            <td width="650" height="320" bgcolor="white" style="border-collapse:collapse;">
                <table cellpadding="0" cellspacing="0" width="580" align="center">
                    <tbody><tr>
                        <td width="580" height="55">
                            <table cellpadding="0" cellspacing="0" width="482">
                                <tbody><tr>
                                    <td width="113" height="40">
                                        <p style="width:110px"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">[회원 아이디]</font></span></b></p>
                                    </td>
                                    <td width="369" height="40">
                                        <asp:TextBox runat="server" ID="useridTxt" Width="100%" Font-Size="12" Height="25" CssClass="control" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" MaxLength="50"></asp:TextBox>
                                    </td>
                                    <td width="93" height="40" style="padding-left:20px">
                                        <p style="width:90px"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">[비밀번호]</font></span></b></p>
                                    </td>
                                    <td width="369" height="40">
                                        <asp:TextBox runat="server" ID="userpwdTxt" Width="100%" Font-Size="12" Height="25" CssClass="control" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" MaxLength="50"></asp:TextBox>
                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                    <tr>
                        <td width="580" height="155">
                            <table cellpadding="0" cellspacing="0" width="578" style="border-collapse:collapse;">
                                <thead><tr>
                                    <td width="251" height="35" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                        <p align="center"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">이메일</font></b></span></p>
                                    </td>
                                    <td width="125" height="35" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                        <p align="center"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">출생년도</font></b></span></p>
                                    </td>
                                    <td width="98" height="35" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                        <p align="center"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">결혼</font></b></span></p>
                                    </td>
                                    <td width="99" height="35" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                        <p align="center"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">성별</font></b></span></p>
                                    </td>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td width="251" height="45">
                                        <table cellpadding="0" cellspacing="0" width="207" align="center">
                                            <tbody><tr>
                                                <td width="205" height="27">
                                                    <asp:TextBox runat="server" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" ID="emailTxt" Width="100%" Font-Size="12" Height="25" CssClass="control" MaxLength="50"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                    <td width="125" height="25" >
                                        <asp:DropDownList id="birth_year_dropdownlist" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" runat="server" AppendDataBoundItems="true" Width="120" Height="25">
                                            <asp:ListItem Value="0" Text="1950" />
                                            <asp:ListItem Value="1" Text="1990" />
                                            <asp:ListItem Value="2" Text="2000" />
                                        </asp:DropDownList>
                                    </td>
                                    <td width="98" height="25">
                                        <asp:DropDownList id="married_dropdownlist" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" runat="server" AppendDataBoundItems="true" Width="95" Height="25">
                                            <asp:ListItem Value="0" Text="기혼" />
                                            <asp:ListItem Value="1" Text="미혼" />
                                        </asp:DropDownList>
                                    </td>
                                    <td width="99" height="45" bgcolor="#F1F2F6">
                                        <asp:DropDownList id="sex_dropdownlist" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" runat="server" AppendDataBoundItems="true" Width="95" Height="25">
                                            <asp:ListItem Value="0" Text="남자" />
                                            <asp:ListItem Value="1" Text="여자" />
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </tbody></table>
                            <table cellpadding="0" cellspacing="0" width="578" style="border-collapse:collapse;">
                                <tbody><tr>
                                    <td width="117" bgcolor="#666666" style="border-width:1; border-color:white; border-style:solid;">
                                        <p align="center" style="margin-bottom:3px;margin-top:3px;"><span style="font-size:11pt;"><b><font face="돋움" color="#CCCCCC">주소</font></b></span></p>
                                    </td>

                                    <td width="186" height="25">
                                        <asp:DropDownList AutoPostBack="false" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" id="place1_dropdownlist" runat="server" AppendDataBoundItems="true" Width="180" Height="25" onchange="onChangePlace1()">
                                            <asp:ListItem Value="0" Text="서울특별시" /><asp:ListItem Value="1" Text="부산광역시" /><asp:ListItem Value="2" Text="대구광역시" />
                                            <asp:ListItem Value="3" Text="인천광역시" /><asp:ListItem Value="4" Text="광주광역시" /><asp:ListItem Value="5" Text="대전광역시" />
                                            <asp:ListItem Value="6" Text="울산광역시" /><asp:ListItem Value="7" Text="세종특별자치시" /><asp:ListItem Value="8" Text="경기도" />
                                            <asp:ListItem Value="9" Text="강원도" /><asp:ListItem Value="10" Text="충청북도" /><asp:ListItem Value="11" Text="충청남도" />
                                            <asp:ListItem Value="12" Text="전라북도" /><asp:ListItem Value="13" Text="전라남도" /><asp:ListItem Value="14" Text="경상북도" />
                                            <asp:ListItem Value="15" Text="경상남도" /><asp:ListItem Value="16" Text="제주특별자치도" />
                                        </asp:DropDownList>
                                    </td>

                                    <td width="271" height="25">
                                        <asp:DropDownList id="place2_dropdownlist" style="margin-left:12px;margin-top:5px;border-width:1; border-color:gainsboro; border-style:solid;" runat="server" AppendDataBoundItems="true" Width="270" Height="25">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                    <tr>
                        <td width="580" height="70">
                            <table cellpadding="0" cellspacing="0" align="center" width="290">
                                <tbody><tr>
                                    <td width="145" height="36">
                                        <p align="center"><a onclick="OnNewUser()" style="cursor:pointer">
                                            <img src="IMG/bt_confirm.png" border="0" width="122" height="37" name="image1" alt="" /></a></p>
                                    </td>
                                    <td width="145" height="36">
                                        <p align="center"><a onclick="closePopup();" style="cursor:pointer">
                                            <img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image2" alt="" /></a></p>
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
</asp:Content>

