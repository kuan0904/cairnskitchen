using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
public partial class forget : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string strsql = "";
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;

            conn.Open();
            strsql = @"SELECT     * FROM MemberData  WHERE   email=@email";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email.Text ;
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                DataTable dt =classlib . Get_promo("6");
                string subject = dt.Rows[0]["ps_name"].ToString();
                string mailbody = dt.Rows[0]["contents"].ToString();
                mailbody  = mailbody .Replace ("@password@", rs["password"].ToString() );
                string msg = classlib.SendsmtpMail(email.Text, subject, mailbody, "gmail");
                dt.Dispose();
                MultiView1.ActiveViewIndex = 1;
                Response.Write(msg);
            }
            else
            {
                Response.Write("<script>alert('Email非會員');</script>");
            }

            rs.Close();
            cmd.Dispose();
            conn.Close();
        }
    }
}