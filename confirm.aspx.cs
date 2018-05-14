using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;

public partial class confirm : System.Web.UI.Page
{
    public int DeliveryPrice = 180;
    public int ship_free = 1600;
    public int amount = 0;
    public int totalprice = 0;
    public string paymode = "";
    public string receivetime = "";
    public string email = "";
    public string password = "";
    public string zip = "";
    public string address = "";
    public string cityid = "";
    public string countyid = "";
    public string gender = "";
    public string username = "";
    public string phone = "";
    public string shipzip = "";
    public string shipaddress = "";
    public string shipcityid = "";
    public string shipcountyid = "";
    public string shipgender = "";
    public string shipname = "";
    public string shipphone = "";
    public string contents = "";
    public string invoice = "";
    public string companyno = "";
    public string birthday = "";
    public string title = "";
    public string discountTxt = "";
    public int discountprice = 0;
    public string free_gift ="";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ShoppingList"] == null || Session["orderData"] ==null )
        {
            Response.Write("<script>alert('資料有誤');location.href='index.aspx';</script>");
            Response.End();
        }
        else
        {
            amount = 0;
            ship_free = classlib.Get_ship_free();
            DeliveryPrice = classlib.Get_DeliveryPrice();
            List<ShoppingList> Shoppinglist = new List<ShoppingList>();
            Shoppinglist = Session["ShoppingList"] as List<ShoppingList>;
            RepeaterList.DataSource = Shoppinglist;
            RepeaterList.DataBind();

            //foreach (ShoppingList idx in Shoppinglist)
            //{
            //    if (idx.p_id == "30" || idx.p_id == "31" || idx.p_id == "30" || idx.p_id == "33" || idx.p_id == "34" || idx.p_id == "35")
            //    {
            //        free_gift = "<div class=\"box-row\"><div class=\"boxrow-img\"><img src = \"upload/44-1.jpg\" width=\"90\" height =\"60\"></div><div class=\"boxrow-name\">【贈品】21oz美國霜降嫩肩牛排</div>";
            //        free_gift += "<div class=\"boxrow-unit\">$0</div><div class=\"boxrow-input\"> 1 </div> <div class=\"boxrow-subtotal\">$ 0 </div></div>";
            //    }

            //}

          
            foreach (ShoppingList idx in Shoppinglist)
            {
                amount += (idx.price * idx.num);
            }
            discountTxt = classlib.Get_coupon_price("", Session["discount_no"].ToString(),amount.ToString ());
            if (discountTxt == "-1" || discountTxt == "-2" || discountTxt == "")
            { discountTxt = ""; }
            else
            {
                discountprice = int.Parse(discountTxt);
            }
            if (amount >= ship_free) DeliveryPrice = 0;
            totalprice = amount + DeliveryPrice - discountprice ;
       
            List <orderData> orderData = new List<orderData>();
            orderData = Session["orderData"] as List<orderData>;
            foreach (orderData idx in orderData)
            {
             
                receivetime = idx.receiveTime;
                paymode = idx.paymode ;
                username  = idx.ordname;
                phone = idx.ordphone;
                gender = idx.ordgender;
                invoice = idx.invoice;
                contents = idx.contents;
                shipname = idx.shipname;
                shipphone = idx.shipphone;
                shipgender = idx.shipgender;
                shipaddress = idx.shipzip + classlib.Get_countyName  (idx.shipcountyid ) + classlib.Get_cityName (idx.shipcityid  ) + idx.shipaddress;
                string id = idx.shipcityid;
              
                if (id.IndexOf("-") != -1)
                {
                    id = id.Substring(0, id.IndexOf("-") );
                }
              
                invoice = idx.invoice;
                email = idx.ordemail;
                password = idx.password;
     
 
                address = idx.ordzip + classlib.Get_countyName(idx.ordcountyid) + classlib.Get_cityName(idx.ordcityid) + idx.ordaddress;
                companyno = idx.companyno;
                title = idx.title;
                birthday = idx.birthday;
            }

        
            paymode = Session["paymode"].ToString();
            if (paymode == "1") paymode = "線上刷卡";
            if (paymode == "2") paymode = "轉帳匯款";
            if (paymode == "3") paymode = "貨到付款";
            if (receivetime == "1") receivetime = "不指定時間 ";
            if (receivetime == "2") receivetime = "13:00前 ";
            if (receivetime == "3") receivetime = "14:00-18:00 ";
            if (receivetime == "4") receivetime = "17:00-20:00 ";
            if (invoice == "2") invoice = "二聯式發票";
            if (invoice == "3") invoice = "三聯式發票";
        }

    }

    protected void buy_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            DataTable dt =new DataTable ();
            string subject = "";
            string msg = "";
            string mailbody = "";
            string ordaddress = "";
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;
            string strsql;
            conn.Open();
            List<orderData> orderData = new List<orderData>();
            orderData = Session["orderData"] as List<orderData>;
            foreach (orderData idx in orderData)
            {
                receivetime = idx.receiveTime;
                paymode = idx.paymode;
                username = idx.ordname;
                phone = idx.ordphone;
                invoice = idx.invoice;
                contents = idx.contents;
                shipname = idx.shipname;
                shipphone = idx.shipphone;
                shipaddress = idx.shipzip + classlib.Get_countyName(idx.shipcountyid) + classlib.Get_cityName(idx.shipcityid) + idx.shipaddress;
           
                invoice = idx.invoice;
                email = idx.ordemail;
                password = idx.password;
                address = idx.ordaddress;
                cityid = idx.ordcityid;
                countyid = idx.ordcountyid;
                zip = idx.ordzip;
                shipgender = idx.shipgender;
                ordaddress = idx.ordzip + classlib.Get_countyName(idx.ordcountyid) + classlib.Get_cityName(idx.ordcityid) + idx.ordaddress;
                companyno = idx.companyno;
                birthday = idx.birthday;
                title = idx.title;

            }
            if (Session["memberid"] == null)
            {
                strsql = @"insert into  MemberData (email, username, gender, phone, address,
password, countyid, cityid, zip, crtdat, lastlogin,birthday) values 
                        (@email, @username, @gender, @phone, @address, @password, @countyid,
@cityid, @zip, getdate(), getdate(),@birthday) ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
                cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = username;
                cmd.Parameters.Add("@gender", SqlDbType.NVarChar).Value = gender;
                cmd.Parameters.Add("@phone", SqlDbType.VarChar).Value = phone;
                cmd.Parameters.Add("@zip", SqlDbType.VarChar).Value = zip;
                cmd.Parameters.Add("@cityid", SqlDbType.VarChar).Value = cityid;
                cmd.Parameters.Add("@countyid", SqlDbType.VarChar).Value = countyid;
                cmd.Parameters.Add("@address", SqlDbType.NVarChar).Value = address;
                cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                cmd.Parameters.Add("@birthday", SqlDbType.VarChar).Value = birthday;
                cmd.ExecuteNonQuery();
                cmd.Dispose();

                strsql = @"select max(memberid) from   MemberData  ";
                cmd = new SqlCommand(strsql, conn);
                rs = cmd.ExecuteReader();
                if (rs.Read()) Session["memberid"] = rs[0].ToString();
                rs.Close();
                cmd.Dispose();
          
          
                dt = classlib.Get_promo("5");
                subject = dt.Rows[0]["ps_name"].ToString();
                mailbody = dt.Rows[0]["contents"].ToString();
                mailbody = mailbody.Replace("@password@", password );
                mailbody = mailbody.Replace("@email@", email);
                msg = classlib.SendsmtpMail(email, subject, mailbody, "gmail");
                dt.Dispose();
                classlib.SendsmtpMail(email, "【cairnskitchen】會員註冊通知", mailbody, "");
            }
            else {
                strsql = @"select * from   MemberData where memberid=@memberid  ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@memberid", SqlDbType.VarChar).Value = Session["memberid"].ToString ();
            
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    email = rs["email"].ToString();
                }
                cmd.Dispose();
                rs.Close();
            }
            string ord_code = classlib.Get_ord_code(DateTime.Today.ToString("yyyy/MM/dd"));
            List<ShoppingList> Shoppinglist = new List<ShoppingList>();
            Shoppinglist = Session["ShoppingList"] as List<ShoppingList>;
            //RepeaterList.DataSource = Shoppinglist;
            //RepeaterList.DataBind();
            amount = 0;
            foreach (ShoppingList idx in Shoppinglist)
            {
                amount += (idx.price * idx.num);
            }
            discountTxt = classlib.Get_coupon_price("", Session["discount_no"].ToString(), amount.ToString ());
            if (discountTxt == "-1" || discountTxt == "-2" || discountTxt == "")
            { discountprice = 0; }
            else
            {
                discountprice = int.Parse(discountTxt);
            }
            if (amount >= ship_free) DeliveryPrice = 0;
            totalprice = amount + DeliveryPrice -discountprice ;

            strsql = @"insert into OrderData
            (ord_code, memberid, paymode, invoice,  receivetime, contents,  SubPrice, DeliveryPrice, DiscountPrice, 
                TotalPrice, status,ordname,ordphone,ordaddress,shipname,shipphone,shipaddress,companyno,title
            ,ordgender,shipgender,coupon_no) values 
                (@ord_code,@memberid, @paymode, @invoice, @receivetime, @contents,@SubPrice, @DeliveryPrice, 
                @DiscountPrice,@TotalPrice, @status,@ordname,@ordphone,@ordaddress,@shipname,@shipphone,@shipaddress
                ,@companyno,@title,@ordgender,@shipgender,@coupon_no)";    
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@ord_code", SqlDbType.VarChar).Value = ord_code;
            cmd.Parameters.Add("@memberid", SqlDbType.VarChar).Value = Session["memberid"].ToString ();
            cmd.Parameters.Add("@receivetime", SqlDbType.NVarChar).Value = receivetime;
            cmd.Parameters.Add("@contents", SqlDbType.NVarChar).Value = contents;
            cmd.Parameters.Add("@SubPrice", SqlDbType.VarChar).Value = amount ;
            cmd.Parameters.Add("@DeliveryPrice", SqlDbType.VarChar).Value = DeliveryPrice;
            cmd.Parameters.Add("@DiscountPrice", SqlDbType.VarChar).Value = discountprice ;
            cmd.Parameters.Add("@TotalPrice", SqlDbType.VarChar).Value = totalprice;
            cmd.Parameters.Add("@status", SqlDbType.NVarChar).Value = "N";
            cmd.Parameters.Add("@paymode", SqlDbType.VarChar).Value = paymode;
            cmd.Parameters.Add("@invoice", SqlDbType.VarChar).Value = invoice;
            cmd.Parameters.Add("@ordname", SqlDbType.VarChar).Value = username ;
            cmd.Parameters.Add("@ordphone", SqlDbType.VarChar).Value = phone ;
            cmd.Parameters.Add("@ordaddress", SqlDbType.VarChar).Value = ordaddress;
            cmd.Parameters.Add("@shipname", SqlDbType.VarChar).Value = shipname;  
            cmd.Parameters.Add("@shipphone", SqlDbType.VarChar).Value = shipphone;
            cmd.Parameters.Add("@shipaddress", SqlDbType.VarChar).Value = shipaddress;
            cmd.Parameters.Add("@companyno", SqlDbType.VarChar).Value = companyno;
            cmd.Parameters.Add("@title", SqlDbType.NVarChar ).Value = title;
            cmd.Parameters.Add("@ordgender", SqlDbType.NVarChar).Value = gender;
            cmd.Parameters.Add("@shipgender", SqlDbType.NVarChar).Value = shipgender;
            cmd.Parameters.Add("@coupon_no", SqlDbType.VarChar).Value = Session["discount_no"].ToString();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            strsql = @"select max(ord_id)   from  orderdata   ";
            cmd = new SqlCommand(strsql, conn);
            rs = cmd.ExecuteReader();
            if (rs.Read()) Session["ord_id"] = rs[0].ToString();
            cmd.Dispose();
            rs.Close();
            //foreach (ShoppingList idx in Shoppinglist)
            //{
            //    if (idx.p_id == "30" || idx.p_id == "31" || idx.p_id == "30" || idx.p_id == "33" || idx.p_id == "34" || idx.p_id == "35")
            //    {
            //        free_gift = "y";
            //    }

            //}
            //if (free_gift != "")            {
         
            //    Shoppinglist.Add(new ShoppingList
            //        {
            //            p_id = "44",
            //            num = 1,
            //            price = 0,
            //            productname = "【贈品】21oz美國霜降嫩肩牛排",
            //            pic = "",
            //            amount = 0
            //        });             

            //}
            foreach (ShoppingList idx in Shoppinglist)
            {
                strsql = @"insert into OrderDetail (ord_id, p_id, num,price, amount,ord_code) values 
                        (@ord_id, @p_id, @num, @price, @amount,@ord_code) ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@ord_id", SqlDbType.VarChar).Value = Session["ord_id"].ToString ();
                cmd.Parameters.Add("@ord_code", SqlDbType.VarChar).Value = ord_code ;
                cmd.Parameters.Add("@p_id", SqlDbType.Int ).Value = idx.p_id ;
                cmd.Parameters.Add("@num", SqlDbType.Int ).Value = idx.num ;
                cmd.Parameters.Add("@price", SqlDbType.Int ).Value = idx.price ;
                cmd.Parameters.Add("@amount", SqlDbType.Int).Value = idx.num * idx.price ;
                cmd.ExecuteNonQuery();
                strsql = @"update productData set storage = storage - @num where p_id=@p_id"; 
                cmd = new SqlCommand(strsql, conn);      
                cmd.Parameters.Add("@p_id", SqlDbType.Int).Value = idx.p_id;
                cmd.Parameters.Add("@num", SqlDbType.Int).Value = idx.num;           
                cmd.ExecuteNonQuery();
            
            }
          
            dt = classlib.Get_promo("4");
            subject = dt.Rows[0]["ps_name"].ToString();
            mailbody = dt.Rows[0]["contents"].ToString();        
            string atmno = classlib.Get_ck_atmno();         
          
            dt.Dispose();           
            if (paymode != "2") atmno = "";
            mailbody = mailbody.Replace("@atmno@", atmno);
            msg = classlib.SendsmtpMail(email, subject, mailbody, "gmail");

            if (Session["discount_no"].ToString()!="")
            {
                strsql = @"insert into coupon_log (ord_id,coupon_no,ord_code,usetime) values 
                        (@ord_id,@coupon_no,@ord_code,getdate()) ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@ord_id", SqlDbType.VarChar).Value = Session["ord_id"].ToString();
                cmd.Parameters.Add("@ord_code", SqlDbType.VarChar).Value = ord_code;
                cmd.Parameters.Add("@coupon_no", SqlDbType.VarChar ).Value = Session["discount_no"].ToString();   
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                strsql = @"update  coupon set num = num -1 where  sn = @coupon_no  ";
                cmd = new SqlCommand(strsql, conn);            
                cmd.Parameters.Add("@coupon_no", SqlDbType.VarChar).Value = Session["discount_no"].ToString();
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            conn.Close();
        }
        if (paymode =="2" || paymode =="3") Response.Redirect ("completed.aspx");
        if (paymode == "1") Response.Redirect("cardpay.ashx");
    }
}