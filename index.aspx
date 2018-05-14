<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!--桌機按鈕-->
<div id="menu" class="default">
	<div class="idx-share">
		<a href="https://www.facebook.com/Cairnskitchen/" target="_blank" class="share-fb"></a>
        <!--<a href="" class="share-tw"></a>-->
        <a href="http://cairnskitchen520.pixnet.net/blog" target="_blank" class="share-gg"></a>
    </div>
    <div class="idx-cart">
        <a href="join.aspx" class="join-btn"></a>
    	    <a href="personal.aspx" class="personal-btn"></a>
    	    <a href="cart.aspx" class="cart-btn"></a>
	    </div>
    <div class="idx-logo">
    	<a href="index.aspx"><img src="images/index-logo.png"></a>
    </div>
    <div class="idxmenu">
		<ul>
			<li class="menu-left"><a href="about.aspx">我們的堅持</a></li>
			<li class="menu-left"><a href="pro-list.aspx">嚴選商品</a></li>
			<li class="menu-right"><a href="service.aspx">我們的服務</a></li>
			<li class="menu-right"><a href="note-list.aspx">料理日誌</a></li>
			<div class="inside-logo"><a href="index.aspx"><img src="images/inside-logo.png"></a></div>
		</ul>
	</div>
</div>
<!-- close menu --> 
<!-- close navi -->

<div id="content">
	<div class="top-bammer">
		<div class="bn-slogan">
        	<div class="slogan-name"><img src="images/cairns-kitchen.png"></div>
        	
        	<!--<div class="slogan-name">凱恩斯廚房</div>-->
            <div class="slogan-a"><img src="images/idx-slogan.png"></div>
            <img src="images/idx-slogan-02.png">
            <!----><div class="slogan-down"><img src="images/idx-arrow-down.png"></div>
      </div>
	</div>
</div>
<!--商品輪播-->
<div class="pro-w">
	<div class="pro-w-title"><img src="images/idx-title-pro.png"></div>
	<div class="slider js_ease ease">
		<div class="frame js_frame">
			<ul class="slides js_slides">
                    <asp:Repeater ID="pd_push" runat="server">
                       <ItemTemplate >
                        <li class="js_slide">
                            <div class="uptype mosaic-block fade0<%#Container.ItemIndex%2 ==0?"1":"2" %>"> <a href="pro-info.aspx?p_id=<%#Eval("p_id") %>" class="mosaic-overlay">&nbsp;</a>
                            <%#Container.ItemIndex%2 == 0 ? "<div class=\"mosaic-backdrop up-img\"><img src=\"upload/" + Eval("banner").ToString() + "\" width=\"200\" height =\"200\"></div>" : ""%>
                            <div class="up-info"> <a href="pro-info.aspx?p_id=<%#Eval("p_id") %>">
                                <div class="up-arrow"></div>
                                <div class="up-title"><%#Eval("productname") %></div>
                                <div class="up-explan"><%#Eval("memo") %></div>
                                <div class="up-price"><span style ="text-decoration: line-through;color : grey;font-size:18px;  "><%#Eval("Pricing") %></span>$<span><%#Eval("price") %></span></div>
                                 
                            </a> </div>
                            <%#Container.ItemIndex%2 == 1 ? " <div class=\"mosaic-backdrop down-img\"><img src=\"upload/" + Eval("banner").ToString () + "\" width=\"200\" height =\"200\"></div>":""%>
                            </div>
                            </li>
               
                        </ItemTemplate>
                      </asp:Repeater>     
                  </ul>
		</div>
		<span class="js_prev prev"></span>
		<span class="js_next next"></span>
	</div>
</div>
<!--日誌-->
<div class="note-w">
	<div class="note-w-title"><img src="images/idx-title-cook.png"></div>
    <div class="note-box">
   	     <asp:Repeater ID="Repeaterdiary" runat="server">
            <ItemTemplate >
            <div class="n-item-box mosaic-block fade03">
        	            <a href="note-info.aspx?id=<%#Eval("d_id") %>" class="mosaic-overlay">&nbsp;</a>
        	            <div class="mosaic-backdrop"><img src="upload/<%#Eval("pic") %>" width="240" height ="180"></div>
                        <div class="n-info">
            	            <div class="n-info-title"><%#Eval("subject") %></div>
            	            View More
			            </div>
                    </div>

                  </ItemTemplate>
        </asp:Repeater>
    </div>
    <a href="note-list.aspx" class="note-more"></a>
</div>
<!--首頁服務-->
<div class="service-w">
	<div class="ser-title"><img src="images/idx-title-service.png"></div>
    <div class="ser-box">
    	<a href="service.aspx#attentio" class="attentio-btn">下單注意事項</a>
        <a href="service.aspx#delivery" class="attentio-btn">送貨及退換貨</a>
    </div>
</div>
    <!-- content --> 
<!--圖片淡入-->
<script type="text/javascript" src="js/nagging-menu.js" charset="utf-8"></script>
            <script>
	'use strict';
		document.addEventListener('DOMContentLoaded', function () {
        	var ease = document.querySelector('.js_ease');

	        // http://easings.net/

            lory(ease, {
                infinite: 4,
                slidesToScroll: 1,
                slideSpeed: 300,
                ease: 'cubic-bezier(0.455, 0.03, 0.515, 0.955)',
                enableMouseEvents: true
            });
    	});
 </script>

</asp:Content>

