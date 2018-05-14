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
public partial class pro_list : System.Web.UI.Page
{
    public int pagecount = 0;
    public string page_list ="";
    protected void Page_Load(object sender, EventArgs e)
    {


        Page.Title = string.Format("{0}Cairns廚房| 肉品及食材銷售專門", "嚴選商品| ");
        HtmlMeta ma1 = (HtmlMeta)this.Master.Page.Header.Controls[5];
        ma1.Content = "嚴選商品|";

        int page = 1;
        int totalpage = 0;
        
        if (Request.QueryString ["page"] != null )   page =int.Parse ( Request.QueryString["page"]);
        string c_id = "";
        if (Request.QueryString["c_id"] != null) c_id = Request.QueryString["c_id"];

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection( classlib.dbConnectionString))
        {
            string strsql = @"SELECT * FROM category  where status ='Y' order by priority  ";
            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
                   
            DataSet ds = new DataSet();
            myAdapter.Fill(ds, "tbl");
            dt = ds.Tables["tbl"].DefaultView.ToTable();
       
            Repeatercategory.DataSource = dt;
            Repeatercategory.DataBind();
            dt.Dispose ();

            strsql = @"SELECT count(*) FROM productData  where status ='Y'    ";
            if (c_id != "") strsql += " and c_id=@c_id";
        
            CMD = new SqlCommand(strsql, conn);
            if (c_id != "") CMD.Parameters.Add("@c_id",SqlDbType.Int ) .Value = c_id ;
            SqlDataReader rs;
            rs = CMD.ExecuteReader();
            if (rs.Read()) totalpage = (int)rs[0];
            rs.Close();
            CMD.Dispose();

            int pagecount = totalpage /6 + (totalpage %6 > 0 ? 1 : 0);
            for (int i = 1; i <= pagecount; i++)
            {

                page_list += "<a href=\"pro-list.aspx?page=" + i .ToString () + "&c_id=" + Request.QueryString["c_id"] + "\">" + i.ToString()  +"</a>";
            }
            if (pagecount == 1) page_list = "";

            strsql = @"SELECT * FROM productData  where status ='Y'    ";
            if (c_id != "") strsql += " and c_id=@c_id";
            strsql += " order by sort";
            CMD = new SqlCommand(strsql, conn);
            if (c_id != "") CMD.Parameters.Add("@c_id", SqlDbType.Int).Value = c_id;
            myAdapter.SelectCommand = CMD;

           // myAdapter.Fill(ds, "tbl_pd");
            myAdapter.Fill(ds, (page - 1) * 6,6, "tbl_pd");
            dt = ds.Tables["tbl_pd"].DefaultView.ToTable();
            Repeaterpd.DataSource = dt;
            Repeaterpd.DataBind();
            //     myAdapter.Fill(ds, (page - 1) * limit, limit, "tbl_product");

            strsql = @"SELECT top 3 * FROM diary  where status ='Y' and   hot in ('1','2','3') order by hot ";
            CMD = new SqlCommand(strsql, conn);
            rs = CMD.ExecuteReader();
            Repeaterdiary.DataSource = rs;
            Repeaterdiary.DataBind();
            rs.Close();
            CMD.Dispose();


            myAdapter.Dispose();
            ds.Dispose();        
            conn.Close();
        }
    }
}