<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="join.aspx.cs" Inherits="joinus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script>
        var countyid = "";
        var zip = "";
        var cityid = "";

        $(document).ready(function () {        
                 getCounty();                                               
                 $("#btnUpdate").click(function () {
                    var username = $("#username").val();            
                    var email=$("#email").val();
                    var gender = $("#gender1").prop("checked") ? "男" : "女";
                    var countyid = $("#countyid").val();
                    var phone = $("#phone").val();
                    var cityid = $("#cityid").val();
                    var password = $("#password").val();
                    var birthday = $("#birthday").val();
                    var passconfirm = $("#passconfirm").val();
                    var address = $("#address").val();
                    var emaiconfirm = $("#emaiconfirm").val();
                    if (cityid != "" && cityid != null ) {                       
                        zip = cityid.split('-')[1];
                        cityid = cityid.split('-')[0];
                    }
                
                    if (email == "") {
                        alert("請輸入Email");
                        $("#email").focus();  }
                     else if (!validEmail(email)) {
                        alert("EMail格式錯誤");
                        $("#email").focus();
                    }
                     else if (email != emaiconfirm) {
                         alert("EMail與確認EMail不同");
                         $("#emailconfirm").focus();
                         return false;
                     }
                    else if (username == "") {
                        alert("請輸入姓名");
                        $("#username").focus();                 
                  
                    } else if (password == "") {
                        alert("請輸入密碼");
                        $("#password").focus();
                    } else if (password.length < 6 || password.length > 16) {
                        alert("請輸入英數6-16字元");
                        $("#password").focus();
                    }
                    else if (password != passconfirm) {
                        alert("密碼與確認密碼不同");
                        $("#passconfirm").focus();
                    } else if ($("#gender1").prop("checked") == false && $("#gender2").prop("checked") == false) {
                        alert("請選擇性別");
                        $("#gender1").focus();
                    } else if (phone == "") {
                        alert("請輸入行動電話");
                        $("#phone").focus();
                    } else if ((cityid  == "") || (countyid == "") || (address == "")) {
                        alert("請輸入地址");
                        $("#address").focus();
                    } else {                  
                        $.post('member_handle.ashx', {
                            "p_ACTION":"Register",
                            "username": username,
                            "gender": gender,
                            "email": email,
                            "phone": phone,
                            "cityid": cityid,
                            "countyid": countyid,
                            "zip": zip,
                            "address": address,
                            "password": password,
                            "birthday":birthday,
                             "_": new Date().getTime()
                        }, function (data) {
                         
                            if (data == "-1") {
                                alert("EMAIL已被註冊");
                            } 
                            else if (data == "1") {
                                alert("加入成功");
                                var page = GetURLParameter("page");
                                if (page !== undefined) {
                                    var s = base64_decode(page);
                                    if (s.indexOf('?') != -1) s += "&=_" + new Date().getTime().toString();
                                    else s = page + "?=_" + new Date().getTime().toString();
                                    location.href = s;}
                                else
                                    location.href='index.aspx';
                                }

                            }
                        );                       
                    }
                });         
                $("#countyid").change(function () {
                   
                    if ($(this).val() != "") {                      
                        getCity($(this).val());
                        if (cityid != "") {
                            $("#cityid").find("option[value='" + cityid + '-' + zip + "']").prop("selected", true);
                            $("#cityid").trigger("change");
                        }
                    } else {
                        $("#cityid").find("option").remove();
                    }
                });
                $("#cityid").change(function () {                 
                    if (($(this).val() != "") && ($(this).val() != null)) {
                        var zip = $(this).val().split('-')[1];                       
                        $("#zip").val(zip);                       
                    } else {                     
                        $("#zip").val('');
                    }
                });
         });

  
        function getCity(p_COUNTYID) {     
            if (p_COUNTYID != null) {
                $.post('city.ashx', { "p_COUNTYID": p_COUNTYID, "_": new Date().getTime() }, function (data) {
                    if (data != "") {
                        $("#cityid").find("option").remove();
                        $("#cityid").html(data);
                    }
                });
            }
        }
    
        function getCounty() {
            $.post('county.ashx', { "_": new Date().getTime() }, function (data) {
                if (data != "") {
                    $("#countyid").find("option").remove();
                    $("#countyid").html(data);
                }
            });
        }

 

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="pinfo-w">
	<div class="pinfo-title"><img src="images/join-title.png"></div>
    <div class="pinfo-box">
    	<div class="pinfo-main">
        	<div class="pinfo-m-title">會員資訊</div>
            <div class="pinfo-m-info">
            	<div class="pinfo-m-row">
                	<span>會員姓名*</span>
                    <input name="username" type="text" id="username" placeholder="" class="input-pinfo" />
                    <input type="radio" class="radio-gender" name="gender" id="gender1" value="radio" />先生
                    <input type="radio" class="radio-gender" name="gender" id="gender2" value="radio" />小姐
				</div>

            	<div class="pinfo-m-row">
                	<span>電子信箱*</span>    <input name="email" type="text" id="email" placeholder="" class="input-pinfo" />     
                      <h1>電子信箱將成為您的會員帳號。</h1>            
				</div>
                     <div class="pinfo-m-row">
            		<span><h2>信箱確認*</h2></span>
                     <input name="emailconfirm" type="text" id="emaiconfirm" placeholder="" class="input-pinfo" value ="" />
				</div>
                <div class="pinfo-m-row">
            		<span>密碼設定*</span>
                    <input name="password" type="password" id="password" placeholder="" class="input-pinfo" />
                    <h1>請輸入英數6-16字元，此為往後登入密碼。</h1>
				</div>
                <div class="pinfo-m-row">
            		<span><h2>確認密碼*</h2></span>
                    <input name="passconfirm" type="password" id="passconfirm" placeholder="" class="input-pinfo" />
				</div>
                <div class="pinfo-m-row">
            		<span>手機號碼*</span>
                    <input name="phone" type="text" id="phone" placeholder="" class="input-pinfo" />
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
            		<span>聯絡地址* </span>
                    <input name="zip" type="text" id="zip" placeholder="zip" class="input-postal" />
                    <select class="select-city" name="countyid" id="countyid">
                    
					</select>
                    <select class="select-city" id="cityid" name="cityid">      
                    <option>鄉鎮市區</option>       
					</select>
                    <input name="address" type="text" id="address" placeholder="" class="input-add" />
				</div>
			</div>
        </div>
    </div>

    <div class="commo-w">
		<div class="page-box">
        	<div class="prev-btn"><a href="personal.aspx">取消加入</a></div>
         	<div class="next-btn" id="btnUpdate"><a href="javascript:void(0);">確認加入</a></div>
		</div>
	</div>
    
</div>

</asp:Content>

