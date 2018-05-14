using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
public partial class modify : System.Web.UI.Page
{
    public string  email="";
    public string password="";
    public string zip="";
    public string address="";
    public string cityid="";
    public string countyid="";
    public string gender="";
    public string username="";
    public string phone = "";
    public string birthday = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["memberid"] == null)
        {
            Response.Redirect("login.aspx?page=modify.aspx");
        }
        else 
        {
            using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
            {
                string strsql = "";
                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;

                conn.Open();
                strsql = @"SELECT     * FROM MemberData  WHERE  memberid=@memberid ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@memberid", SqlDbType.Int).Value = Session["memberid"].ToString();           
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    email = rs["email"].ToString();
                    username  = rs["username"].ToString();
                    password  = rs["password"].ToString();
                    phone = rs["phone"].ToString();
                    zip = rs["zip"].ToString();
                    address = rs["address"].ToString();
                    cityid = rs["cityid"].ToString();
                    countyid  = rs["countyid"].ToString();
                    gender = rs["gender"].ToString();
                    birthday = rs["birthday"].ToString() ==""? "": DateTime.Parse ( rs["birthday"].ToString()).ToString ("yyyy-MM-dd");
                }
                cmd.Dispose();
                rs.Close();
                conn.Close();
                }

        }

    }
}