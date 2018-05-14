using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
public partial class personal : System.Web.UI.Page
{
    public string email = "";
    public string password = "";
    public string zip = "";
    public string address = "";
    public string cityid = "";
    public string countyid = "";
    public string gender = "";
    public string username = "";
    public string phone = "";
    public string birthday = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["memberid"] == null)
        {
            Response.Redirect("login.aspx?page=personal.aspx");
        }
        else
        {
            using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
            {
                string strsql = "";
                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;

                conn.Open();
                strsql = @"SELECT  *  FROM  MemberData LEFT OUTER JOIN
                      county ON MemberData.countyid = county.countyid LEFT OUTER JOIN
                      city ON MemberData.cityid = city.cityid  WHERE  memberid=@memberid ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@memberid", SqlDbType.Int).Value = Session["memberid"].ToString();
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    email = rs["email"].ToString();
                    username = rs["username"].ToString();
                    password = rs["password"].ToString();
                    phone = rs["phone"].ToString();
                    zip = rs["zip"].ToString();
                    address = rs["countyname"].ToString () +  rs["cityname"].ToString () +  rs["address"].ToString();
                    cityid = rs["cityid"].ToString();
                    countyid = rs["countyid"].ToString();
                    gender = rs["gender"].ToString();
                    birthday =rs["birthday"].ToString ();
                }
                cmd.Dispose();
                rs.Close();


                strsql = @" SELECT *    FROM   OrderData  where OrderData.memberid=@memberid order by ord_id desc ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@memberid", SqlDbType.Int).Value = Session["memberid"].ToString();
                rs = cmd.ExecuteReader();
                Repeater1.DataSource  = rs;
                Repeater1.DataBind();
                rs.Close();
                cmd.Dispose();
                conn.Close();
            }

        }

    }

   

}