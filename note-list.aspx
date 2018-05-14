<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="note-list.aspx.cs" Inherits="note_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 日誌列表 -->
<div  class="diary-w">
	<div class="diary-title"><img src="images/notelist-title.png"></div>
	<div class="albums_main">
		<div id="container" class="clearfix">
                    <div class="box co600 mosaic-block bar2">
                       	<a href="note-info.aspx?id=<%=d_id  %>" class="mosaic-overlay">
                        <div class="co600-info">
						        <% = subject %><br/>
						    <span>View More</span>
					    </div>
                    </a>
               <div class="co600-img mosaic-backdrop"><img src="upload/<%=pic%>"></div>
            </div> 
            <asp:Repeater ID="Repeaternote" runat="server">
                <ItemTemplate>
            <div class="box co270 mosaic-block bar3">
            	<a href="note-info.aspx?id=<%#Eval("d_id") %>" class="mosaic-overlay">
              <div class="co270-info">
						<%#Eval("subject") %><br/>
						<span>View More</span>
					</div>
                </a>
               <div class="co270-img mosaic-backdrop">
                <img src="upload/<%#Eval("pic")%>"></div>
			</div>
                </ItemTemplate>
            </asp:Repeater>
            
		</div>
	</div>      
	<div class="arrow-down"></div>
</div>
     <link rel="stylesheet" type="text/css" href="css/note-masonry.css" />
    <script type="text/javascript" src="js/jquery.masonry.min.js"></script>
 <!--圖片淡入-->
 <script type="text/javascript">  
	jQuery(function($){		
		$('.bar2,.bar3').mosaic({
			animation:'slide'		//fade or slide
		});		
    });
</script>
 <!--item-->

<script>
  $(function(){    
    $('#container').masonry({
      itemSelector: '.box',
      columnWidth:1,
      isAnimated: true
    });
    
  });
</script>



</asp:Content>

