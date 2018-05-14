<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pro-info.aspx.cs" Inherits="pro_info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        var price=<%=price  %>;
        var p_id = '<%=Request.QueryString ["p_id"]%>'      
	$(document).ready(function() {
	    $("#addbuy").click(function () {
	        var num = $("#num").val();	    
	        goodsAdd(p_id, num,'add');
	    });

	    $("#num").change(function () {	
            var num= parseInt($(this).val());
	        $.post('get_price.ashx', {
	            "p_ID": p_id
           , "p_num":num        
           , "_": new Date().getTime()
	        }, function (data) {	           
	            var price= parseInt( data);	          
	            $(".buyq-total").html(num * price);
	     
	        });
	    });
	});
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 商品內容 -->
<div  class="itinfo-w">
	<!--banner-->
	<div class="itinfo-banner">
    	<img src="upload/<%=logo %>">
	</div>
    <!--介紹-->
	<div class="itif-content">
        <div class="itifc-right">
        	<div class="itifcr-name"><%=productname  %></div>        
            <div class="itifcr-price">  
				<span style="font-size:32px; color:#748b44;text-align:left;  padding:0 10px 0 20px; margin:0 0 0 10px; font-family:'Lato'; " ><%=Pricing%></span>
                <span style="font-size:32px; color:#f00;float:right;  padding:0 10px 0 20px; margin:0 0 0 10px; font-family:'微軟正黑體'; "><%=sell_text%><%=price%></span> 
			</div>
            <div  style="clear:both;text-align:right;"><% =Savetxt%></div> 
           
            <div class="itifcr-info">
               <%=description  %>
			</div>
		</div>
		<div class="itifc-lift">
			<!-- Slideshow 3 -->
          <ul class="rslides" id="slider3">
                <%=check_img(pic[1],1)%>
           	    <%=check_img(pic[2],1)%>
                <%=check_img(pic[3],1)%>
		  </ul>
			<!-- Slideshow 3 Pager -->
			<ul id="slider3-pager">
				<%=check_img(pic[1],2)%>
           	    <%=check_img(pic[2],2)%>
                <%=check_img(pic[3],2)%>
			</ul>
      </div>
	</div>
    <div class="clear"></div>
	<!--數量-->    
    <div class="buy-box">
    	<div class="buy-title"><img src="images/buy-title.png"></div>
        <div class="buy-info">
        	<div class="buy-quan">
            	<div class="buyq-font">數　量</div>
                <div class="">                    
                	<select class="buyq-select" id="num">
                    	<%=buy_num_option %>
					</select>
                </div>
                <div class="buyq-total"><%=price  %></div>
                <div class="buyq-fontb">元</div>
            </div>
            <div class="clear"></div>
		</div>
        <a href="#" class="tocart-btn" id="addbuy"></a>
    </div>
</div>


     

<!--商品輪播-->
<script type="text/javascript" src="js/responsiveslides.min.js"></script>
<script>
// You can also use "$(window).load(function() {"
	$(function () {
	// Slideshow 3
		$("#slider3").responsiveSlides({
		manualControls: '#slider3-pager',
		maxwidth: 360
		});
	});
</script>
</asp:Content>

