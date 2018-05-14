using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.IO;
using System.Web.UI.HtmlControls;
public partial class note_info : System.Web.UI.Page
{
    public string[] d_id = { "", "", "", "", "" };
    public string[] subject = { "", "", "", "", "" };
    public string[] contents = { "", "", "", "", "" };
    public string[] post_day = { "", "", "", "", "" };
    public string[] pic = { "","","","",""};
    protected void Page_Load(object sender, EventArgs e)
    {
       
        int id =int.Parse ( Request.QueryString["id"]);

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string strsql = @"SELECT * FROM diary  where d_id=@id  ";
            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            CMD.Parameters.Add("@id", SqlDbType.Int ).Value = id;//(參數,宣考型態,長度)         
            DataSet ds = new DataSet();
            myAdapter.Fill(ds, "tbl");
            dt = ds.Tables["tbl"].DefaultView.ToTable();          
            if (dt.Rows.Count > 0)
            {
                d_id[0] = dt.Rows[0]["d_id"].ToString();
                subject[0] = dt.Rows[0]["subject"].ToString();
                contents[0] = dt.Rows[0]["contents"].ToString();
                post_day[0] = DateTime.Parse ( dt.Rows[0]["post_day"].ToString()).ToString ("yyyy/MM/dd");
                pic[0] = dt.Rows[0]["pic"].ToString();

                Page.Title = string.Format("{0}Cairns廚房| 肉品及食材銷售專門", subject[0]);
                HtmlMeta ma1 = (HtmlMeta)this.Master.Page.Header.Controls[5];
                ma1.Content = classlib.RemoveHTMLTag ( contents[0]);
            }
            dt.Dispose();
            strsql = "update diary set viewcount = viewcount +1  where d_id=@id";
            CMD = new SqlCommand(strsql, conn);
            CMD.Parameters.Add("@id", SqlDbType.Int).Value  = id;
            CMD.ExecuteNonQuery();
            CMD.Dispose();
            strsql   = @"SELECT * FROM diary  where hot='1' ";  
            CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            myAdapter.Fill(ds, "tbl1");
            dt = ds.Tables["tbl1"].DefaultView.ToTable();                 
            if (dt.Rows.Count > 0)
            {
                d_id[1] = dt.Rows[0]["d_id"].ToString();
                subject[1] = dt.Rows[0]["subject"].ToString();
                contents[1] = dt.Rows[0]["contents"].ToString();
                post_day[1] = DateTime.Parse(dt.Rows[0]["post_day"].ToString()).ToString("yyyy/MM/dd");
                pic[1] = dt.Rows[0]["pic"].ToString();
            }
            dt.Dispose();

            strsql = @"SELECT * FROM diary  where hot='2' ";
            CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            myAdapter.Fill(ds, "tbl2");
            dt = ds.Tables["tbl2"].DefaultView.ToTable();
            if (dt.Rows.Count > 0)
            {
                d_id[2] = dt.Rows[0]["d_id"].ToString();
                subject[2] = dt.Rows[0]["subject"].ToString();
                contents[2] = dt.Rows[0]["contents"].ToString();
                post_day[2] = DateTime.Parse(dt.Rows[0]["post_day"].ToString()).ToString("yyyy/MM/dd");
                pic[2] = dt.Rows[0]["pic"].ToString();
            }
            dt.Dispose();

            strsql = @"SELECT * FROM diary  where hot='3' ";
            CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            myAdapter.Fill(ds, "tbl3");
            dt = ds.Tables["tbl3"].DefaultView.ToTable();
            if (dt.Rows.Count > 0)
            {
                d_id[3] = dt.Rows[0]["d_id"].ToString();
                subject[3] = dt.Rows[0]["subject"].ToString();
                contents[3] = dt.Rows[0]["contents"].ToString();
                post_day[3] = DateTime.Parse(dt.Rows[0]["post_day"].ToString()).ToString("yyyy/MM/dd");
                pic[3] = dt.Rows[0]["pic"].ToString();
            }
            dt.Dispose();
            myAdapter.Dispose();
            ds.Dispose();
            conn.Close();
        }
    }
   
}