using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using unity;
using System.Data;
using System.Data.SqlClient;
using ServiceReference1;
public partial class webtest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ServiceReference1.CRDOrderServiceSoapClient ws = new ServiceReference1.CRDOrderServiceSoapClient();

        string CAVALUE = "";
        string STOREID = "011210028";
        string ORDERNUMBER = "";
        string AMOUNT = "1";
        string CUBKEY = "d6389d21e43d61ed226d75e5ab03e68d";

        ORDERNUMBER = "00000002";
        AMOUNT = "1";
        CAVALUE = STOREID + ORDERNUMBER + AMOUNT + CUBKEY;
        CAVALUE = classlib.GetMD5(CAVALUE);
        string xml = @"<?xml version='1.0' encoding='UTF-8'?>" +
"<MERCHANTXML>" +
"<MSGID>" + ORDERNUMBER + "</MSGID>" +
"<CAVALUE>" + CAVALUE + "</CAVALUE>" +
"<ORDERINFO>" +
"<STOREID>" + STOREID + "</STOREID>" +
"<ORDERNUMBER>" + ORDERNUMBER + "</ORDERNUMBER>" +
"<AMOUNT>" + AMOUNT + "</AMOUNT>" +
"</ORDERINFO>" +
"</MERCHANTXML>";
        string aa = ws.CRDOrderMethod(xml);
        Response.Write(aa);
    }
}