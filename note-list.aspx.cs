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
public partial class note_list : System.Web.UI.Page
{
    public string subject = "";
    public string pic = "";
    public string d_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        Page.Title = string.Format("{0}|Cairns廚房| 肉品及食材銷售專門", "料理日誌");
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string strsql = @"SELECT * FROM diary  where status ='Y' and hot='0' order by d_id desc   ";
            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;

            DataSet ds = new DataSet();
            myAdapter.Fill(ds, "tbl0");
            dt = ds.Tables["tbl0"].DefaultView.ToTable();     
            if (dt.Rows .Count > 0)
            {
                subject = dt.Rows[0]["subject"].ToString();
                pic = dt.Rows[0]["pic"].ToString();
                d_id = dt.Rows[0]["d_id"].ToString();
           
            }
            CMD.Dispose();
            dt.Dispose();
         
            HtmlMeta ma1 = (HtmlMeta)this.Master.Page.Header.Controls[5];
            ma1.Content = classlib.RemoveHTMLTag(subject);
            strsql = @"SELECT * FROM diary  where status ='Y' and hot<> '0' order by d_id desc   ";            
            CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;            
            myAdapter.Fill(ds, "tbl");
            dt = ds.Tables["tbl"].DefaultView.ToTable();

            myAdapter.Dispose();
            ds.Dispose();
            conn.Close();
            Repeaternote.DataSource = dt;
            Repeaternote.DataBind();
            dt.Dispose();
           
        }
    }
}