using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
public partial class paymode : System.Web.UI.Page
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
    public int Shipment = 180;
    public int ship_free = 1600;
    public int amount = 0;
    public int totalprice = 0;
    public string free_gift = "";
    public int DeliveryPrice = 180;
    protected void Page_Load(object sender, EventArgs e)
    {
         if (Session["ShoppingList"] == null)
            {
            Response.Write ("<script>alert('資料有誤');location.href='index.aspx';</script>");
            Response.End();
        }
        else
        {
            ship_free = classlib.Get_ship_free();
            DeliveryPrice = classlib.Get_DeliveryPrice();
            List<ShoppingList> Shoppinglist = new List<ShoppingList>();
                Shoppinglist = Session["ShoppingList"] as List<ShoppingList>;
                RepeaterList.DataSource = Shoppinglist;
                RepeaterList.DataBind();

            foreach (ShoppingList idx in Shoppinglist)
            {
                //if (idx.p_id == "30" || idx.p_id == "31" || idx.p_id == "30" || idx.p_id == "33" || idx.p_id == "34" || idx.p_id == "35")
                //{
                //    free_gift = "<div class=\"box-row\"><div class=\"boxrow-img\"><img src = \"upload/44-1.jpg\" width=\"90\" height =\"60\"></div><div class=\"boxrow-name\">【贈品】21oz美國霜降嫩肩牛排</div>";
                //    free_gift += "<div class=\"boxrow-unit\">$0</div><div class=\"boxrow-input\"> 1 </div> <div class=\"boxrow-subtotal\">$ 0 </div></div>";
                //}
                amount += (idx.price * idx.num);
            }
            if (amount >= ship_free) DeliveryPrice = 0;
            totalprice = amount + DeliveryPrice;
        }
       
    }

    protected void payLinkButton_Click(object sender, EventArgs e)
    {
        Session["receivetime"] = Request.Form["receivetime"];
        Session["paymode"] = Request.Form["paymode"];
        Session["contents"] = Request.Form["contents"];
        Session["discount_no"] = Request.Form["discount_no"];       
        Response.Redirect("information.aspx");
    }
}