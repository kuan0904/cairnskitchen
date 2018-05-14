using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
public partial class MasterPage : System.Web.UI.MasterPage
{
    public string div_name = "fixed";
    public string copyright = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagename = Request.FilePath.ToString ().ToLower () ;
      
        if (pagename.IndexOf("index") != -1 ) div_name = "default";
        if (pagename.IndexOf("about") != -1) MultiView1.ActiveViewIndex = 0;
        if (pagename.IndexOf("note-list") != -1) MultiView1.ActiveViewIndex = 0;
        if (pagename.IndexOf("pro-info") != -1) MultiView1.ActiveViewIndex = 0;
        if (pagename.IndexOf("modify") != -1) MultiView1.ActiveViewIndex = 0;
        if (pagename.IndexOf("paymode") != -1) MultiView1.ActiveViewIndex = 0;
        if (pagename.IndexOf("personal") != -1) MultiView1.ActiveViewIndex = 0;
        if (pagename.IndexOf("forget") != -1) MultiView1.ActiveViewIndex = 0;
        if (pagename.IndexOf("join") != -1) MultiView1.ActiveViewIndex = 0;
        if (pagename.IndexOf("information") != -1) MultiView1.ActiveViewIndex = 0;
        if (pagename.IndexOf("completed") != -1) MultiView1.ActiveViewIndex = 0;
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string strsql = @"SELECT * FROM productdata  where status ='Y'    ";
            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;

            DataSet ds = new DataSet();
            myAdapter.Fill(ds, "tbl");
            //myAdapter.Fill(ds, "tbl");
            //myAdapter.Fill(ds, "tbl");
            //myAdapter.Fill(ds, "tbl");
            //myAdapter.Fill(ds, "tbl");
            dt = ds.Tables["tbl"].DefaultView.ToTable();
            myAdapter.Dispose();
            ds.Dispose();
            conn.Close();
            pd_push.DataSource = dt;
            pd_push.DataBind();
            dt.Dispose();

            dt = classlib.Get_promo("10");
            copyright = dt.Rows[0]["contents"].ToString();   
            dt.Dispose();

            conn.Close();
        }
    }
}
