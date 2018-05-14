<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pro-info.aspx.cs" Inherits="pro_info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
    var price=<%=price  %>;
	$(document).ready(function() {
	    $("#addbuy").click(function () {
	        var num = $("#num").val();
	        var p_id = '<%=Request.QueryString ["p_id"]%>'      
	        goodsAdd(p_id, num,'add');
	    });

	    $("#num").change(function () {
	        $(".buyq-total").html($(this).val() * price  );	       
	    });
	});
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 商品內容 -->
<div  class="itinfo-w">
	<!--banner-->
	<div class="itinfo-banner">
    	<img src="upload/<%=logo %>?<%=DateTime.Now.ToString ("yyyyMMddhhmmss") %>">
	</div>
    <!--介紹-->
	<div class="itif-content">
        <div class="itifc-right">
        	<div class="itifcr-name"><%=productname  %></div>
            <div class="itifcr-price">
				售價<span><%=price  %></span>元
			</div>
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

