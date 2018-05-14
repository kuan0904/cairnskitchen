using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using unity;
public partial class completed : System.Web.UI.Page
{
    public string msg = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["ord_id"] = null;
        Session["ShoppingList"] = null;
        Session["discount_no"] = null;

        DataTable dt = new DataTable();
        dt = classlib.Get_promo("11");
        msg = dt.Rows[0]["contents"].ToString();
        dt.Dispose();

    }
}