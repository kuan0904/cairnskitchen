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
public partial class pro_info : System.Web.UI.Page
{
    public string p_id = "";
    public string productname = "";
    public string price = "0";
    public string logo= "";
    public string banner = "";
    public int storage = 0;
    public string description = "";
    public string memo = "";
    public string[] pic = { "", "", "", "", "" };
    public string buy_num_option ="";
    public string Pricing = "";
    public string Savetxt = "";
    public string sell_text = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        int id = int.Parse(Request.QueryString["p_id"]);

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string strsql = @"SELECT * FROM   productData  where p_id=@id  ";
            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            CMD.Parameters.Add("@id", SqlDbType.Int).Value = id;//(參數,宣考型態,長度)         
            DataSet ds = new DataSet();
            myAdapter.Fill(ds, "tbl");
            dt = ds.Tables["tbl"].DefaultView.ToTable();
            if (dt.Rows.Count > 0)
            {
                Pricing = dt.Rows[0]["Pricing"].ToString();
                if (Pricing !="") Pricing = "<span style =\"text-decoration:line-through;color:grey\">" + Pricing + "</span>";
                p_id = dt.Rows[0]["p_id"].ToString();
                productname = dt.Rows[0]["productname"].ToString();
                price = dt.Rows[0]["price"].ToString();
                storage =(int) dt.Rows[0]["storage"];
                banner = dt.Rows[0]["banner"].ToString();
                logo = dt.Rows[0]["logo"].ToString();
                description = dt.Rows[0]["description"].ToString();
                pic[1] = dt.Rows[0]["pic1"].ToString();
                pic[2] = dt.Rows[0]["pic2"].ToString();
                pic[3] = dt.Rows[0]["pic3"].ToString();
                Savetxt = dt.Rows[0]["Savetxt"].ToString();
                sell_text = dt.Rows[0]["selltxt"].ToString();
          
                Page.Title = string.Format("{0}|Cairns廚房| 肉品及食材銷售專門", productname);
                HtmlMeta ma1 = (HtmlMeta)this.Master.Page.Header.Controls[5];
                ma1.Content = classlib.RemoveHTMLTag(description );
            }
            dt.Dispose();
            if (sell_text == "")
            {
                strsql = @"SELECT * FROM   promo_system  where ps_id=12  ";
                SqlDataReader rs;
                CMD = new SqlCommand(strsql, conn);
                rs = CMD.ExecuteReader();
                if (rs.Read())
                    sell_text = rs["ps_name"].ToString();
                rs.Close();
                CMD.Dispose();
            }
            strsql = "update productData  set viewcount = viewcount +1  where p_id=@id";
            CMD = new SqlCommand(strsql, conn);
            CMD.Parameters.Add("@id", SqlDbType.Int).Value = id;
            CMD.ExecuteNonQuery();
            CMD.Dispose();
            if (storage > 20) storage = 20;
            buy_num_option = "";
            if (storage <= 0)
            {
                buy_num_option = " <option value=\"0\">已售完</option>";
            }
      
            for (int i= 1; i <= storage; i++)
            {
                buy_num_option +=  "<option value =\"" + i.ToString () +"\">" + i.ToString () + "(每件" + classlib.get_price(id, i) + "元)</option>";
            }

            myAdapter.Dispose();
            ds.Dispose();
            conn.Close();
        }
    }

    public string check_img(string img,int kind )    {

        if ( File.Exists(Server.MapPath("upload/" + img)))
            if (kind ==1)
            img = "<li><img src=\"upload/" + img + "?" + DateTime.Now.ToString("yyyyMMddhhmmss") + " alt=\"\"></li>";
        else
            img = "<li><a href=\"#\"><img src=\"upload/" + img + "?" + DateTime.Now.ToString("yyyyMMddhhmmss") + " width = \"60\" height = \"60\" alt=\"\"></a></li>";
			
         else
            img = "";
        return img;

    }
}