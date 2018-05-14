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
using System.Text;
using System.Net;
using System.IO;
using System.Xml;
public partial class test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {




        XmlDocument xmlDoc = new XmlDocument();
        string strtxt = @"<?xml version='1.0' encoding='UTF-8'?><CUBXML><CAVALUE>e6a1e769e1873a70c0384700d463ea93</CAVALUE><ORDERINFO><STOREID>011210028</STOREID><ORDERNUMBER>00000009</ORDERNUMBER><AMOUNT>1</AMOUNT></ORDERINFO><AUTHINFO><AUTHSTATUS>0000</AUTHSTATUS><AUTHCODE>097862</AUTHCODE><AUTHTIME>20161026142131</AUTHTIME><AUTHMSG>授權成功</AUTHMSG></AUTHINFO></CUBXML>";
        XmlReader myReader;
        myReader = XmlReader.Create(Server.MapPath("20161026.xml"));
        string ORDERNUMBER = "";
        string AMOUNT = "";
        string AUTHSTATUS = "";
        string AUTHCODE = "";
        string AUTHTIME = "";
        string AUTHMSG = "";
         xmlDoc.LoadXml(strtxt);
        //xmlDoc.Load(myReader);
        foreach (XmlNode xNode in xmlDoc.SelectNodes("//CUBXML/ORDERINFO"))
        {
            ORDERNUMBER = xNode.SelectSingleNode("ORDERNUMBER").InnerText;
            AMOUNT = xNode.SelectSingleNode("AMOUNT").InnerText;
        }
        foreach (XmlNode xNode in xmlDoc.SelectNodes("//CUBXML/AUTHINFO"))
        {
            AUTHSTATUS = xNode.SelectSingleNode("AUTHSTATUS ").InnerText;
            AUTHCODE = xNode.SelectSingleNode("AUTHCODE").InnerText;
            AUTHTIME = xNode.SelectSingleNode("AUTHTIME ").InnerText;
            AUTHMSG = xNode.SelectSingleNode("AUTHMSG").InnerText;
        }

        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
        
            SqlCommand cmd = new SqlCommand();        
            string strsql;
            conn.Open();
            strsql = @" insert into CardAUTHINFO  (ord_code, amount, AUTHSTATUS, AUTHCODE, AUTHTIME, AUTHMSG ) values 
                        (  @ord_code, @amount, @AUTHSTATUS, @AUTHCODE, @AUTHTIME, @AUTHMSG ) ";
            cmd = new SqlCommand(strsql, conn);
       
            cmd.Parameters.Add("@ord_code", SqlDbType.VarChar).Value = ORDERNUMBER ;
            cmd.Parameters.Add("@amount", SqlDbType.VarChar).Value = AMOUNT;
            cmd.Parameters.Add("@AUTHSTATUS", SqlDbType.VarChar).Value = AUTHSTATUS;
            cmd.Parameters.Add("@AUTHCODE", SqlDbType.VarChar).Value = AUTHCODE;
            cmd.Parameters.Add("@AUTHTIME", SqlDbType.VarChar).Value = AUTHTIME;
            cmd.Parameters.Add("@AUTHMSG", SqlDbType.NVarChar).Value = AUTHMSG;

            cmd.ExecuteNonQuery();

        
            cmd.Dispose();
            conn.Close();
        }
    }
}