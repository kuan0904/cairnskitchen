﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="cart.aspx.cs" Inherits="cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script>
    var DeliveryPrice = <%=DeliveryPrice %> ;
    var ship_free = <%=ship_free %> ;
    var shipprice = 0;
    var   storage = 10;
    function num_change(obj, p_id) {
        num = obj.value;   
        goodsAdd(p_id, num, 'update');          
        /**
        if ( storage < 10){
            alert( storage);
            $(obj).empty();
            for ( i =  1 ; i<=  storage ;i++)
            {
                $(obj).append('<option value='+ i+'>' + i + '</option>');             
            }
        }
        **/
        recalculate();


    }
    
    function recalculate() {
        var amount = 0;
        $(".box-row").each(function (index) {
                var p_num = $(this).find('select[name="p_num"]').val();
                var p_price = $(this).find('#price').html();
                $(this).find('#subtotal').html(p_num * p_price);
                if( p_num == 0 ) location.href='cart.aspx';
                amount += p_num * p_price;
            });
        $('#amount').html(amount);
        if (amount >= ship_free ) 
            shipprice =0 ;
        else
            shipprice = DeliveryPrice

            $('#DeliveryPrice').html(shipprice);        
            $('#totalprice').html(amount + shipprice );
    }

    $(document).ready(function () {    
        $(".refresh-btn").click(function () {
                recalculate();
            });

        });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div  class="cart-w">
	<div class="cart-title"><img src="images/cart-title.png"></div>
    <div class="commo-w">
    	<div class="commo-title">
        	<div class="title-name">商品項目</div>
            <div class="title-unit">單價</div>
            <div class="title-quantity">數量</div>
            <div class="title-subtotal">小計</div>
		</div> 
        <div class="commo-box">
        <asp:Repeater ID="RepeaterList" runat="server">
            <ItemTemplate>       
    		<div class="box-row">
            	<div class="boxrow-img"><img src="upload/<%#Eval("pic") %>" width="90" height ="60"></div>
                <div class="boxrow-name"><%# Eval("productname") %></div>
                <div class="boxrow-unit">$ <span id="price"><%# Eval("price")%></span> </div>
                <div class="boxrow-input">
                    <select id="p_num" name="p_num" class="buyq-select"onchange ="num_change(this,'<%#Eval("p_id") %>')" >
                        <option value ="0">刪除</option>          
                       <%# get_storage(Eval("p_id").ToString(),(int) Eval("num"))%>;
                    </select></div>
                <div class="boxrow-subtotal">$ <span id="subtotal"><%# (int)Eval("price") * (int)Eval("num") %></span></div>
			</div>
     
            </ItemTemplate>       
        
		
        </asp:Repeater>    
            <div class="clear"></div>
        </div>   
		<div class="refresh-box">
         	<div class="refresh-btn" ><a href="javascitp:">重新計算</a></div>
		</div>
    	<div class="billing-box">
       	  <div class="billing-title">
            	<div class="bltitle-name">消費總計</div>
                <div class="bltitle-note">如消費金額滿<%=ship_free %>元，可免運費送達</div>
			</div>
           
        	<div class="billing-row">
            	<div class="blrow-list">
                	<div class="list-subtotal">小計</div>
                    <div class="subtotal-money">$ <span id="amount"><%=amount  %></span></div>
				</div>
            	<div class="blrow-list">
                	<div class="list-subtotal">運費</div>
                    <div class="subtotal-money">$ <span id="DeliveryPrice"><%=DeliveryPrice  %></span></div>
				</div>
			</div>
    		<div class="billing-row">
            	<div class="total-list">
            		<div class="list-total">總計</div>
            		<div class="total-money">$ <span id="totalprice"><%=totalprice  %></span></div>
				</div>
			</div>
		</div>
        <button ><a  href="pro-list.aspx">繼續購物</a> </button>
        <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click"  class="pay-btn"></asp:LinkButton>
       
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
