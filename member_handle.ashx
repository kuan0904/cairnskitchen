<%@ WebHandler Language="C#" Class="member_handle" %>

using System;
using System.Web;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using unity;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;

public class member_handle : IHttpHandler,IRequiresSessionState {
    public void ProcessRequest(HttpContext context)
    {
        string p_ACTION = context.Request["p_ACTION"];
        string email = context.Request["email"];
        string PASSWD = context.Request["password"];
        string username = context.Request["username"];
        string countyid= context.Request["countyid"];
        string cityid= context.Request["cityid"];
        string zip = context.Request["zip"];
        string address = context.Request["address"];
        string phone = context.Request["phone"];
        string gender = context.Request["gender"];
        string birthday = context.Request["birthday"];
        string status = "0";
        string strsql;

        //安全性,上線要加
        string check = context.Request["_"];

        if (unity.classlib.IsNumeric(check) == false)
        {
            context.Response.Write(status);
            context.Response.End();

        }


        if (p_ACTION == "Register")
        {
            using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
            {

                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;

                conn.Open();
                strsql = @"SELECT     * FROM MemberData  WHERE   email=@email" ;
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@email", SqlDbType.VarChar ).Value = email ;
                rs = cmd.ExecuteReader();
                if (rs.Read())     status = "-1";
                rs.Close();
                cmd.Dispose();
                if (status != "-1")
                {
                    strsql = @"insert into  MemberData (email, username, gender, phone, address, password, countyid, 
                    cityid, zip, crtdat, lastlogin,birthday) values 
                        (@email, @username, @gender, @phone, @address, @password, @countyid, @cityid,
                @zip, getdate(), getdate(),@birthday) ";
                    cmd = new SqlCommand(strsql, conn);
                    cmd.Parameters.Add("@email", SqlDbType.VarChar ).Value = email ;
                    cmd.Parameters.Add("@username", SqlDbType.NVarChar ).Value  = username  ;
                    cmd.Parameters.Add("@gender", SqlDbType.NVarChar ).Value = gender ;
                    cmd.Parameters.Add("@phone", SqlDbType.VarChar ).Value = phone  ;
                    cmd.Parameters.Add("@zip", SqlDbType.VarChar ).Value = zip;
                    cmd.Parameters.Add("@cityid", SqlDbType.VarChar ).Value = cityid;
                    cmd.Parameters.Add("@countyid", SqlDbType.VarChar ).Value = countyid;
                    cmd.Parameters.Add("@address", SqlDbType.NVarChar  ).Value = address;
                    cmd.Parameters.Add("@password", SqlDbType.VarChar ).Value =PASSWD ;
                    cmd.Parameters.Add("@birthday", SqlDbType.VarChar ).Value =birthday ;
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                    status = "1";
                }
                strsql = @"select max(memberid) from   MemberData  ";
                cmd = new SqlCommand(strsql, conn);
                rs = cmd.ExecuteReader();
                if (rs.Read()) context.Session["memberid"] = rs[0].ToString();
                rs.Close();
                cmd.Dispose();
                conn.Close();



                DataTable dt =classlib . Get_promo("5");
                string subject = dt.Rows[0]["ps_name"].ToString();
                string mailbody = dt.Rows[0]["contents"].ToString();
                mailbody  = mailbody .Replace ("@password@", PASSWD  );
                mailbody  = mailbody .Replace ("@email@", email );
                string msg = classlib.SendsmtpMail(email, subject, mailbody, "gmail");
                dt.Dispose();
                classlib.SendsmtpMail(email, "【cairnskitchen】會員註冊通知", mailbody, "");

            }

            context.Response.Write(status);
            context.Response.End();
        }
        if (p_ACTION == "Checkemail")
        {
            status = "1";
            using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
            {
                SqlDataReader rs;
                SqlCommand cmd = new SqlCommand();
                conn.Open();
                strsql = @"select * from   MemberData    WHERE  email=@email" ;
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@email", SqlDbType.VarChar ).Value =email;
                rs = cmd.ExecuteReader () ;
                if  (rs.Read () ) status ="-1";
                cmd.Dispose();
                rs.Close();
                conn.Close();
            }
            context.Response.Write(status);
            context.Response.End();
        }
        if (p_ACTION == "CheckLogin")
        {

        }
        if (p_ACTION == "Update")
        {

            using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
            {
                SqlCommand cmd = new SqlCommand();
                conn.Open();
                strsql = @"update  MemberData set username=@username,gender=@gender,
                phone=@phone,zip=@zip,cityid=@cityid,countyid=@countyid,address=@address,
                password=@password ,birthday=@birthday     WHERE  memberid=@memberid" ;
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@memberid", SqlDbType.VarChar ).Value =context.Session ["memberid"].ToString ();
                cmd.Parameters.Add("@username", SqlDbType.NVarChar ).Value  = username  ;
                cmd.Parameters.Add("@gender", SqlDbType.NVarChar ).Value = gender ;
                cmd.Parameters.Add("@phone", SqlDbType.VarChar ).Value = phone  ;
                cmd.Parameters.Add("@zip", SqlDbType.VarChar ).Value = zip;
                cmd.Parameters.Add("@cityid", SqlDbType.VarChar ).Value = cityid;
                cmd.Parameters.Add("@countyid", SqlDbType.VarChar ).Value = countyid;
                cmd.Parameters.Add("@address", SqlDbType.NVarChar  ).Value = address;
                cmd.Parameters.Add("@password", SqlDbType.VarChar ).Value =PASSWD ;
                cmd.Parameters.Add("@birthday", SqlDbType.VarChar ).Value =birthday ;
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                status = "1";
                cmd.Dispose();
                conn.Close();
            }
            context.Response.Write(status);
            context.Response.End();
        }
        if (p_ACTION == "get_discount")
        {
            string discount_no = context.Request  ["discount_no"];
            string memberid= (context.Session["memberid"] == null)? "" : context.Session["memberid"].ToString();
            string price = context.Request  ["price"];
            string  cc_money =Get_coupon_no (memberid,discount_no,price);
            context.Response.Write(cc_money .ToString ());
            context.Response.End();

        }
    }

    public static string  Get_coupon_no(string memberid, string discount_no,string price )
    {
        string  cc_money = "0";
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {

            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;
            conn.Open();
            string usetimes = "";


            string strsql = @"SELECT  *     FROM    coupon    WHERE  sn =@sn 
            and num >0 and convert(varchar, getdate(), 111) between strdate and enddate   ";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("sn", SqlDbType.VarChar ).Value = discount_no ;
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                usetimes = rs["usetimes"].ToString();
                if (rs["status"].ToString() == "N")
                    cc_money = "-1";

                else if ((int)rs["useprice"] >= int.Parse(price))
                    cc_money = "-3";
                else
                {
                    if (rs["addition"].ToString() == "Y")
                    {
                        int x = int.Parse(price) / (int)rs["useprice"];
                        cc_money = ((int)rs["money"] * x).ToString();// "100";
                    }else
                    {
                        cc_money = rs["money"].ToString();
                    }
                }


            }
            rs.Close();
            cmd.Dispose();
            if (usetimes =="0")
            {
                strsql = @"SELECT  *     FROM   OrderData     WHERE  coupon_no =@sn and memberid =@memberid ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("sn", SqlDbType.VarChar ).Value = discount_no ;
                cmd.Parameters.Add("memberid", SqlDbType.VarChar ).Value = memberid;
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    cc_money = "-2";
                }
                rs.Close();
                cmd.Dispose();

            }


            conn.Close();

        }
        return cc_money;
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}