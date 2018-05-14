<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="information.aspx.cs" Inherits="information" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
            <script>
       var countyid = "<%=countyid %>";
        var zip = "<%=zip%>";
        var cityid = "<%=cityid%>";
    

        $(document).ready(function () {        
            getCounty();
            getCity(countyid, '#cityid');
            getCity(countyid, '#Rcityid');
                $("#countyid").change(function () {                   
                    if ($(this).val() != "") {                      
                        getCity($(this).val(), '#cityid');
                        getCity($(this).val(), '#Rcityid');
                        if (cityid != "") {
                            $("#cityid").find("option[value='" + cityid + '-' + zip + "']").prop("selected", true);
                            $("#cityid").trigger("change");
                        }
                    } else {
                        $("#cityid").find("option").remove();
                    }
                });
                $("#Rcountyid").change(function () {
                    if ($(this).val() != "") {
                        getCity($(this).val(), '#Rcityid');
                        if (cityid != "") {
                            $("#Rcityid").find("option[value='" + cityid + '-' + zip + "']").prop("selected", true);
                            $("#Rcityid").trigger("change");
                        }
                    } else {
                        $("#Rcityid").find("option").remove();
                    }
                });
                $("#cityid").change(function () {                 
                    if (($(this).val() != "") && ($(this).val() != null)) {
                         zip = $(this).val().split('-')[1];                       
                        $("#zip").val(zip);                       
                    } else {                     
                        $("#zip").val('');
                    }
                });
                $("#Rcityid").change(function () {                    
                    if (($(this).val() != "") && ($(this).val() != null)) {
                         zip = $(this).val().split('-')[1];
                        $("#Rzip").val(zip);
                    } else {
                        $("#Rzip").val('');
                    }
                });

                $(".next-btn").on("click", function(event){
                    event.preventDefault();
                    checkdata();
                });
         });
        function same() {
            if ($("#thesame").prop("checked")) {
                var x1 = $("#username").val();
                var x2 = $("#phone").val();                    
                var x7 = $("#gender1").prop("checked") ? "男" : "女";
                zip = $("#zip").val();          
       
                $("#Rcountyid").find("option[value='" + $("#countyid").val() + "']").prop("selected", true);
                $("#Rcityid").find("option[value='" + $("#cityid").val() + "']").prop("selected", true);
                $("#Rcityid").trigger("change");
                $("#Raddress").val($("#address").val());
                $("#Rusername").val(x1);
                $("#Rphone").val(x2);
                if ($("#gender1").prop("checked") == true) $("#Rgender1").attr("checked", true);
                if ($("#gender2").prop("checked") == true) $("#Rgender2").attr("checked", true);
                $("#Rzip").val(zip);
            } else {
                $("#Rzip").val("");
                $("#Rphone").val("");
                $("#Rusername").val("");
                $("#Raddress").val("");            
            }
        }

  
        function getCity(p_COUNTYID, obj) {
            if (p_COUNTYID != null) {
                $.post('city.ashx', { "p_COUNTYID": p_COUNTYID, "_": new Date().getTime() }, function (data) {
                    if (data != "") {
                        $(obj).find("option").remove();
                        $(obj).html(data);
                        $('#cityid').find('option[value="' + cityid + "-" + zip + '"]').prop("selected", true);
                    }
                });
            }
        }
    
        function getCounty() {
            $.post('county.ashx', { "_": new Date().getTime() }, function (data) {
                if (data != "") {
                    $("#countyid").find("option").remove();
                    $("#countyid").html(data);
                    $("#Rcountyid").find("option").remove();
                    $("#Rcountyid").html(data);
                    $('#countyid').find('option[value="' + countyid + '"]').prop("selected", true);
                }
            });
        }
                

 
        function checkdata() {
            var username = $("#username").val();          
            var email = $("#email").val();
            var gender = $("#gender1").prop("checked") ? "男" : "女";         
            var countyid = $("#countyid").val();        
            var phone = $("#phone").val();
            var birthday = $("#birthday").val();
            var cityid = $("#cityid").val();
            var zip = $("#zip").val();         
            var address = $("#address").val();
            var birthday = $("#birthday").val();
            var Rusername = $("#Rusername").val();
            var Rgender = $("#Rgender1").prop("checked") ? "男" : "女";
            var Rcountyid = $("#Rcountyid").val();
            var Rcityid = $("#Rcityid").val();
            var Rzip = $("#Rzip").val();
            var Raddress = $("#Raddress").val();
            var Rphone = $("#Rphone").val();
            var password = $("#password").val();
            var passconfirm = $("#passconfirm").val();         
            var emaiconfirm = $("#emaiconfirm").val();
            var invoice = $("#invoice2").prop("checked") ? "2" : "3";
            var companyno = $("#companyno").val();
            var title = $("#title").val();
            if (cityid != "" && cityid != null) {
                zip = cityid.split('-')[1];
                cityid = cityid.split('-')[0];
            }

            if (email == "") {
                alert("請輸入Email");
                $("#email").focus();
                return false;
            }
            else if (!validEmail(email)) {
                alert("EMail格式錯誤");
                $("#email").focus();
                return false;
            }
            else if (email != emaiconfirm) {
                alert("EMail與確認EMail不同");
                $("#emailconfirm").focus();
                return false;
            }
             else if (password == "") {
                alert("請輸入密碼");
                $("#password").focus();
            } else if (password.length < 6 || password.length > 16) {
                alert("請輸入英數6-16字元");
                $("#password").focus();
            }
            else if (password != passconfirm) {
                alert("密碼與確認密碼不同");
                $("#passconfirm").focus();
            } 
            else if (username == "") {
                alert("請輸入姓名");
                $("#username").focus();
                return false;
            } else if ($("#gender1").prop("checked") == false && $("#gender2").prop("checked") == false) {
                alert("請選擇性別");
                $("#gender1").focus();
                return false;
            } else if (phone == "") {
                alert("請輸入行動電話");
                $("#phone").focus();
                return false;
            } else if ((cityid == "") || (countyid == "") || (address == "")) {
                alert("請輸入地址");
                $("#address").focus();
                return false;
            }
            else if (Rusername == "") {
                alert("請輸入收件姓名");
                $("#Rusername").focus();
                return false;
            }
            else if ($("#Rgender1").prop("checked") == false && $("#Rgender2").prop("checked") == false) {
                alert("請選擇收件人性別");
                $("#Rgender1").focus();
                return false;
            } else if (Rphone == "") {
                alert("請輸入收件人行動電話");
                $("#Rphone").focus();
                return false;
            } else if ((Rcityid == "") || (Rcountyid == "") || (Raddress == "")) {
                alert("請輸入收件人地址");
                $("#Raddress").focus();
                return false;
            }
                else if ($("#invoice2").prop("checked") == false && $("#invoice3").prop("checked") == false) {
                    alert('請選擇發票方式');
                    $("#invoice2").focus();
                    return false;
                }
                else if ($("#invoice3").prop("checked") ==true  && (title == '' || companyno =='' )) {
                    alert('請填統編及公司抬頭');
                    $("#invoice3").focus();
                    return false;
                }
            else {
              
                    $.post('add_order.ashx', {
                        "p_ACTION": "add",
                        "email": email,
                        "password": password,
                        "username": username,
                        "countyid": countyid,
                        "cityid": cityid,
                        "zip": zip,
                        "address": address,
                        "phone": phone ,
                        "gender": gender,
                        "birthday":birthday,
                        "Rusername":Rusername ,
                        "Rcountyid": Rcountyid,
                        "Rcityid": Rcityid,
                        "Rzip": Rzip,
                        "Raddress": Raddress,
                        "Rphone": Rphone,
                        "Rgender": Rgender,
                        "invoice": invoice,
                        "companyno": companyno,
                        "title":title,
                        "_": new Date().getTime()
                    }, function (data) {                    
                        if (data == "1") {
                            location.href = 'confirm.aspx';
                        }
                        else {
                       
                            alert(status);
                            alert('資料有誤')
                           location.href = 'pro-list.aspx';
                        }
                    });
                    return false;
                   
            }
            
   }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="pinfo-w">
	<div class="pinfo-title"><img src="images/information-title.png"></div>
    <div class="pinfo-box">
    	<div class="pinfo-main">
        	<div class="pinfo-m-title">訂購人資訊</div>
            <div class="pinfo-m-info">
            	<div class="pinfo-m-row">
                	<span>訂購姓名*</span>
                     <input name="username" type="text" id="username" placeholder="" class="input-pinfo" value ="<%=username%>" />
                     <input type="radio" class="radio-gender" name="gender" id="gender1" value="radio"  <%=(gender=="男")? "checked":""  %> />先生
                    <input type="radio" class="radio-gender" name="gender" id="gender2" value="radio"  <%=(gender=="女")? "checked":""  %>/>小姐
				</div>
            	
                <asp:MultiView ID="MultiView1" runat="server">

                    <asp:View ID="View1" runat="server">
                        <script >
                            $(document).ready(function () {
                                $("#email").change(function () {
                                    email = $("#email").val();
                                    $.post('member_handle.ashx', {
                                        "p_ACTION": "Checkemail",
                                        "email": email,
                                        "_": new Date().getTime()
                                    }, function (data) {
                                        if (data == "-1") {
                                            alert("EMAIL已被註冊");
                                            $("#email").val('');
                                            $("#email").focus();
                                            return false;
                                        }
                                     });
                                });
                            });


                                </script>
                        <div class="pinfo-m-row">
                	<span>電子信箱*</span>
                   <input name="email" type="text" id="email" placeholder="" class="input-pinfo"  value =""/>   
                             <h1>電子信箱將成為您的會員帳號。</h1>                                  
				</div>
                    <div class="pinfo-m-row">
            		<span><h2>信箱確認*</h2></span>
                     <input name="emailconfirm" type="text" id="emaiconfirm" placeholder="" class="input-pinfo"  value =""/>
				</div>
                            <div class="pinfo-m-row">
            		<span>生日</span>
                                       <input name="birthday" type="text"  id="birthday"   
                          value ="" class="input-pinfo"
                    placeholder="yyyy/mm/dd"
    onkeyup="
        var v = this.value;
        if (v.match(/^\d{4}$/) !== null) {
            this.value = v + '/';
        } else if (v.match(/^\d{4}\/\d{2}$/) !== null) {
            this.value = v + '/';
        }"
    maxlength="10"
                         />                   

				</div>
                <div class="pinfo-m-row">
            		<span>密碼設定*</span>
                    <input name="password" type="password" id="password" placeholder="" class="input-pinfo" value ="" />
                    <h1>請輸入英數6-16字元，此為往後登入密碼。</h1>
				</div>
                <div class="pinfo-m-row">
            		<span><h2>確認新密碼*</h2></span>
                    <input name="passconfirm" type="password" id="passconfirm" placeholder="" class="input-pinfo" />
				</div>
                    </asp:View>
                    <asp:View ID="View2" runat="server">
                        
                              <div class="pinfo-m-row">
                	            <span>電子信箱*</span>
                               <input name="email" type="text" id="email" placeholder="" class="input-pinfo"  value ="<%=email  %>"  readonly />       
                                                
				            </div>
                         <input name="emailconfirm" type="hidden" id="emaiconfirm"  value ="<%=email  %>"/>
                        <input name="password" type="hidden" id="password"   value ="<%=password  %>" />
                        <input name="passconfirm" type="hidden" id="passconfirm"   value ="<%=password  %>"/>
                    </asp:View>
                </asp:MultiView>

                <div class="pinfo-m-row">
            		<span>手機號碼*</span>
                       <input name="phone" type="text" id="phone" placeholder="" class="input-pinfo"   value ="<%=phone%>"  />
				</div>
                <div class="pinfo-m-row">
            		<span>聯絡地址* </span>
                    <input name="zip" type="text" id="zip" placeholder="zip" class="input-postal"  value ="<%=zip%>"  />
                    <select class="select-city" name="countyid" id="countyid">                    
					</select>
                    <select class="select-city" id="cityid" name="cityid">  
                        	<option>鄉鎮市區</option>                 
					</select>
                    <input name="address" type="text" id="address" placeholder="" class="input-add"   value ="<%=address%>" />
				</div>
			</div>
        </div>
        <div class="pinfo-main">
        	<div class="pinfo-m-title">
            	收件人資訊
				<div class="title-same">
                	<input name="thesame" id="thesame" type="checkbox" value="" class="checkbox-login" onclick ="same();">
                	同訂購人資訊
				</div>
			</div>
            <div class="pinfo-m-info">
            	<div class="pinfo-m-row">
                	<span>收件姓名*</span>
                  <input name="Rusername" type="text" id="Rusername" placeholder="" class="input-pinfo" />
                     <input type="radio" class="radio-gender" name="Rgender" id="Rgender1" value="radio" />先生
                    <input type="radio" class="radio-gender" name="Rgender" id="Rgender2" value="radio" />小姐
				</div>
                <div class="pinfo-m-row">
            		<span>手機號碼*</span>
                            <input name="Rphone" type="text" id="Rphone" placeholder="" class="input-pinfo" />
				</div>
                <div class="pinfo-m-row">
            		<span>聯絡地址* </span>
                    <input name="Rzip" type="text" id="Rzip" placeholder="zip"  class="input-postal" />
                    <select class="select-city" name="Rcountyid" id="Rcountyid">                    
					</select>
                    <select class="select-city" id="Rcityid" name="Rcityid">
                        	<option>鄉鎮市區</option>                   
					</select>
                    <input name="Raddress" type="text" id="Raddress" placeholder="" class="input-add" />
				</div>
			</div>
        </div>
        <div class="pinfo-main">
        	<div class="pinfo-m-title">發票資訊</div>
            <div class="pinfo-m-info">
				<input type="radio" class="radio-invoice" name="invoice" id="invoice2" value="2" />二聯式發票
                <input type="radio" class="radio-invoice02" name="invoice" id="invoice3" value="3" />三聯式發票<br />
                 統一編號:<input name="companyno" type="text" id="companyno" placeholder=""  class="input-pinfo" />
                發票抬頭:<input name="title" type="text" id="title" placeholder=""  class="input-pinfo" />
			</div>
        </div>
    </div>

    <div class="commo-w">
		<div class="page-box">
        	<div class="prev-btn"><a href="paymode.aspx">回付款方式</a></div>
         	<div class="next-btn" ><a href="#">下一步</a> </div>
		</div>
	</div>
    
</div>
</asp:Content>

