<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="completed.aspx.cs" Inherits="completed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="cplt-w">
	<div class="cplt-title"><img src="images/conpleted-title.png"></div>
<%=msg %>
</div>

</asp:Content>

