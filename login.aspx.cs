using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["memberdata"] != null && !IsPostBack )
        {
      
            email.Text = Request.Cookies["memberdata"]["email"].ToString();
            password.Attributes.Add("value", Request.Cookies["memberdata"]["password"].ToString());
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string returnpage = "index.aspx";
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string strsql = "";
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;
         
            conn.Open();
            strsql = @"SELECT     * FROM MemberData  WHERE   email=@email and password=@password";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email.Text;
            cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = password.Text;         
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                Session["memberid"] = rs["memberid"].ToString();
                if ( Request["remeber"] != null )
                {
                    Response.Cookies["memberdata"]["email"] = rs["email"].ToString();
                    Response.Cookies["memberdata"]["email"] = rs["email"].ToString();
                    Response.Cookies["memberdata"]["password"] = rs["password"].ToString();
                    Response.Cookies["memberdata"].Expires = DateTime.Now.AddDays(30d);
                }
                else
                {
                    Response.Cookies["memberdata"]["email"] = "";
                    Response.Cookies["memberdata"]["password"] = "";
                    Response.Cookies["memberdata"].Expires = DateTime.Now.AddDays(1d);
                
                }
                if (Request.QueryString["page"] != "")              
                {
                    returnpage = Request.QueryString["page"];
                }
                Response.Write("<script>alert('登入成功');location.href='" + returnpage + "'</script>");
            }
            else
            {
                Response.Write("<script>alert('Email或密碼有錯');</script>");
            }
            rs.Close();
            cmd.Dispose();
            if (Session ["memberid"] != null)
            {
                strsql = @"update MemberData set lastlogin =getdate()   WHERE   memberid=@memberid";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@memberid", SqlDbType.Int).Value = Session["memberid"].ToString();
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }

            conn.Close();
        }
    }
}