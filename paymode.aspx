<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="paymode.aspx.cs" Inherits="paymode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script>
    var DeliveryPrice = <%=DeliveryPrice %> ;
    var ship_free = <%=ship_free %> ;   
    var totalprice = <%=totalprice %>;
    var shipprice = 0;
    var   storage = 10;
    function recalculate() {
        var amount = 0;
     
        $(".box-row").each(function (index) {
            var obj = $(this);
            var num = $(this).find('#num').html();
            var subtotal = $(this).find('#subtotal').html();                
        
            //$("#discount_price").html( data );

        });
       
    }

 
            $(document).ready(function () {    
              //  recalculate();
                $("#discount_no").on("change paste keyup", function () {
                    $("#discount_price").html('0');
                    if ($(this).val() != "") {
                        var price = '<%=totalprice%>';
                        $.post('member_handle.ashx', { "p_ACTION": "get_discount", "discount_no": $(this).val(),"price":price, "_": new Date().getTime() }, function (data) {                            
                            if (data != "0") {
                                if (data == "-1") {
                                    alert('此代碼失效!');
                                    $("#discount_no").val('');
                                }
                                if (data == "-3") {
                                    alert('未達使用金額!');
                                    $("#discount_no").val('');
                                }
                                else if (data == "-2") {
                                    alert('你已使用過!');
                                    $("#discount_no").val('');
                                }
                                else {
                                    $("#discount_price").html( data );
                               
                                    //recalculate();
                                }
                             
                            }

                            $("#totalprice").html( totalprice - data );
                        });
                    }

                });

            });
            function checkdata() {
                if ($("#paymode1").prop("checked") == false && $("#paymode2").prop("checked") == false && $("#paymode3").prop("checked") == false) {
                    alert('請選擇付款方式');
                    return false;
                }
                else if ($("#time1").prop("checked") == false && $("#time2").prop("checked") == false && $("#time3").prop("checked") == false) {
                    alert('請選擇宅配到府時間');
                    return false;
                }
            }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 付費模式 -->
<div class="pay-w">
	<div class="pay-title"><img src="images/payment-title.png"></div>
    <div class="pay-box">
    	<div class="pay-main">
        	<div class="pay-m-title">付款方式</div>
        	<div class="pay-m-info">
            	<div class="pay-m-row"><input type="radio" class="radio-pay" name="paymode" id="paymode1" value="1" />線上刷卡</div>
        		<div class="pay-m-row"><input type="radio" class="radio-pay" name="paymode" id="paymode2" value="2" />轉帳匯款</div>
        		<div class="atm-info">
                <%=unity.classlib.Get_ck_atmno () %>
				</div>
        		<div class="pay-m-row"><input type="radio" class="radio-pay" name="paymode" id="paymode3" value="3" />貨到付款</div>
            </div>
		</div>
        <div class="pay-main">
        	<div class="pay-m-title">取貨方式</div>
        	<div class="pay-m-info">
            	宅配到府
        		<span><input type="radio" class="radio-time" name="receivetime" id="time1" value="1" />不指定時間</span>
        		<span><input type="radio" class="radio-time" name="receivetime" id="time2" value="2" />13:00前</span>
        		<span><input type="radio" class="radio-time" name="receivetime" id="time3" value="3" />14:00-18:00</span>
        	
			</div>
		</div>
        <div class="pay-main">
       	  <div class="pay-m-title">備註說明</div>
            <textarea name="contents" class="pay-textarea" id="content" placeholder="要注意的事項"></textarea>
        </div>
    </div>


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
                <span id="p_id" style ="display:none"><%#Eval("p_id") %></span><span style ="display:none"> <%#totalprice +=  (int)Eval("price") * (int)Eval("num") %></span>
            	<div class="boxrow-img"><img src="upload/<%#Eval("pic") %>" width="90" height ="60"></div>
                <div class="boxrow-name"><%# Eval("productname") %></div>
                <div class="boxrow-unit">$<span id="price"><%# Eval("price")%></span> </div>
                <div class="boxrow-input"><span id="num"><%# Eval("num") %></span></div>
                <div class="boxrow-subtotal">$<span id="subtotal"> <%# (int)Eval("price") * (int)Eval("num") %></span> </div>          
			</div>
            </ItemTemplate>
        </asp:Repeater>         
               <%=free_gift %>
      
		      <div class="box-row">
            	<div class="boxrow-img"><img src="images/SALE.png"></div>
                <div class="boxrow-name">輸入折價券代碼</div>
                <div class="boxrow-unit"> <input id="discount_no" name ="discount_no" type="text" class="input-coupon" /></div>
                <div class="boxrow-input">　</div>
                <div class="boxrow-subtotal" >$<span id="discount_price">0</span></div>		 
            </div>      
                    
                <div class="box-row">
            	<div class="boxrow-img"><img src="images/shipment-img.jpg"></div>
                <div class="boxrow-name02">運費</div>
                <div class="boxrow-input"></div>
                <div class="boxrow-subtotal">$ <span id="DeliveryPrice"><%=DeliveryPrice  %></span></div>
			</div>
           
            		
    	     
	
             <div class="clear"></div>	  
            	<div class="billing-box">
    		<div class="billing-row">
            	<div class="total-list">
            		<div class="list-total">總計</div>
            		<div class="total-money">$ <span id="totalprice"><%=totalprice  %></span></div>
				</div>
			</div>
		</div>
        </div> 
            	

		<div class="page-box">
        	<div class="prev-btn"><a href="cart.aspx">回購物車</a></div>
         	<div class="next-btn">
                 <asp:LinkButton ID="payLinkButton" runat="server" OnClientClick ="return checkdata();" OnClick ="payLinkButton_Click" >下一步</asp:LinkButton></div>
		</div>
	</div>
    
</div>


</asp:Content>

