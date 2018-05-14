<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="modify.aspx.cs" Inherits="modify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

       <script>
        $(document).ready(function(){ 
     //     $("#birthday").datepicker();
      //    $("#birthday").datepicker("option", "dateFormat", "yy/mm/dd");
        
      });
    </script>
        <script>
        var countyid = "<%=countyid %>";
        var zip = "<%=zip%>";
        var cityid = "<%=cityid%>";
    
        $(document).ready(function () {        
            getCounty();
            getCity(countyid);
            $("#btnUpdate").click(function () {
                var username = $("#username").val();             
                var gender = $("#gender1").prop("checked") ? "男" : "女";
                countyid = $("#countyid").val();
                var phone = $("#phone").val();
                cityid = $("#cityid").val();
                var password = $("#password").val();
                var passconfirm = $("#passconfirm").val();
                var address = $("#address").val();
                var birthday = $("#birthday").val();
                if (cityid != "" && cityid != null) {
                    zip = cityid.split('-')[1];
                    cityid = cityid.split('-')[0];
                }                       
               if (username == "") {
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
                } else if ((cityid == "") || (countyid == "") || (address == "")) {
                    alert("請輸入地址");
                    $("#address").focus();
                } else {
                
                    $.post('member_handle.ashx', {
                        "p_ACTION": "Update",
                        "username": username,
                        "gender": gender,                 
                        "phone": phone,
                        "cityid": cityid,
                        "countyid": countyid,
                        "zip": zip,
                        "address": address,
                        "password": password,
                        "birthday": birthday,
                        "_": new Date().getTime()
                    }, function (data) {
                        if (data == "0") {
                            alert("error");
                        } else if (data == "1") {
                            alert("您的資料已經完成修改，感謝您的使用!");
                            var page = GetURLParameter("page");
                            if (page !== undefined) {
                                var s = base64_decode(page);
                                if (s.indexOf('?') != -1) s += "&=_" + new Date().getTime().toString();
                                else s = page + "?=_" + new Date().getTime().toString();
                                location.href = s;
                            }
                            else
                                location.href = 'index.aspx';
                        }

                    }
                    );
                }
            });
            $("#countyid").change(function () {             
                if ($(this).val() != "") {
                    getCity($(this).val());
                    if (cityid != "") {
                        $("#cityid").find("option[value='" + cityid  + '-' + zip + "']").prop("selected", true);
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
                    $('#countyid').find('option[value="' + countyid + '"]').prop("selected", true);
                }
            });
        }

 
        function init() {
       
            $('#countyid').find('option[value="' + countyid + '"]').prop("selected", true);
            $('#cityid').find('option[value="' + cityid + "-" + zip + '"]').prop("selected", true);
           
            alert($("#cityid").val());
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="pinfo-w">
	<div class="pinfo-title"><img src="images/modify-title.png"></div>
    <div class="pinfo-box">
    	<div class="pinfo-main">
        	<div class="pinfo-m-title">修改基本資訊</div>
            <div class="pinfo-m-info">
            	<div class="pinfo-m-row">
                	<span>電子信箱*</span>   <%=email  %>                 
				</div>
            	<div class="pinfo-m-row">
                	<span>訂購姓名*</span>
                    <input name="username" type="text" id="username" placeholder="" class="input-pinfo"   value ="<%=username%>"/>
                    <input type="radio" class="radio-gender" name="gender" id="gender1" value="radio" <%=(gender=="男")? "checked":""  %>   "/>先生
                    <input type="radio" class="radio-gender" name="gender" id="gender2" value="radio"  <%=(gender=="女")? "checked":""  %> />小姐
				</div>
                <div class="pinfo-m-row">
            		<span>新密碼設定*</span>
                    <input name="password" type="password" id="password" placeholder="" class="input-pinfo"  value ="<%=password%>" />
                    <h1>請輸入英數6-16字元，此為往後登入密碼。</h1>
				</div>
                <div class="pinfo-m-row">
            		<span><h2>確認新密碼*</h2></span>
                    <input name="passconfirm" type="password" id="passconfirm" placeholder="" class="input-pinfo"  value ="<%=password%>" />
				</div>
                <div class="pinfo-m-row">
            		<span>手機號碼*</span>
                    <input name="phone" type="text" id="phone" placeholder=""  value ="<%=phone %>" class="input-pinfo" />
				</div>
   <div class="pinfo-m-row">
            		<span>生日</span>
                    <input name="birthday" type="date"  id="birthday" placeholder=""  value ="<%=birthday %>" class="input-pinfo" />
				</div>
                <div class="pinfo-m-row">
            		<span>聯絡地址* </span>
                    <input name="zip" type="text" id="zip" placeholder="zip" class="input-postal"   value ="<%=zip %>"/>
                    <select class="select-city" name="countyid" id="countyid">
                    
					</select>
                    <select class="select-city" id="cityid" name="cityid">  
                    <option>鄉鎮市區</option>                 
					</select>
                    <input name="address" type="text" id="address" placeholder="" class="input-add" value ="<%=address %>" />
				</div>
			</div>
        </div>
    </div>

    <div class="commo-w">
		<div class="page-box">
        	<div class="prev-btn" onclick ="init();"><a href="#">取消修改</a></div>
         	<div class="next-btn" id="btnUpdate"><a href="#">確認修改</a></div>
		</div>
	</div>
    
</div>

</asp:Content>

