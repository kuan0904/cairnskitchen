<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pro-list.aspx.cs" Inherits="pro_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link rel="stylesheet" type="text/css" href="css/item-masonry.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 商品列表 -->

    <div  class="product-w">
	<div class="product-title"> <img src="images/prolist-title.png"></div>
	<div class="item-bar">
		<div class="item-title">
    		<img src="images/prolist-item.png">
    	</div>
    	<div class="item-menu">
    		<a href="pro-list.aspx">全部</a>
           <asp:Repeater ID="Repeatercategory" runat="server">
                <ItemTemplate><a href="pro-list.aspx?c_id=<%#Eval("c_id") %>"><%#Eval("c_name") %></a></ItemTemplate>
            </asp:Repeater>
    	</div>
	</div>
    
    <!--items-->
	<div class="albums_main">
		<div id="container" class="clearfix">
			<!--item-01-->
            <asp:Repeater ID="Repeaterpd" runat="server">
                <ItemTemplate >
                <div class="box co600 mosaic-block fade04">
            	        <a href="pro-info.aspx?p_id=<%#Eval("p_id") %>" class="mosaic-overlay"></a>
				        <div class="co600-img ">
					        <img src="upload/<%#Eval("pic1") %>?<%=DateTime.Now.ToString ("yyyyMMddhhmmss") %>">
				        </div>
                        <a href="pro-info.aspx?p_id=<%#Eval("p_id") %>">
                        <div class="co600-info">
                   	        <div class="co600-title"><%# Eval("productname") %></div>
					        <div class="co600-brief"><%# Eval("memo") %>...</div>
                        </div>   
                              <div style="font-size: 15px;line-height: 40px;line-height: 20px;text-align :left;color: #5f703b; "><%# Eval("Savetxt") %><%# Eval("Savetxt").ToString ()==""?"":"<br>" %></div>                      
                        <div class="co600-price">                            
                            <span style ="font-size: 13px;text-decoration: line-through;color: #55703b;"><%#unity.classlib .noHTML ( Eval("Pricing").ToString ()) %></span>　　<span style ="color: #FF3333;">$<%# Eval("price") %></span></div>
                        </a>
			        </div>
                </ItemTemplate>
            </asp:Repeater>           
		</div>
	</div>

	<div class="item-page">       
          <%=page_list %>
	</div>
</div>
<!--日誌-->
<div class="note-w isnote-w">
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
</div>

    <!--圖片淡入-->

<script type="text/javascript">  
	jQuery(function($){
		$('.fade04,.fade03').mosaic();
    });
</script> 
<!--item-->
<script type="text/javascript" src="js/jquery.masonry.min.js"></script>
<script>
  $(function(){    
    $('#container').masonry({
      itemSelector: '.box',
      columnWidth: 1,
      isAnimated: true
    });
    
  });
</script>

</asp:Content>

