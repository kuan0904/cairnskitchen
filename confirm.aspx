<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="confirm.aspx.cs" Inherits="confirm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="confirm-w">
	<div class="confirm-title"><img src="images/confirm-title.png"></div>

    <div class="commo-w">
    	<div class="commo-title">
        	<div class="title-name02">商品項目</div>
            <div class="title-quantity">數量</div>
            <div class="title-subtotal">小計</div>
		</div>
           <div class="commo-box">
    		  <asp:Repeater ID="RepeaterList" runat="server">
            <ItemTemplate>       
    		<div class="box-row">
            	<div class="boxrow-img"><img src="upload/<%#Eval("pic") %>" width="90" height ="60"></div>
                <div class="boxrow-name"><%# Eval("productname") %></div>
                <div class="boxrow-unit">$ <%# Eval("price")%></div>
                <div class="boxrow-input"><%# Eval("num") %></div>
                <div class="boxrow-subtotal">$  <%# (int)Eval("price") * (int)Eval("num") %></div>
			</div>            
            </ItemTemplate>
        </asp:Repeater>    
                <%=free_gift %>
                   <div class="box-row">
            	<div class="boxrow-img"><img src="images/SALE.png"></div>
                <div class="boxrow-name02">折扣</div>
                <div class="boxrow-input"></div>
                <div class="boxrow-subtotal"> $-<%= discountprice%></div>
			</div>      
                <div class="box-row">
            	<div class="boxrow-img"><img src="images/shipment-img.jpg"></div>
                <div class="boxrow-name02">運費</div>
                <div class="boxrow-input"></div>
                <div class="boxrow-subtotal">$<%= DeliveryPrice %></div>
			</div>
                    <div class="clear"></div>
		</div>       

        
    	<div class="billing-box">
    		<div class="billing-row">
            	<div class="total-list">
            		<div class="list-total">總計</div>
            		<div class="total-money">$ <%=totalprice %></div>
				</div>
			</div>
		</div>
	</div>
    
    <div class="confirm-box">
    	<div class="confirm-main">
			<div class="confirm-m-title">付款方式與訂購資訊</div>
            <div class="confirm-m-info">
            	<div class="confirm-m-row">
            		<span>付款方式：</span><%=paymode  %><br>
                	<span>到府時間：</span><%=receivetime  %><br>
                	<span>訂購人姓名：</span><%=username  %><br>
                	<span>手機號碼：</span><%=phone %><br>
				</div>
                <div class="confirm-m-row">
                	<span>收件人姓名：</span><%=shipname  %><br>
                	<span>手機號碼：</span><%=shipphone%><br>
                	<span>收件地址：</span><%=shipaddress %><br>
                	<span>發票資訊：</span><%=invoice %><br>
                    <span>統一編號：</span><%=companyno  %><br>
                    <span>公司抬頭：</span><%=title  %><br>
                	<span>備註說明：</span><%=contents  %>
				</div>
			</div>
        </div>
    </div>
       
    <div class="commo-w">
		<div class="page-box">
        	<div class="prev-btn"><a href="information.aspx">回上一頁</a></div>
         	<div class="next-btn"><asp:LinkButton ID="LinkButton1" runat="server" OnClick ="buy_Click" >確認購買</asp:LinkButton></div>
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

