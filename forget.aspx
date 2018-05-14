<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="forget.aspx.cs" Inherits="forget" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <script>
        function check() {
            var email = $("#<%=email.ClientID %>").val();
            if (email == "") {
                alert("請輸入Email");
                return false
            }


        }

    </script>
<div class="forget-w">
	<div class="forget-title"><img src="images/forget-title.png"></div>
    <asp:MultiView ID="MultiView1" runat="server">
    
        <asp:View ID="View1" runat="server"><div class="forget-box">
		<div class="forget-b-title">請在下方欄位輸入您的E-mail，我們將會寄發密碼至您的信箱。</div>
        <div class="forget-b-main">
        	<span>電子信箱</span><asp:TextBox ID="email" runat="server" placeholder="" cssclass="input-forget" ></asp:TextBox>
        
		</div>
        <div class="fback-btn"><a href="login.aspx">回登入頁</a></div>
        <div class="forget-btn"><asp:LinkButton ID="LinkButton1" runat="server" OnClientClick ="return check();" OnClick ="LinkButton1_Click" >取得密碼</asp:LinkButton></div>
	</div></asp:View>
        <asp:View ID="View2" runat="server">  <div class="send-box">已寄送至您的信箱，感謝。</div></asp:View>
    </asp:MultiView>
  
</div>

<!--圖片淡入-->
<script src="js/mosaic.1.0.1.js"></script>
<script type="text/javascript">  
	jQuery(function($){
		$('.fade01,.fade02,.fade03').mosaic();
    });
</script>  
</asp:Content>

