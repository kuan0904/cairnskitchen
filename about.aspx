<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="about.aspx.cs" Inherits="about" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 關於我們 -->
<div  class="about-w">
	<div class="about-img"><img src="images/about-banner.jpg"></div>
	<div class="about-w-title"><img src="images/about-title.png"></div>
	<div class="about-case">
    	<%=msg %>      
	</div>
    <div class="arrow-down"></div>
</div>

   

</asp:Content>

