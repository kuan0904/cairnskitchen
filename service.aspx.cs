using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using unity;
using System.Web.UI.HtmlControls;
public partial class servive : System.Web.UI.Page
{

    public string msg1 = "";
    public string msg2 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
  
        DataTable dt = new DataTable();
        dt = classlib.Get_promo("8");
        msg1= dt.Rows[0]["contents"].ToString();
        dt.Dispose();
        dt = classlib.Get_promo("9");
        msg2 = dt.Rows[0]["contents"].ToString();
        dt.Dispose();
        Page.Title = string.Format("{0}|Cairns廚房| 肉品及食材銷售專門", "我們的服務");
        HtmlMeta ma1 =  (HtmlMeta)this.Master.Page.Header.Controls[5];
        ma1.Content = classlib.RemoveHTMLTag ( msg2);
    }
}