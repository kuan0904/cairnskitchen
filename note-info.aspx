<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="note-info.aspx.cs" Inherits="note_info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="og:description" content="<%=unity.classlib.RemoveHTMLTag(contents[0] ).Replace ("\r\n","").Replace ("\r","").Replace ("\n","").Replace ("&nbsp;","") %>" />
<meta property="og:title" content="<%=subject[0] %>"/>
<meta property="og:image" content="http://www.cairnskitchen.com/upload/<%=pic[0] %>"/>
<meta property="og:type" content="website"/>
<meta property="og:url" content="<%=Request.Url.AbsoluteUri %>"/>
<meta property="og:site_name" content="::凱恩斯廚房::cairns" />
<meta property="og:type" content="website"/>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 日誌內容 -->
<div  class="diary-w">
	<div class="diary-w-ctrl">
		<div class="diary-date"><%=post_day[0]%> 發表</div>
        <div class="back-btn"><a href="note-list.aspx"></a></div>
           <a href="javascript: void(window.open('http://www.facebook.com/share.php?u='.concat(encodeURIComponent(location.href)), '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600'));" class="dyshare-fb"></a>
    </div>
    <div class="diary-case diary-case-left">
		<h1><%=subject[0] %> </h1><br>
		<img src="upload/<%=pic[0] %>"><br>
		<%=contents[0]  %>
    </div>
	<div class="diary-w-ctrl">
		<div class="diary-date"><%=post_day[0] %> 發表</div>
        <div class="back-btn"><a href="note-list.aspx"></a></div>
        <a href="javascript: void(window.open('http://www.facebook.com/share.php?u='.concat(encodeURIComponent(location.href)), '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600'));" class="dyshare-fb"></a>
    </div>
</div>

<!--日誌-->
<div class="note-w isnote-w">
	<div class="note-w-title"><img src="images/idx-title-cook.png"></div>
    <div class="note-box">
   	  <div class="n-item-box mosaic-block fade03">
        	<a href="note-info.aspx?id=<%=d_id [1]%>" class="mosaic-overlay">&nbsp;</a>
        	<div class="mosaic-backdrop"><img src="upload/<%=pic[1] %>" width="240" height ="180"></div>
            <div class="n-info">
            	<div class="n-info-title"><%=subject[1] %></div>
            	View More
			</div>
      </div>
        
    <div class="n-item-box mosaic-block fade03">
        	<a href="note-info.aspx?id=<%=d_id [2]%>" class="mosaic-overlay">&nbsp;</a>
        	<div class="mosaic-backdrop"><img src="upload/<%=pic[2] %>" width="240" height ="180"></div>
            <div class="n-info">
            	<div class="n-info-title"><%=subject[2] %></div>
            	View More
			</div>
      </div>
        <div class="n-item-box mosaic-block fade03">
        	<a href="note-info.aspx?id=<%=d_id [3]%>" class="mosaic-overlay">&nbsp;</a>
        	<div class="mosaic-backdrop"><img src="upload/<%=pic[3] %>" width="240" height ="180"></div>
            <div class="n-info">
            	<div class="n-info-title"><%=subject[3] %></div>
            	View More
			</div>
      </div>
        
   	  
    </div>
</div>




</asp:Content>

