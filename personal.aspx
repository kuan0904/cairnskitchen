<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="personal.aspx.cs" Inherits="personal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 付費模式 -->
<div class="person-w">
	<div class="person-title"><img src="images/personal-title.png"></div>

    <div class="person-box">
    	<div class="person-main">
			<div class="person-m-title">個人資料</div>
            <div class="person-m-info">
            	<div class="person-m-row">
            		<span>電子郵件：</span><%=email %><br>
                	<span>姓　　名：</span><%=username  %><br>
                	<span>性　　別：</span><%=gender %><br>
                    <span>生　　日：</span><%=birthday %><br>
                	<span>手機號碼：</span><%=phone  %><br>
                    <span>聯絡地址：</span><%=zip  %><%=address  %>
				</div>
			</div>
        </div>
    </div>
    <div class="commo-w">
		<div class="modify-box">
         	<div class="modify-btn"><a href="modify.aspx">修改資料</a></div>
		</div>
	</div>

    <div class="history-w clear">
    	<div class="history-title">消費記錄</div>
        <div class="history-box">
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
<div class="history-main">
        		<div class="his-m-title">
                	訂購時間：<%#DateTime.Parse ( Eval("crtdat").ToString ()).ToString ("yyy-MM-dd hh:mm")  %>
                    <span>訂單編號：<%#Eval("ord_code") %></span>
				</div>
            	<div class="his-m-info">
                	訂購商品： <%#  unity.classlib . get_pd(Eval ("ord_id").ToString ()) %>
            		付款方式：<%# unity.classlib .getPaymode (Eval("paymode").ToString ()) %><br>
            		取貨方式，宅配到府<br>
            		應付金額：<%#Eval("totalprice") %>元<br>
            		發　　票：<%# unity.classlib .getInvoice  (Eval("Invoice").ToString ()) %><br>
                    統一編號：<%# Eval("companyno").ToString () %><br>
            		處理進度：<%# unity.classlib .getPaymode (Eval("paymode").ToString ()) %><br>
				</div>
			</div>
                </ItemTemplate>
            </asp:Repeater>
        	
   
            
        </div>
        
        
    </div>
    
</div>

<!--圖片淡入-->
<script src="js/mosaic.1.0.1.js"></script>
<script type="text/javascript">  
	jQuery(function($){
		$('.fade01,.fade02,.fade03').mosaic();
    });
</script>  
</asp:Content>

