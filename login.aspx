<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <script>
        function check() {
            var email = $("#<%=email.ClientID %>").val();
            var password = $("#<%=password.ClientID %>").val();
            if (email == "") {
                alert("請輸入Email");
                return false
            }

            if (password == "") {
                alert("請輸入Email");
                return false
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- 登入 -->
<div class="login-w">
	<div class="login-title"><img src="images/login-title.png"></div>
    <div class="login-box">
		<div class="login-main">
        	<div class="lgm-title">Login登入</div>
            <div class="lgm-info">
            	<div class="lgm-row">
                	電子信箱
                    <div class="lgm-input">
                        <asp:TextBox ID="email" runat="server"  cssclass="input-login"></asp:TextBox></div>
				</div>
            	<div class="lgm-row">
                	密　　碼
                    <div class="lgm-input"><asp:TextBox ID="password" runat="server"  cssclass="input-login" TextMode="Password"></asp:TextBox></div>
				</div>
                <div class="lgm-row">
                	<div class="lgm-remember"><input name="remeber" type="checkbox" value="Y" class="checkbox-login" <%= (Request.Cookies["memberdata"] !=null) ? "checked =\"checked\"":""   %> />                      
                    	記住我的帳密
					</div>
                	<div class="lgm-forget">
                        <a href="forget.aspx">忘記密碼</a></div>
				</div>
            </div>
            <div class="clear"></div>
            <div class="lgm-btn"><asp:LinkButton ID="LinkButton1" runat="server" OnClientClick ="return check();"   OnClick="LinkButton1_Click">登　　入</asp:LinkButton></div>
		</div>
        
		<div class="login-main">
        	<div class="lgm-title">初次購物</div>
            <div class="lgm-info">
            	<div class="lgm-row-02">
                	無須先加入會員<br>
                    即可訂購商品
				</div>
                <div class="lgm-row-03">
                	如有購物記錄，可直接登入會員即可。
				</div>
            </div>
            <div class="clear"></div>
            <div class="lgm-btn"><a href="paymode.aspx">前往結帳</a></div>
              
		</div><div class="clear"></div>
	</div>
</div>

<!--圖片淡入-->
<script src="js/mosaic.1.0.1.js"></script>
<script type="text/javascript">  
	jQuery(function($){
		$('.fade01,.fade02,.fade03').mosaic();
    });
</script>  

</asp:Content>

