<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="service.aspx.cs" Inherits="servive" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 關於我們 -->
<div  class="contact-w">
	<div class="contact-w-title"><img src="images/service-title.png"></div>
	<div class="contact-case" id="attentio">
    	<img src="images/service-banner.jpg">
    	<%=msg1 %>
	</div>
</div>


<!--送貨注意-->
<div class="delivery-w">
		<%=msg2 %>
</div>
</asp:Content>

