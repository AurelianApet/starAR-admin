using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace nocutAR.Account
{
    public partial class PostUpload : Common.PageBase
    {
        protected override void Page_Init(object sender, EventArgs e)
        {
            base.Page_Init(sender, e);
        }
        protected override void Page_Load(object sender, EventArgs e)
        {
            /*  type=0: 마커업로드
                type=1:비디오업로드
                type=2:이미지업로드
                type=3:웹사이트업로드
                type=4:캡쳐오브젝트 업로드
                type=5:전화번호업로드
                type=6:3D 오브젝트업로드 */

            base.Page_Load(sender, e);
            int type = -1;
            if(Request.Params["type"] != null)
                type= Int32.Parse(Request.Params["type"]);
            long content_id = -1;
            if (Request.Params["content_id"] != null)
                content_id = Int32.Parse(Request.Params["content_id"]);

            if (type == -1)
                return;
            HttpFileCollection uploadFiles = Request.Files;

            string strIconPath = null;
            if (type == 0)
            {
                strIconPath = uploadFile(Request.Files["upfile"], "/markers", "COAR_" + content_id.ToString() + System.IO.Path.GetExtension(Request.Files["upfile"].FileName));
            }
            else if(type==5)
            {
                strIconPath=uploadFile(Request.Files["upfile1"], "/uploads");

                strIconPath +=":" + uploadFile(Request.Files["upfile2"], "/uploads");
            }
            else
            {
                strIconPath = uploadFile(Request.Files["upfile"], "/uploads", content_id.ToString() + "_" + type.ToString() + "_" + Guid.NewGuid().ToString().Replace("-", "") + System.IO.Path.GetExtension(Request.Files["upfile"].FileName));
            }
            //용량기록
            if (type == 5)
            {
                DBConn.RunInsertQuery("INSERT INTO traffics (objtype, filename, size, userid, content_id) VALUES(@objtype, @filename, @size, @userid, @content_id ) ",
                new string[] {
                    "@objtype",
                    "@filename",
                    "@size",
                    "@userid",
                    "@content_id"
                },
                new object[] {
                    type,
                    Request.Files["upfile1"].FileName,
                    (float)(Request.Files["upfile2"].ContentLength)/1024/1024,
                    AuthUser.ID,
                    content_id
                });
                DBConn.RunInsertQuery("INSERT INTO traffics (objtype, filename, size, userid, content_id) VALUES(@objtype, @filename, @size, @userid, @content_id ) ",
                new string[] {
                    "@objtype",
                    "@filename",
                    "@size",
                    "@userid",
                    "@content_id"
                },
                new object[] {
                    type,
                    Request.Files["upfile2"].FileName,
                    (float)(Request.Files["upfile2"].ContentLength)/1024/1024,
                    AuthUser.ID,
                    content_id
                });
            }
            else
            {
                DBConn.RunInsertQuery("INSERT INTO traffics (objtype, filename, size, userid, content_id) VALUES(@objtype, @filename, @size, @userid, @content_id ) ",
                new string[] {
                    "@objtype",
                    "@filename",
                    "@size",
                    "@userid",
                    "@content_id"
                },
                new object[] {
                    type,
                    strIconPath,
                    (float)(Request.Files["upfile"].ContentLength)/1024/1024,
                    AuthUser.ID,
                    content_id
                });
            }
            Response.Write(strIconPath);
        }
    }
}
