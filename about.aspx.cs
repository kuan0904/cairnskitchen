using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using unity;
public partial class about : System.Web.UI.Page
{
    public string msg = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = classlib.Get_promo("7");
        msg= dt.Rows[0]["contents"].ToString();
        dt.Dispose();
      
        Page.Title = string.Format("{0}Cairns廚房| 肉品及食材銷售專門", "我們的堅持| ");
        HtmlMeta ma1 = (HtmlMeta)this.Master.Page.Header.Controls[0];
        ma1.Content = classlib.RemoveHTMLTag(msg);
    }
}