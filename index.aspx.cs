using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Web.UI.HtmlControls;


public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = string.Format("{0}Cairns廚房| 肉品及食材銷售專門", "");
        HtmlMeta ma1 = (HtmlMeta)this.Master.Page.Header.Controls[5];
        ma1.Content = "昇華您味蕾的極緻";
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string strsql = @"SELECT * FROM productdata  where status ='Y'  order by sort  ";
            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            SqlDataReader rs;
            DataSet ds = new DataSet();
            myAdapter.Fill(ds, "tbl");
            //myAdapter.Fill(ds, "tbl");
            //myAdapter.Fill(ds, "tbl");
            //myAdapter.Fill(ds, "tbl");
            //myAdapter.Fill(ds, "tbl");
            dt = ds.Tables["tbl"].DefaultView.ToTable();
            myAdapter.Dispose();
            ds.Dispose();
            pd_push.DataSource = dt;
            pd_push.DataBind();
            dt.Dispose();

            strsql = @"SELECT top 3 * FROM diary  where status ='Y' and   hot in ('1','2','3') order by hot ";
            CMD = new SqlCommand(strsql, conn);
            rs = CMD.ExecuteReader();
            Repeaterdiary.DataSource = rs;
            Repeaterdiary.DataBind();
            rs.Close();
            CMD.Dispose();
            conn.Close();
           

        }
    }
}