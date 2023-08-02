<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true"
    CodeBehind="detailContent.aspx.cs" Inherits="nocutAR.Account.detailContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/detailcontents_opt.js" type="text/javascript"></script>
    <script src="/Scripts/init_obj.js" type="text/javascript"></script>
    <script src="/Scripts/edit_obj.js" type="text/javascript"></script>
    <script src="/Scripts/toolbar.js" type="text/javascript"></script>
  	<script src="/Scripts/dhtmlxslider.js" type="text/javascript"></script>

    <asp:Literal ID="ltlScript" runat="server" Text=""></asp:Literal>
    <link href="/Styles/Account.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var objName = "";
        var imgList = new Array();
        var slideList = new Array();
        var webList = new Array();
        var videoList = new Array();
        var captureList = new Array();
        var threeList = new Array();
        var telList = new Array();
        var googlemapList = new Array();
        var notepadList = new Array();
        var audioList = new Array();
        var chromakeyList = new Array();
        counter = 0;
        video_counter = 0;
        web_counter = 0;
        img_counter = 0;
        slide_counter = 0;
        capture_counter = 0;
        three_counter = 0;
        tel_counter = 0;
        googlemap_counter = 0;
        notepad_counter = 0;
        audio_counter = 0;
        chromakey_counter = 0;
        capprev_counter = 0;
        var addIndex = 0;
        var prevIndex = 0;
        var capCount = 0;
        var capprevIndex = 0;
        $(document).ready(function () {
//            selTopMenu(4);
            $("#txtTitle").val(CAMPAIN_NAME);
            //이용상품에 따라 오브젝트 현시
            $.ajax({
                url: "getUseProduct.aspx",
                dataType: 'json',
                async: false,
                type: 'POST',
                success: function (data) {
                    HideProgress();
                    var iVideo_obj = data.video_obj;
                    var iWeb_obj = data.web_obj;
                    var iImage_obj = data.image_obj;
                    var iSlide_obj = data.slide_obj;
                    var iCapture_obj = data.capture_obj;
                    var iThree_model_obj = data.three_model_obj;
                    var iTel_obj = data.tel_obj;
                    var iGooglemap_obj = data.googlemap_obj;
                    var iNotepad_obj = data.notepad_obj;
                    var iBgm_obj = data.bgm_obj;
                    var iChromakey = data.chromakey_obj;
                    var iThreeTemplate = data.three_template;
                    onShowTrMenu("trLeftmenu1", iVideo_obj);
                    onShowTrMenu("trLeftmenu2", iImage_obj);
                    onShowTrMenu("trLeftmenu3", iWeb_obj);
                    onShowTrMenu("trLeftmenu4", iTel_obj);
                    onShowTrMenu("trLeftmenu5", iGooglemap_obj);
                    onShowTrMenu("trLeftmenu6", iNotepad_obj);
                    onShowTrMenu("trLeftmenu7", iBgm_obj);
                    onShowTrMenu("trLeftmenu8", iSlide_obj);
                    onShowTrMenu("trLeftmenu9", iCapture_obj);
                    onShowTrMenu("trLeftmenu10", iChromakey);
                    onShowTrMenu("trLeftmenu11", iThree_model_obj);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HideProgress();
                    alert("이용상품이 없습니다. 상품을 구입해주세요.");
                    document.location = "CampainList.aspx";
                }
            });

            $('#fileImg').bind('change', function () {

                $('#fileimage_text').val(this.value.replace('C:\\fakepath\\', ''));
                $('#fileimage_text1').val(this.value.replace('C:\\fakepath\\', ''));
//                $('#fileimage_text11').val(this.value.replace('C:\\fakepath\\', ''));

                var files = document.getElementById('fileImg').files;

                var file, img;
                if ((file = this.files[0])) {
                    img = new Image();
                    img.src = URL.createObjectURL(file);

                    img.onload = function () {
                        marker_width = this.width;
                        marker_height = this.height;
                    };
                }

                //File Reader Support
                if (FileReader && files && files.length) {
                    var fr = new FileReader();
                    fr.onload = function () {
                        $('#img_marker').attr("src", fr.result);
                    }
                    fr.readAsDataURL(files[0]);
                }
            });


            $.ajax({
                url: "getContentData.aspx?id=" + CONTENT_ID,
                dataType: 'json',
                type: 'POST',
                success: function (data) {
                    title = data.title;
                    $("#txtTitle").html(title);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("An error occurs while reading campaign name");
                }

            });

            init_mark();
            selLeftMenu(0);
            capprevdrop();
        });

        function onToggleGrid() {
            if ($("#dvGrid").css("display") == "none")
                $("#dvGrid").css("display", "");
            else
                $("#dvGrid").css("display", "none");
        }
        
        function OnBack() {
            document.location = "CampainList.aspx";
        }

        function OnAddCustomUploadVideo() {
            document.getElementById("addCustomUploadVideo").style="";
        }

        function OnHideCustomUploadVideo()
        {
            document.getElementById("addCustomUploadVideo").style = "display:none;";
        }
        function onVideo()
        {
            document.getElementById("viewObject").innerHTML=
                "<table cellpadding='0' cellspacing='0' width='200' align='center'>"
                + "<tbody>"
                + " <tr>"
                + "     <td width='200' height='153' bgcolor='#EBEBEB'>"
                + "         <p align='center'><b><font face='돋움' color='#999999'>"
                + "             <span style='font-size:12pt;'>VIDEO</span></font></b></p>"
                + "     </td></tr><tr>"
                + "     <td width='200' height='37' bgcolor='#A5A5A5'>"
                + "         <table cellpadding='0' cellspacing='0' align='center' width='175'>"
                + "             <tbody><tr>"
                + "                 <td width='59' height='28'>"
                + "                     <a onclick='DeleteVideo()' onmouseout='cursor:normal;' onmouseover='cursor:hand;' style='cursor:pointer;'>"
                + "                         <img src='IMG/bt_trash.png' width='18' height='21' border='0' alt='' />"
                + "                     </a>"
                + "                 </td>"
                + "                 <td width='59' height='28'>&nbsp;</td>"
                + "                 <td width='57' height='28'>"
                + "                     <a onclick='EditVideo()' onmouseout='cursor: normal;' onmouseover='cursor: hand;' style='cursor: pointer;'>"
                + "                        <p align='right'>"
                + "                         <img src='IMG/bt_pen.png' width='19' height='19' border='0' alt='' />"
                + "                         </p>"
                + "                     </a>"
                + "                 </td>"                    
                + "             </tr>"
                + "            </tbody></table>"
                + "      </td>"
                + "    </tr>"
                + "</tbody></table>";
        }

        function on3DObject()
        {
            document.getElementById("viewObject").innerHTML =
                "<table cellpadding='0' cellspacing='0' width='200' align='center'>"
                + "<tbody>"
                + " <tr>"
                + "     <td width='200' height='153' bgcolor='#EBEBEB'>"
                + "         <p align='center'><b><font face='돋움' color='#999999'>"
                + "             <span style='font-size:12pt;'>3DObject</span></font></b></p>"
                + "     </td></tr><tr>"
                + "     <td width='200' height='37' bgcolor='#A5A5A5'>"
                + "         <table cellpadding='0' cellspacing='0' align='center' width='175'>"
                + "             <tbody><tr>"
                + "                 <td width='59' height='28'>"
                + "                     <a onclick='Delete3DObject()' style='cursor:pointer;'>"
                + "                         <img src='IMG/bt_trash.png' width='18' height='21' border='0' alt='' />"
                + "                     </a>"
                + "                 </td>"
                + "                 <td width='59' height='28'>&nbsp;</td>"
                + "                 <td width='57' height='28'>"
                + "                     <a onclick='Edit3DObject()' style='cursor: pointer;'>"
                + "                        <p align='right'>"
                + "                         <img src='IMG/bt_pen.png' width='19' height='19' border='0' alt='' />"
                + "                         </p>"
                + "                     </a>"
                + "                 </td>"
                + "             </tr>"
                + "            </tbody></table>"
                + "      </td>"
                + "    </tr>"
                + "</tbody></table>";
        }

        function setMarkerImg(marker_url) {
            $.ajax({
                url: "setMarkerData.aspx?marker_url=" + encodeURI(marker_url) + "&id=" + CONTENT_ID,
                type: 'POST',
                success: function (data) {
                    //alert("마커이미지가 등록되었 습니다. 관리자의 승인이 있을때까지 기다려주십시오.");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("error");
                }
            });
        }
        function onShowTrMenu(ctrl, value) {
            $("#" + ctrl).css("display", value == 1 ? "" : "none");
        }

        function onRegMarker() {
            showPopup("dvRegMarker");
        }

        function selLeftMenu(id) {
            if (id == 0) {
                $("#trMenu1r").css("display", "");
                $("#trMenu1").css("display", "none");
                $("#trMenu2r").css("display", "none");
                $("#trMenu2").css("display", "");
                $("#tblMenu2").css("display", "none");
            }
            else {
                if ($("#markImg").attr("src") == "") {
                    alert("마커를 등록하셔야 합니다.");
//                    $("#showmenu").attr("style") = "display:none";
                    return;
                }
                $("#trMenu1r").css("display", "none");
                $("#trMenu1").css("display", "");
                $("#trMenu2r").css("display", "");
                $("#trMenu2").css("display", "none");
                $("#tblMenu2").css("display", "");
            }
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

        function uploadFile(target) {
            document.getElementById("file-name").innerHTML = target.files[0].name;
        }


        function RenameCampain() {
            showPopup("dvRenameCampaign");
        }

        function onChangeMarker() {
            showPopup("dvChangeMarker");
        }

        function onChangeMarkerImg() {
            //파일 유무체크
            if ($("#fileImg11").val() == "") {
                "마커 파일을 지정하세요.";
                return false;
            }
            //확장자체크
            if (!checkImgExtention("fileImg11", "img")) {
                return false;
            }
            //용량체크
            /***확장자체크***/
            var file = document.getElementById("fileImg11");
            if (file.files[0] != null) {
                /*용량제한*/
                if ((file.files[0].size / 1053317.6) > 5) {
                    alert("5MB 이상의 이미지는 등록하실수 없습니다.");
                    return false;
                }

                $("#dvChangeMarker").css("display", "none");
                showPopupUpload();

                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                // add the file intended to be upload to the created FormData instance
                data.append("upfile", file.files[0]);
                //                setTimeout(function () {
                $.ajax({
                    url: 'PostUpload.aspx?type=0&content_id=' + CONTENT_ID,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        $("#markImg").attr("src", data);
                        $("#editframe").css("display", "");
                        $("#req_cover").css("display", "none");
                        $("#markImg").one("load", function () {
                            $(".markdiv").css({ "width": document.getElementById("markImg").width });
                            hidePopupUpload();
                            closePopup();
                            selLeftMenu(1);
                            //                                location.reload();
                        }).each(function () {
                            if (this.complete) $(this).load();
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        HideProgress();
                        alert("마커이미지 등록과정에 오류가 발생하였습니다.");
                    }
                });
                hidePopupUpload();
                //                }, 500);
            }
        }

        function onRegMarkerImg() {
            //파일 유무체크
            if ($("#fileImg").val() == "") {
                "마커 파일을 지정하세요.";
                return false;
            }
            //확장자체크
            if (!checkImgExtention("fileImg", "img")) {
                return false;
            }
            //용량체크
            /***확장자체크***/
            var file = document.getElementById("fileImg");
            if (file.files[0] != null) {
                /*용량제한*/
                if ((file.files[0].size / 1053317.6) > 5) {
                    alert("5MB 이상의 이미지는 등록하실수 없습니다.");
                    return false;
                }
                
                $("#dvRegMarker").css("display", "none");
                showPopupUpload();

                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                // add the file intended to be upload to the created FormData instance
                data.append("upfile", file.files[0]);
//                setTimeout(function () {
                    $.ajax({
                        url: 'PostUpload.aspx?type=0&content_id=' + CONTENT_ID,
                        type: "post",
                        data: data,
                        // cache: false,
                        processData: false,
                        contentType: false,
                        async: false,
                        success: function (data, textStatus, jqXHR) {
                            $("#markImg").attr("src", data);
                            $("#editframe").css("display", "");
                            $("#req_cover").css("display", "none");
                            $("#markImg").one("load", function () {
                                $(".markdiv").css({ "width": document.getElementById("markImg").width });
                                hidePopupUpload();
                                closePopup();
                                selLeftMenu(1);
//                                location.reload();
                            }).each(function () {
                                if (this.complete) $(this).load();
                            });
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            HideProgress();
                            alert("마커이미지 등록과정에 오류가 발생하였습니다.");
                        }
                    });
//                }, 500);
            }
        }
/*
        $(function () {
            $('#btnSelectFile').click(function () {
                $("#fileUpload").trigger('click');
            });
            $("#fileUpload").change(function () {
                var selectedFile = null;
                if ($(this)[0].files && $(this)[0].files[0]) {
                    selectedFile = $(this)[0].files[0];

                }
                $("#txtFilePath").text($(this).val());
            });
        })
*/        
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="edtObjID" />
        <table cellpadding="0" cellspacing="0" width="1199" align="center" background="img/top_bg02.png">
            <tr>
                <td width="1240" height="71" align="left">
                    <table cellpadding="0" cellspacing="0" width="1240">
                        <tr>
                            <td width="1240" height="71" align="left">
                                <table cellpadding="0" cellspacing="0" width="1200">
                                    <tr>
                                        <td width="250" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
<!--                                            <img src="img/cam_menutitle.png" width="224" height="71" border="0">
                                            -->
                                            <p align="center"><font face="돋움" color="#555555"><span style="font-size:12pt;"><b>캠페인 편집</b></span></font></p>
                                        </td>
                                        <td width="250" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-bottom-color:rgb(235,235,235);border-left-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
                                            <p align="center">&nbsp;</p>
                                        </td>

                                        <td width="363" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-bottom-color:rgb(235,235,235);border-left-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
                                            <p align="center">&nbsp;</p>
                                        </td>

                                        <td width="180" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-bottom-color:rgb(235,235,235);border-left-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
                                            <p align="right">
                                                <a onclick="OnSave();" style="cursor:pointer">
                                                    <img src="IMG/_0011_save.png" width="122" height="37" border="0" name="image3" alt="" />
                                                </a>
                                            </p>
                                        </td>

                                        <td width="151" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-bottom-color:rgb(235,235,235);border-left-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
                                            <p align="center">
                                                <a onclick="OnBack();" style="cursor:pointer">
                                                    <img src="IMG/_0013_out.png" width="122" height="37" border="0" name="image2" alt=""/>
                                                </a>
                                            </p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" align="center" width="1240" style="border-collapse: collapse;">
            <tr>
                <td width="240" valign="top" bgcolor="#F9FAFE"  style="border-width:1; border-right-color:rgb(235,235,235); border-top-style:none; border-right-style:solid; border-bottom-style:none; border-left-style:none;">
                    <table cellpadding="0" cellspacing="0" align="center" width="226">
                        <tbody>
                            <tr>
                                <td width="226" height="50">
                                    <p align="center"><b><font face="돋움" color="#555555"><span style="font-size:11pt;">오브젝트</span></font></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="226" height="200">
                                    <table cellpadding="0" cellspacing="0" width="200" align="center" id="showmenu">
                                        <tbody>
                                            <tr>
                                                <td id="leftmenu1">
                                                    <div class="clsImagechange" id="imgEditMenu1" onclick="onSelItem(1)">
                                                        <p align="center"><a style="cursor: pointer;">
                                                            <img src="IMG/bt_video.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="leftmenu11">
                                                    <div class="clsImagechange" id="imgEditMenu11" onclick="onSelItem(11)">
                                                        <p align="center">
                                                            <a style="cursor: pointer;">
                                                            <img src="IMG/bt_3dobj.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="leftmenu3">
                                                    <div class="clsImagechange" id="imgEditMenu3" onclick="onSelItem(3)">
                                                        <p align="center">
                                                            <a style="cursor: pointer;">
                                                            <img src="IMG/bt_website.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="leftmenu4">
                                                    <div class="clsImagechange" id="imgEditMenu4" onclick="onSelItem(4)">
                                                        <p align="center">
                                                            <a style="cursor: pointer;">
                                                            <img src="IMG/bt_phonenumber.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>

                <td width="960" valign="top">
                    <table cellpadding="0" cellspacing="0" width="948">
                        <tbody><tr>
                            <td width="948" height="90" style="border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-bottom-color:rgb(235,235,235); border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="916">
                                    <tbody><tr>
                                        <td width="32" height="42">&nbsp;</td>
                                        <td width="356" height="42">
                                            <table cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                                                <tbody><tr>
                                                    <td width="198" height="37" style="font-weight: bold; font-family: 돋음; color: #666666;
                                                        font-size: 12pt;">
                                                        <input type="text" id="txtTitle" style="border-style: none; background: transparent; font-size: 12pt" />
                                                    </td>
                                                </tr>
                                            </tbody></table>
                                        </td>
                                        <td width="172" height="42"><a onclick="RenameCampain();" style="cursor: pointer;">
                                            <img src="IMG/bt_name.png" width="122" height="37" border="0" alt=""/></a></td>
                                        <td width="356" height="42">
                                            <p align="right"><a onclick="onChangeMarker();" style="cursor: pointer;">
                                                <img src="IMG/bt_marker.png" width="122" height="37" border="0" alt="" /></a></p>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                        <tr>
                            <td id="tdWorkArea" width="1088" height="617" align="center" valign="middle" style="background-repeat: repeat;
                                border-width: 1px; border-top-color: rgb(229,233,235); border-right-color: black;
                                border-bottom-color: black; border-left-color: black; border-top-style: solid;
                                border-right-style: none; border-bottom-style: none; border-left-style: none;position:relative">
                                <div id="dvGrid" style="width:1088px;height:617px;background:url(img/gridback.png); position:absolute;top:0px;z-index:2;display:none" >
                                </div>
                                <div id="editframe" class="markdiv" style="margin-left: auto; margin-right: auto;
                                    z-index: 1px; display: none; position: relative;">
                                    <img id="markImg" src="" class="clsMarkerImg" alt="markerImg" />
                                </div>
                                <div id="req_cover" class="req_cover" style="display: none;">
                                    <table id="tblRegMarker" cellpadding="0" cellspacing="0" width="760" align="center">
                                        <tr>
                                            <td width="760" height="113">
                                                <table cellpadding="0" cellspacing="0" width="411" align="center">
                                                    <tr>
                                                        <td width="411" height="41" align="center">
                                                            <b><font face="돋움" color="#666666"><span style="font-size: 12pt;">마커를 등록하세요.<br><br></span></font></b>
                                                            <div id="req_cover_warning" class="req_cover" style="display: none;">
                                                                <b><font face="돋움" color="#FFOOOO"><span style="font-size: 10pt;">주의:<br> 복사된 캠페인의 경우 원본과 가로세로 사이즈가 <br>같은 마커를 등록해 주세요.<br>마커의 사이즈가 다른경우 오브젝트가 정상적으로 <br>표시 되지 않을 수 있습니다.</span></font></b>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="411" height="50" align="center">
                                                            <a onclick="onRegMarker()" style="cursor:pointer">
                                                                <img src="IMG/markerReg.png" alt="" />
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody></table>
                </td>
            </tr>
            <tr></tr>
            <tr>
                <td colspan="2" width="1200" height="40" bgcolor="#595959">
                        <p align="right" style="margin-top: 0px;margin-bottom: 0px;"><b><font face="돋움" color="#FFE4F2"  style="padding-right: 10px;">
                            <span style="font-size:10pt;">powered by coarsoft</span></font><span style="font-size:10pt;">
                                <font face="돋움" color="#CCCCCC"> </font></span></b><font face="돋움" color="#CCCCCC"><span style="font-size:10pt;">&nbsp;&nbsp;</span></font></p>
                </td>
            </tr>

        </table>


        <div id="dvChangeMarker" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
            <tbody><tr>
                <td width="550" height="10" bgcolor="#5D81EC"></td>
            </tr>
            <tr>
                <td width="550" height="199" bgcolor="white">
                    <table cellpadding="0" cellspacing="0" width="514" align="center">
                        <tbody><tr>
                            <td width="514" height="114">
                                <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">마커 수정</font></span></b></p>
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tbody><tr>
                                        <td width="119" height="44">
                                            <a onclick="javascript:OnBrowse('fileImg11')" style="cursor: pointer;">
                                                <img id="btnSelectFile11" class="" src="IMG/bt_file.png" alt="" />
                                            </a>     
                                            <input id="fileImg11" type="file" name="img_path" accept="image/png, image/jpeg"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileimage_text11').value=this.value" />

                                        </td>
                                        <td width="366" height="44">
                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="347">
                                                <tbody><tr>
                                                    <td width="345" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                        <input type="text" id="fileimage_text11" placeholder="jpg,jpeg,png 파일" readonly="readonly" style="font-size:20px;width:100%" />
                                                    </td>
                                                </tr>
                                            </tbody></table>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                        <tr>
                            <td width="514" height="49">
                                <table cellpadding="0" cellspacing="0" align="center" width="290">
                                    <tbody><tr>
                                        <td width="290" height="36">
                                            <p align="center"><a style="cursor: pointer;" onclick="onChangeMarkerImg()" >
                                                <img src="IMG/bt_confirm.png" alt="" /></a></p>
                                        </td>
                                        <td width="190" height="36" style="padding-left:20px">
                                            <p align="center"><a style="cursor: pointer;" onclick="closePopup()" >
                                                <img src="IMG/bt_cancel.png" alt="" /></a></p>
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



    <div id="dvRegMarker" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
            <tbody><tr>
                <td width="550" height="10" bgcolor="#5D81EC"></td>
            </tr>
            <tr>
                <td width="550" height="199" bgcolor="white">
                    <table cellpadding="0" cellspacing="0" width="514" align="center">
                        <tbody><tr>
                            <td width="514" height="114">
                                <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">마커 등록</font></span></b></p>
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tbody><tr>
                                        <td width="119" height="44">
                                            <a onclick="javascript:OnBrowse('fileImg')" style="cursor: pointer;">
                                                <img id="btnSelectFile" class="" src="IMG/bt_file.png" alt="" />
                                            </a>     
                                            <input id="fileImg" type="file" name="img_path" accept="image/png, image/jpeg"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileimage_text').value=this.value" />

                                        </td>
                                        <td width="366" height="44">
                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="347">
                                                <tbody><tr>
                                                    <td width="345" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                        <input type="text" id="fileimage_text" placeholder="jpg,jpeg,png 파일" readonly="readonly" style="font-size:20px;width:100%" />
                                                    </td>
                                                </tr>
                                            </tbody></table>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                        <tr>
                            <td width="514" height="49">
                                <table cellpadding="0" cellspacing="0" align="center" width="290">
                                    <tbody><tr>
                                        <td width="290" height="36">
                                            <p align="center"><a style="cursor: pointer;" onclick="onRegMarkerImg()" >
                                                <img src="IMG/bt_confirm.png" alt="" /></a></p>
                                        </td>
                                        <td width="190" height="36" style="padding-left:20px">
                                            <p align="center"><a style="cursor: pointer;" onclick="closePopup()" >
                                                <img src="IMG/bt_cancel.png" alt="" /></a></p>
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



    <div id="dvRegVideo" class="clspopup">
                <table cellpadding="0" cellspacing="0" width="550" align="center">
                <tbody><tr>
                    <td width="550" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="550" height="430" bgcolor="white">
                        <table cellpadding="0" cellspacing="0" width="499" align="center">
                            <tbody><tr>
                                <td width="499" height="79" style="padding-left: 0px;">
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">비디오 편집</font></span></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="60"  style="padding-left: 50px;" >
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td>
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">유투브비디오</font></span></b></p>
                                            </td>
                                            <td>
                                                <input type="text" id="youVideo" style="width: 349px;height: 25px;margin-left: 29px;" />
                                            </td>
                                            </tr><tr>
                                            <td width="100" height="49">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">업로드</font></span></b></p>
                                            </td>
                                            <td width="398" height="49">
                                                <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                    <tbody><tr>
                                                        <td width="119" height="44">
                                                            <input id="video_file1" type="file" name="video_path" accept="video/mp4, video/x-ms-wmv, video/x-msvideo, video/avi" class="clsBrowser" style="display: none" 
                                                                size="35" onchange="document.getElementById('video_file_text1').value=this.value"/>
                                                            <a onclick="javascript:OnBrowse('video_file1')" style="cursor: pointer;">
                                                                <img id="btnSelectFile1" class="" src="IMG/bt_file.png" alt="" />
								                                <input type="file" id="fileUpload1" style="display: none" />
                                                            </a>     
                                                        </td>
                                                        <td width="263" height="44">
                                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="249">
                                                                <tbody><tr>
                                                                    <td width="247" height="32">
                                                                        <input type="text" style="font-size:20px;width:100%" id="video_file_text1" size="30" placeholder="wmv, mp4, avi" readonly="readonly" />
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="149" style="padding-left: 50px;" >
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="100" height="142">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">실행옵션<br /><br /><br /><br /><br /><br /><br /></font></span></b></p>
                                            </td>
                                            <td width="398" height="142">
                                                <table cellpadding="0" cellspacing="0" width="370" align="center">
                                                    <tbody><tr>
                                                        <td width="27" height="33">
                                                            <p><input id="videorun_rd1" onclick="OnHideCustomUploadVideo();" type="radio" name="videorun_rd" checked="checked" /></p>
                                                        </td>
                                                        <td width="343" height="33">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#666666">동영상 자동 재생 (버튼사용 안함)</font></span></p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="27" height="33">                        
                                                            <p><input id="videorun_rd2" onclick="OnHideCustomUploadVideo();" type="radio" name="videorun_rd" /></p>
                                                        </td>
                                                        <td width="343" height="33">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#666666">동영상 터치 시 재생 (버튼사용 안함)</font></span></p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="27" height="33">               
                                                            <p><input type="radio" id="videorun_rd3" name="videorun_rd" onclick="OnHideCustomUploadVideo();" /></p>
                                                        </td>
                                                        <td width="343" height="33">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#666666">재생&nbsp;버튼&nbsp;사용</font></span></p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="27" height="33">                                                           
                                                            <p><input type="radio" id="videorun_rd4" name="videorun_rd" name="formradio1" onclick="OnAddCustomUploadVideo();" /></p>
                                                        </td>
                                                        <td width="343" height="33">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#666666">커스텀 버튼 사용</font></span></p>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="55" style="padding-left: 50px;padding-top:20px" >
                                    <div id="addCustomUploadVideo" style="display:none;">
                                        <table cellpadding="0" cellspacing="0" width="498">
                                            <tbody><tr>
                                                <td width="100" height="49">
                                                    <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">업로드</font></span></b></p>
                                                </td>
                                                <td width="398" height="49">
                                                    <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                        <tbody><tr>
                                                            <td width="119" height="44">
                                                                <input id="video_file2" type="file" name="video_path" accept="image/jpeg, image/png" class="clsBrowser" style="display: none" 
                                                                    size="35" onchange="document.getElementById('video_file_text2').value=this.value"/>
                                                                <a onclick="javascript:OnBrowse('video_file2')" style="cursor: pointer;">
                                                                    <img id="btnSelectFile2" class="" src="IMG/bt_file.png" alt="" />
    								                                <input type="file" id="fileUpload2" style="display: none" />
                                                                </a>     
                                                            </td>
                                                            <td width="263" height="44">
                                                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="249">
                                                                    <tbody><tr>
                                                                        <td width="247" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                                            <input type="text" style="font-size:20px;width:100%" id="video_file_text2" size="30" placeholder="png, jpg, jpeg" readonly="readonly" />
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
                            <tr align="center">
                                <td  height="36" style="display:inline-flex;margin-bottom:20px;margin-top:30px;">
                                    <div align="left">
                                        <a onclick="OnVideoApply1()" style="cursor:pointer">
                                            <img src="IMG/bt_confirm.png" border="0" width="122" height="37" alt="" /></a>
                                    </div>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <div align="right"><a onclick="closePopup();" style="cursor:pointer">
                                        <img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image2" alt="" /></a>
                                    </div>
                                </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody></table>
    </div>
 
    <div id="dv3DObj" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
                <tbody><tr>
                    <td width="550" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="550" height="629" bgcolor="white">
                        <table cellpadding="0" cellspacing="0" width="100" align="center">
                            <tbody><tr>
                                <td width="499" height="79" style="padding-left: 0px;" >
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">3D 오브젝트 편집</font></span></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="111" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="107" height="98" rowspan="2">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">업로드<br /><br /><br />&nbsp;</font></span></b></p>
                                            </td>
                                            <td width="391" height="51">
                                                <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                    <tbody><tr>
                                                        <td width="119" height="44">
                                                            <a style="cursor: pointer;" onclick="javascript:OnBrowse('three_file1')">
                                                                <img id="btnSelectFile4" class="" src="IMG/bt_file.png" alt="" />
                                                            </a>     
								                            <input id="three_file1"  type="file" name="three_file1" accept="application/unity3d"
                                                            class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileunity3d_text').value=this.value" />
                                                        </td>
                                                        <td width="263" height="44">
                                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="249">
                                                                <tbody><tr>
                                                                    <td width="247" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                                        <input type="text" id="fileunity3d_text" size="30" placeholder="unity3d 파일" readonly="readonly" style="font-size:11pt;width:100%;height:30px" />
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="391" height="47">
                                                <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                    <tbody><tr>
                                                        <td width="119" height="44">
                                                            <a style="cursor: pointer;" onclick="javascript:OnBrowse('three_file2')" >
                                                                <img id="btnSelectFile5" class="" src="IMG/bt_file.png" alt="" />
                                                            </a>     
								                            <input id="three_file2" type="file" name="three_file2" accept="application/assetbundle"
                                                            class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileassetbundle_text').value=this.value" />
                                                        </td>
                                                        <td width="263" height="44">
                                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="249">
                                                                <tbody><tr>
                                                                    <td width="247" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                                        <input type="text" id="fileassetbundle_text" size="30" placeholder="assetbundle 파일" readonly="readonly" style="font-size:11pt;width:100%;height:30px" />
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="70" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="107" height="49">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">객체 정면방향</font></span></b></p>
                                            </td>
                                            <td width="391" height="49">
                                                <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                    <tbody><tr>
                                                        <td width="97" height="44">
                                                            <div align="right">
                                                                <table cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="82">
                                                                    <tbody><tr>
                                                                        <td width="80" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                                            <input type="text" id="front_angle" name="front_angle" onkeypress="num_only()" style="float: left;font-size:11pt;width:95%;height:30px;" size="28" />
                                                                        </td>
                                                                    </tr>
                                                                </tbody></table>
                                                            </div>
                                                        </td>
                                                        <td width="25" height="44">
                                                            <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#999999">도</font></span></b></p>
                                                        </td>
                                                        <td width="260" height="44">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#999999">&nbsp;(1~360, 정면방향 = 180도)</font></span></p>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="70" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="107" height="49">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">밝기</font></span></b></p>
                                            </td>
                                            <td width="391" height="49">
                                                <table cellpadding="0" cellspacing="0" align="center" width="380">
                                                    <tbody><tr>
                                                        <td width="50" height="40">
                                                            <div align="right">
                                                                <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#999999">밝음</font></span></b></p>
                                                            </div>
                                                        </td>
                                                        <td width="282" height="24" background="IMG/bar_light.png" style="background-position: 0px 4px;background-size: cover;">
                                                        <input type="hidden" id="hdBright" />
                                                        <table cellpadding="0" cellspacing="0" width="282" align="center">
                                                            <tr>
                                                                <td width="5">
                                                                </td>
                                                                <td width="24" id="tdBright1" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(1)"
                                                                    style="cursor: pointer" >
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="39">
                                                                </td>
                                                                <td width="24" id="tdBright25" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(25)"
                                                                    style="cursor: pointer">
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="40">
                                                                </td>
                                                                <td width="24" id="tdBright50" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(50)"
                                                                    style="cursor: pointer">
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="38">
                                                                </td>
                                                                <td width="24" id="tdBright75" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(75)"
                                                                    style="cursor: pointer">
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="35">
                                                                </td>
                                                                <td width="24" id="tdBright100" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(100)"
                                                                    style="cursor: pointer">
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="5">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                        <td width="63" height="40">
                                                            <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#999999">어두움</font></span></b></p>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="70" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="107" height="49">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">실행 횟수</font></span></b></p>
                                            </td>
                                            <td width="391" height="49">
                                                <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                    <tbody><tr>
                                                        <td width="97" height="44">
                                                            <div align="right">
                                                                <table cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="82">
                                                                    <tbody><tr>
                                                                        <td width="80" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                                            <input type="text" id="run_times" name="run_times" onkeypress="num_only()" style="font-size:11pt; width:78px;height:30px" size="28"/>
                                                                        </td>
                                                                    </tr>
                                                                </tbody></table>
                                                            </div>
                                                        </td>
                                                        <td width="25" height="44">
                                                            <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#999999">회</font></span></b></p>
                                                        </td>
                                                        <td width="260" height="44">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#999999">&nbsp;(무제한 반복은 0)</font></span></p>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="140" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="100" height="118">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">실행옵션<br /><br /><br /><br /><br /></font></span></b></p>
                                            </td>
                                            <td width="398" height="118">

                                                <table cellpadding="0" cellspacing="0" width="361" align="center">
                                                    <tbody><tr>
                                                        <td width="377" height="113" valign="top">
                                                            <asp:RadioButtonList ID="RadioButtonList1" CssClass="rdoBtnList rdbThree" runat="server"
                                                                BackColor="#FBFBFB">
                                                                <asp:ListItem Value="0" Selected>일반형 : 마커 자리에 바로 배치</asp:ListItem>
                                                                <asp:ListItem Value="1">상하형: 위에서 아래로 떨어지며 배치</asp:ListItem>
                                                                <asp:ListItem Value="2">페이드인 형 : 흐릿하다가 점차 진해지며 배치</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr align="center">
                                <td  height="36" style="display:inline-flex">
                                    <div align="left">
                                        <a onclick="OnThreeApply()" style="cursor:pointer">
                                            <img src="IMG/bt_confirm.png" border="0" width="122" height="37" alt="" /></a>

                                    </div>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <div align="right"><a onclick="closePopup();" onmouseout="na_restore_img_src('image2', 'document')" onmouseover="na_change_img_src('image2', 'document', 'IMG/bt_cancel_r.png', true)">
                                        <img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image2" alt="" /></a>
                                    </div>
                                </td>

                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody></table>
    </div>

    <div id="dvCopyCampaignAlert" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="449" height="163" style="border-width:1; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" align="center" width="387">
                        <tr>
                            <td width="387" height="77" valign="bottom" align="center">
                                <b><font face="돋움" color="#FFOOOO"><span style="font-size: 10pt;">복사된 캠페인의 경우 원본과 가로세로 사이즈가 같은 <br> 마커를 등록해 주세요.<br>마커의 사이즈가 다른경우 오브젝트가 정상적으로 <br> 표시 되지 않을 수 있습니다.</span></font></b>
                            </td>
                        </tr>
                        <tr>
                            <td width="387" height="77" align="center">
                               <input name="confirm" type="button" value="확 인" onclick="closePopup()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvRenameCampaign" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
                <tbody><tr>
                    <td width="550" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="550" height="199" bgcolor="white">
                        <table cellpadding="0" cellspacing="0" width="514" align="center">
                            <tbody><tr>
                                <td width="514" height="114">
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">캠페인 이름 변경</font></span></b></p>
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="475">
                                        <tbody><tr>
                                            <td width="473" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                <asp:TextBox runat="server" ID="RenameCampainText" Width="473" Height="32" Font-Size="12" MaxLength="20" CssClass="control"></asp:TextBox>
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
                                                    <asp:ImageButton runat="server" ID="btnRegCampain" ValidationGroup="vGroup01" onclick="btnRenameCampain_Click" OnClientClick="return checkCampain();" ImageUrl="IMG/bt_confirm.png"/>
                                                </p>
                                            </td>

                                            <td width="145" height="36">
                                                <p align="center"><a onclick="closePopup();" onmouseout="na_restore_img_src('image2', 'document')" onmouseover="na_change_img_src('image2', 'document', 'IMG/bt_cancel_r.png', true)">
                                                    <img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image2"></a></p>
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
    
    <div id="dvVideo3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="251" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">비디오 - 3D&nbsp;템플릿</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="137" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="127">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="video_rd1" type="radio" name="video_rd" value="0" checked />적용 안함
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="video_rd2" type="radio" name="video_rd" value="1" />3D 클래식 TV형
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="video_rd3" type="radio" name="video_rd" value="2" />
                                                        3D 와이드 평면 TV형
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" style="width: 103px; height: 30px; font-weight: bold;" class="clsButton"
                                                value="적용하기" onclick="OnVideoApply2()" />
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

    <div id="dvWeb" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="border-width: 1px; border-color: rgb(255,102,0);
            border-style: solid; background-color: White">
            <tr>
                <td width="520" valign="top">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="54">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">웹사이트&nbsp;편집</span></font></b>
                                        </td>
                                        <td width="91" height="54" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="70" align="center" class="clsTitleLabel">
                                            URL
                                        </td>
                                        <td width="361" height="70" align="left">
                                            <input type="text" id="web_url" name="web_url" style="width: 300px" maxlength="100" placeholder="http://xxx.xxx.xxx/xxxx 형식으로 입력하세요."
                                                class="control" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="88" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        VIEW 옵션
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="88" valign="top" align="left">
                                            <asp:RadioButtonList ID="rdbWeb2" CssClass="rdbWeb2 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">링크형</asp:ListItem>
                                                <asp:ListItem Value="1">자체&nbsp;브라우저형</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="64" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼종류
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="64" valign="top">
                                            <asp:RadioButtonList ID="rdbWeb1" CssClass="rdbWeb1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">기본 버튼</asp:ListItem>
                                                <asp:ListItem Value="1">커스텀 버튼형</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trNorWebMode">
                                        <td>
                                        </td>
                                        <td width="361" height="119" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdWebModeBtn1" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Web" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('Website',1)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Website</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdWebModeBtn2" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_App" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('APP다운로드',2)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">APP다운로드</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdWebModeBtn3" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Direct" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('바로가기',3)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">바로가기</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdWebModeBtn4" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Buy" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('구매하기',4)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">구매하기</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdWebColorBtn11" class="clsColorBtn" onclick="onChangeWebColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn1" class="clsColorBtn" onclick="onChangeWebColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn2" class="clsColorBtn" onclick="onChangeWebColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn3" class="clsColorBtn" onclick="onChangeWebColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn4" class="clsColorBtn" onclick="onChangeWebColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn5" class="clsColorBtn" onclick="onChangeWebColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn6" class="clsColorBtn" onclick="onChangeWebColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn7" class="clsColorBtn" onclick="onChangeWebColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn8" class="clsColorBtn" onclick="onChangeWebColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn9" class="clsColorBtn" onclick="onChangeWebColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn10" class="clsColorBtn" onclick="onChangeWebColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr class="trNorWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼 글 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdWebTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#FFFFFF','tdWebTextColorBtn',11,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#DDDDDD','tdWebTextColorBtn',1,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#999999','tdWebTextColorBtn',2,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','black','tdWebTextColorBtn',3,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#079DEC','tdWebTextColorBtn',4,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#1234AB','tdWebTextColorBtn',5,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','red','tdWebTextColorBtn',6,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#FF7700','tdWebTextColorBtn',7,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#FFDD00','tdWebTextColorBtn',8,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#33AA22','tdWebTextColorBtn',9,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#BB33AA','tdWebTextColorBtn',10,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>


                                    <tr class="trNorWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼미리보기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblWebPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spWebPreviewText">Website</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        업로드
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="webbtn_path" type="file" name="webbtn_path" accept="image/png" class="clsBrowser"
                                                            size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="520" height="45" valign="top">
                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                    width="502">
                                    <tr>
                                        <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                            border-right-color: black; border-bottom-color: black; border-left-color: black;
                                            border-style: none;">
                                            <table cellpadding="0" cellspacing="0" align="center" width="466">
                                                <tr>
                                                    <td width="466" height="44" align="right">
                                                        <input type="hidden" id="hdWebModeIndex" value="1" />
                                                        <input type="hidden" id="hdWebColorIndex" value="1" />
                                                        <input type="hidden" id="hdWebTextColorIndex" value="1" />
                                                        <input type="button" id="btnWebApply" onclick="OnWebApply()" class="clsButton" value="적용하기"
                                                            style="font-weight: bold; width: 124px; height: 30px;" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvPhone" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" valign="top" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="38">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">전화번호&nbsp;편집&nbsp;</span></font></b>
                                        </td>
                                        <td width="91" height="38" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="37" valign="top" class="clsLabel">
                                            유선전화의 경우 지역번호도 함께 입력해주세요.
                                        </td>
                                        <td width="91" height="37" align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="70" align="center" class="clsTitleLabel">
                                            전화번호 입력
                                        </td>
                                        <td width="361" height="70" align="left">
                                            <input type="text" onkeypress="num_only()" id="tel_no" name="tel_no" maxlength="13" placeholder="'-' 생략"
                                                class="control" style="width: 90%; ime-mode: disabled;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="64" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼종류
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="64" valign="top">
                                            <asp:RadioButtonList ID="rdbTel1" CssClass="rdbTel1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">기본 버튼</asp:ListItem>
                                                <asp:ListItem Value="1">커스텀 버튼형</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td>
                                        </td>
                                        <td width="361" height="108" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdTelModeBtn1" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('Phone Number',1)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Phone Number</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdTelModeBtn2" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('Office phone',2)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Office phone</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdTelModeBtn3" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('연락처',3)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">연락처</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdTelModeBtn4" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('주문하기',4)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">주문하기</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdTelColorBtn11" class="clsColorBtn" onclick="onChangeTelColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn1" class="clsColorBtn" onclick="onChangeTelColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn2" class="clsColorBtn" onclick="onChangeTelColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn3" class="clsColorBtn" onclick="onChangeTelColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn4" class="clsColorBtn" onclick="onChangeTelColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn5" class="clsColorBtn" onclick="onChangeTelColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn6" class="clsColorBtn" onclick="onChangeTelColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn7" class="clsColorBtn" onclick="onChangeTelColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn8" class="clsColorBtn" onclick="onChangeTelColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn9" class="clsColorBtn" onclick="onChangeTelColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn10" class="clsColorBtn" onclick="onChangeTelColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼 글 색상
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdTelTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#FFFFFF','tdTelTextColorBtn',11,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#DDDDDD','tdTelTextColorBtn',1,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#999999','tdTelTextColorBtn',2,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','black','tdTelTextColorBtn',3,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#079DEC','tdTelTextColorBtn',4,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#1234AB','tdTelTextColorBtn',5,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','red','tdTelTextColorBtn',6,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#FF7700','tdTelTextColorBtn',7,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#FFDD00','tdTelTextColorBtn',8,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#33AA22','tdTelTextColorBtn',9,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#BB33AA','tdTelTextColorBtn',10,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        버튼미리보기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblTelPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spTelPreviewText">Phone Number</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomTelMode">
                                        <td height="25">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr class="trCustomTelMode">
                                        <td width="115" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        업로드
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="telbtn_path" type="file" name="telbtn_path" accept="image/jpeg, image/png"
                                                            class="clsBrowser" size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="466">
                                    <tr>
                                        <td width="466" height="44" align="right">
                                            <input type="hidden" id="hdTelColorIndex" value="1" />
                                            <input type="hidden" id="hdTelModeIndex" value="1" />
                                            <input type="hidden" id="hdTelTextColorIndex" value="1" />
                                            <input type="button" id="btnTelApply" onclick="OnTelApply1()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 124px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvPhone3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="210" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">전화번호 - 3D&nbsp;템플릿</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="88">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="rdTel1" type="radio" name="rdTel" title="적용 안함" value="twoD" checked />
                                                        적용 안함
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="rdTel2" type="radio" name="rdTel" title="3D 클래식 전화기" value="threeD" />
                                                        3D 클래식 전화기
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button3" onclick="OnTelApply2()" class="clsButton" value="적용하기"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
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
