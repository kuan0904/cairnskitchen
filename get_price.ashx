<%@ WebHandler Language="C#" Class="get_price" %>


using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using unity;

public class get_price : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        int p_ID = 1;
        int p_num = 1;
        if ( context.Request["p_ID"] != null) p_ID = int.Parse (context.Request["p_ID"]);
        if ( context.Request["p_num"] != null) p_num = int.Parse (context.Request["p_num"]);
        string p_price = "";
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            conn.Open();
            string strsql = "SELECT * FROM   productData  WHERE p_id = @p_id  ";
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;

            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("p_id", SqlDbType.Int).Value = p_ID;
            rs = cmd.ExecuteReader();
            if (rs.Read()) p_price = rs["price"].ToString();
            cmd.Dispose();
            rs.Close();


            strsql = "SELECT top 1 price  FROM   productprice  WHERE p_id = @p_id  and num <>0 and num >= @num order by num  ";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("p_id", SqlDbType.Int).Value = p_ID;
            cmd.Parameters.Add("num", SqlDbType.Int).Value = p_num;
            rs = cmd.ExecuteReader();
            if (rs.Read()) p_price = rs["price"].ToString ();
            cmd.Dispose();
            rs.Close();

            strsql = "SELECT top 1 *  FROM   productprice  WHERE p_id = @p_id  and num <>0 and num < @num ORDER BY   num DESC  ";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("p_id", SqlDbType.Int).Value = p_ID;
            cmd.Parameters.Add("num", SqlDbType.Int).Value = p_num;
            rs = cmd.ExecuteReader();
            if (rs.Read()) {
              if (p_num > (int) rs["num"] )  p_price = rs["price"].ToString();

            }

            cmd.Dispose();
            rs.Close();

            conn.Close();
        }
        context.Response.Write(p_price);
        context.Response.End();
    }


    public bool IsReusable {
        get {
            return false;
        }
    }

}