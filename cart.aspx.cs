using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
public partial class cart : System.Web.UI.Page
{
    public int DeliveryPrice = 180;
    public int ship_free = 1600;
    public int amount = 0;
    public int totalprice=0;
    public string free_gift = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = string.Format("{0}Cairns廚房| 肉品及食材銷售專門","購物車");
     

        ship_free = classlib.Get_ship_free();
        DeliveryPrice = classlib.Get_DeliveryPrice();
        if (Session["ShoppingList"] != null )
        {
          
            List<ShoppingList> Shoppinglist = new List<ShoppingList>();
            Shoppinglist = Session["ShoppingList"] as List<ShoppingList>;
            RepeaterList.DataSource = Shoppinglist;
            RepeaterList.DataBind();           
            foreach (ShoppingList idx in Shoppinglist)
            {
                //if (idx.p_id == "30" || idx.p_id == "31" || idx.p_id == "30" || idx.p_id == "33" || idx.p_id == "34" || idx.p_id == "35")
                //{
                //    free_gift = "<div class=\"box-row\"><div class=\"boxrow-img\"><img src = \"upload/44-1.jpg\" width=\"90\" height =\"60\"></div><div class=\"boxrow-name\">【贈品】21oz美國霜降嫩肩牛排</div>";
                //    free_gift +=  "<div class=\"boxrow-unit\">$0</div><div class=\"boxrow-input\"> 1 </div> <div class=\"boxrow-subtotal\">$ 0 </div></div>";
                //}
                amount += (idx.price * idx.num);
            }
            if (amount >= ship_free) DeliveryPrice = 0;
            totalprice = amount + DeliveryPrice;
            
        }
        else
        {
            Response.Write("<script>alert('目前購物車無資料');location.href='pro-list.aspx';</script>");
            Response.End();
        }
    }
    public  string  get_storage(string p_id,int num)
    {    int storage=10;
        string msg = ""; 
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;

            string strsql = "select * from productData where p_id = @p_id";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("p_id", SqlDbType.Int).Value = p_id;
            rs = cmd.ExecuteReader();
        
            if (rs.Read())
            {
                storage = (int)rs["storage"];
            }
            cmd.Dispose();
            rs.Close();
            conn.Close();
        }
        if (storage > 20) storage = 20;
        if (storage == 0) msg += "<option value = \"0\" selected \">銷售完畢</option>";
        for (int i =1; i<= storage; i++)
        {
            msg +=     "<option value = \""+  i  + "\"" ;
            if  (num  == i  ) msg += "selected";
            msg += ">" + i + "</option>";
                    
        }
        return msg;
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (Session["memberid"] != null)
            Response.Redirect("paymode.aspx");
        else
            Response.Redirect("login.aspx?page=paymode.aspx");
    }
}