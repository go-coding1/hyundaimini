<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file = "member_header.jsp"  %>
<!-- //headerWrap -->		


<script type="text/javascript">
$(document).ready(function(){
    var userInputId = getCookie("userInputId");//저장된 쿠기값 가져오기
    $("#loginForm").find("[id='j_username']").eq(0).val(userInputId); 
    
    if($("#loginForm").find("[id='j_username']").eq(0).val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩
                                           // 아이디 저장하기 체크되어있을 시,
        $("#id_save").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $('#id_save').change(function(){ // 체크박스에 변화가 발생시
        if($("#id_save").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("#loginForm").find("[id='j_username']").eq(0).val();
            //layerAlert(userInputId);
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
            //console.log(userInputId);
        }else{ // ID 저장하기 체크 해제 시,
        	//layerAlert("쿠키 제거");
            deleteCookie("userInputId");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#loginForm").find("[id='j_username']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#id_save").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("#loginForm").find("[id='j_username']").eq(0).val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });
});
 
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
</script>





<script type="text/javascript">
//<![CDATA[
var tempData = "";
$(document).ready(function(){
	var egiftParam = "";
    
    if(egiftParam != "") {
    	$("#eg_block").addClass("close1812");
    	$("#eg_block").find("a").removeAttr("onclick");
    }
    
    // #1130 로그인 입력창 탭위치변경
    var loginLayer = document.getElementById("loginLayer");
    var loginError = "";
    isShow('h');
//     if( loginError == "true" && loginLayer.value == "E"){
//         isShow('');
//     //isShow('');
//     } else {
//         isShow('h');
//     }

    
    var ssoUrl = "https://sso.h-point.co.kr:29865" + "/co/setSsoReqJSONP.hd";
    gfnSsoReqAjax(ssoUrl, ssoTokenSuc);
     
    

	//로그인 오류횟수 관련
	if("" != "") {
		if("" == "true") {
			layerAlert("잘못된 비밀번호를 5회 입력하셨습니다.<br/>비밀번호가 보호조치되었으니, 고객센터로 문의하시길 바랍니다.");
		} else {
			
				if(Number("") == 3 || Number("") == 4 || Number("") == 5) {
					layerAlert("잘못된 비밀번호를 {0}회 입력하셨습니다.<br/>5회 이상 입력시 로그인은 제한됩니다.");	
				}
			
		}
	}
    
    $("#login_btn").click(function(){
        var id = $("#loginForm").find("[id='j_username']").eq(0).val();
        var pw = $("#loginForm").find("[id='j_password']").eq(0).val();
        
        document.getElementById("loginLayer").value = "E";

        if(false){
            if(id==""){
                layerAlert("이메일을 입력하셔야 합니다.");
                return;
            }
            
            if(pw==""){
                layerAlert("Please enter your password");
                return;
            }
        }
        
        if(true){
	        if(id==""){
	            layerAlert("아이디를 입력해 주십시요."); 
	            return;
	        }
	        
	        if(pw==""){
	            layerAlert("비밀번호를 입력해 주십시요."); 
	            return;
	        }
        }
        
        $.ajax ({
        	type : "POST" ,
        	url :  "/member/loginaction",
        	data : {
        		"mid" : id, 
        		"mpassword" : pw
        		},
        	success:function(result) {
        		console.log(result);
        		if(result == "fail"){
        			layerAlert("아이디 또는 비밀번호를 다시 확인 후 시도해 주세요."); 
        			/*
        			console.log(data);
        			$("#hpErrMsg").text("안녕하세요!");
                    //$("#inputId").val(id);
                    $("#loginForm").submit();
                    */
        		}
        		else {
        			console.log("로그인 성공");
        			//location.href = document.referrer;
        			location.href = "/";
        		}
        	},
        	error:function(e){
                alert("다시 시도해 주세요.");
        		//location.href="/ko/member/login?error=true";
            }
        	
        	});
        
        // 로그인 로직 수행 (황명하)
        /*
        $.ajax({
            type:"POST",
            url:"/ko/member/isduplglobaluid",
            data: {"uid":id,"upw":pw,"CSRFToken":"1ca503cd-f035-4118-8b48-9355905e6a1d"},
            success:function(data){
                if(data.result == "exist"){
                    //GA_Event('로그인', '로그인', '로그인');
                    $("#inputId").val(id);
                    $("#loginForm").submit();
                }else if(data.result == "transMember"){
                    var la = new layerAlert("통합회원은 H.Point 통합회원 아이디로 로그인 해주세요.");
                    la.confirmAction = function(){//확인 버튼 클릭시 추가 호출 펑션
                    };
                }else if(data.result == "unionMember"){
                    hpLogin(id, pw);
//                     layerAlert("통합회원은 H.Point 통합회원으로<br/>로그인 해주세요.");
//                     isShow('h');
                }else if(data.result == "dormancyMember"){
                    var msg = "회원님은 현재 1년 이상<br/>장기 미접속으로 확인되며<br/>회원님의 정보는 안전하게 분리되어 있습니다.<br/>휴면 상태를 해제 하시겠습니까?";
                    layerConfirm(msg,"휴면 해제","취소");
                    
                    
                    $("#clsBtn").on("click",function(){
                        //
                    });
                    
                    $("#cfBtn").on("click",function(){
                        $.ajax({
                            type:"GET",
                            url:"/ko/member/dormancyMemberCancel?uid="+data.tempUid,
                            async:false,
                            success:function(data){
                                if(data == true){
                                    layerAlert("회원 정보가 안전하게 복원되었습니다.<br/>다시 로그인 해주세요.");
                                }else{
                                    layerAlert("로그인을 다시 시도해 주세요.");
                                }
                            },
                            error:function(e){
                                var hs_id = "";
                                if(id != hs_id) {
                                    location.href="/ko/member/login?error=true&id="+id;                        
                                }else {
                                    location.href="/ko/member/login?error=true";
                                    
                                }
//                                 location.href="/ko/member/login?error=true";
                            }
                        });
                    });
                }else{
                    if(true){
                        hpLogin(id, pw);
                    }else{
                        var hs_id = "";
                        if(id != hs_id) {
                            location.href="/ko/member/login?error=true&id="+id;                        
                        }else {
                            location.href="/ko/member/login?error=true";
                            
                        } 
                    }
                }
            },
            error:function(e){
                location.href="/ko/member/login?error=true";
            }
        });
        */
    });

    //로그인 로직 끝 (황명하)
    
    //enter key event 추가
    $("#loginForm").find("#j_password").eq(0).keypress(function( event ) {    
        if ( event.which == 13 ) {
            event.preventDefault();
            $("#login_btn").click();
            $(this).blur();
        }
    });
    
    $("#hpPw").keypress(function( event ) {
        if ( event.which == 13 ) {
            event.preventDefault();
            $("#hplogin").click();
            $(this).blur();
        }
    });
    
    $("#otpNo").keypress(function( event ) {
        if ( event.which == 13 ) {
            event.preventDefault();
            $("#otplogin").click();
            $(this).blur();
        }
    });
    
     
    
    //통합맴버십 회원가입 요청
    
    //통합맴버십 회원가입 요청    
    $("#hpoinJoinBtn2").click(function(){
        hpoinJoin();
    });
    
    function hpLogin(id, pw){
//         var id = $("#hpId").val();
//         var pw = $("#hpPw").val();
        
//         document.getElementById("loginLayer").value = "H";
        
        pw = pw.replace(/#/g,"[({})]");
        pw = pw.replace(/>/g,"{[()]}");
        pw = pw.replace(/</g,"({[]})");
        $.ajax({
            type:"POST",
            url:"/ko/member/isUnionMember",
            data: {"uid":id,"upw":pw,"CSRFToken":"1ca503cd-f035-4118-8b48-9355905e6a1d"},
            success:function(data){
                if(data.resultCode == "S"){
                    if(data.dormCode == "L002"){
                        hpDorm(data, "h");
                    }else if(data.dormCode == "L004"){
                        if(data.login == "Y"){
                            hpoinPwChange(data);
                        }else if(data.login == "N"){
                            hpoinPwChange2(data);
                        }
                    }else if(data.dormCode == "L999"){
                    	GA_Event('로그인', '로그인', '로그인');
                        $("#hpointLoginForm").find("#j_username").val(data.otpId);
                        $("#hpointLoginForm").submit(); 
//                         $("#hpointLogin").submit(); 
                    }else if(data.dormCode == "L003"){
                        layerAlert("로그인 할 수 없습니다.<br/>H.Point 고객센터(1800-2800)로<br/>문의해주세요.");
                    }else if(data.dormCode == "0000"){
                        if(data.login == "Y"){
                            $("#hpointLoginForm").find("#j_username").val(data.otpId);
		                    gfnReqSSoToknIssuAjax(data.hpMcustNo, data.hpSsoAuthCd, 'https://sso.h-point.co.kr:29865', hpSsoSuccess);
                        }else if(data.login == "N"){
                            $("#ssoMcustNo").val(data.hpMcustNo);
                            layerPopup('open'); 
                        }
                    }
                }else if(data.resultCode == "M"){
                    layerAlert(data.resultMessage);
//                     isShow('');
                }else if(data.resultCode == "R"){
                    /* if(data.dormCode == "L004"){
                        hpoinPwChange2();
                    } */
                    layerAlert("탈퇴 후 90일 전에는 로그인 및 재가입 하실 수 없습니다.");
                }else if(data.resultCode == "E"){
                    document.getElementById("hpErrMsg").textContent=data.resultMessage;
                }
            },
            error:function(e){
                layerAlert("로그인 처리 중 오류가 발생했습니다.");
            }
        });
    }
    
    $("#otplogin").click(function(){
        var otp = $("#otpNo").val();

        document.getElementById("loginLayer").value = "H";

        if(otp==""){
            layerAlert("OTP번호를 입력해 주십시요."); 
            return;
        }
        
        $.ajax({
            type:"GET",
            url:"/ko/member/otpMember",
            data: {"otp":otp},
            success:function(data){
                if(data.resultCode == "S"){
                    if(data.dormCode == "L002"){
                        hpDorm(data, "");
                    }else if(data.dormCode == "L004"){
                        if(data.login == "Y"){
                            hpoinPwChange(data);
                        }else if(data.login == "N"){
                            hpoinPwChange2(data);
                        }
                    }else if(data.dormCode == "L003"){
                        layerAlert("로그인 할 수 없습니다.<br/>H.Point 고객센터(1800-2800)로<br/>문의해주세요.");
                    }else if(data.dormCode == "0000"){
	                    if(data.login == "Y"){
	                        $("#hpointLoginForm").find("#j_username").val(data.otpId);
// 	                        $("[id='j_username']").eq(1).val(data.otpId);
	                        gfnReqSSoToknIssuAjax(data.hpMcustNo, data.hpSsoAuthCd, 'https://sso.h-point.co.kr:29865', hpSsoSuccess);
                        }else if(data.login == "N"){
//                             $("#ssoMcustNo").val(data.hpMcustNo);
//                             layerPopup('open'); 
                            location.href="/ko/member/login?error=true";
                        }
                    }
                }else if(data.resultCode == "M"){
                    layerAlert(data.resultMessage);
//                     isShow('');
                }else if(data.resultCode == "R"){
                    /* if(data.dormCode == "L004"){
                        hpoinPwChange2();
                    } */
                    layerAlert("탈퇴 후 90일 전에는 로그인 및 재가입 하실 수 없습니다.");
                }else{
                    document.getElementById("otpErrMsg").textContent=data.resultMessage;
                }
            },
            error:function(e){
                layerAlert("로그인 처리 중 오류가 발생했습니다.");
            }
        });
    });    

    $("#otpShow").click(function(){
        $("#handsomeCust .inner_box .title_wrap:first").html("<h4>OTP 인증번호</h4>");
        
        $('#hpIPLogin').hide();
        $('#hpOtpLogin').show(); 
        $('#isOtp').hide();
        $("#otpNo").focus(); 
        
        try{
            ga('gp.send','pageview',{
                'title':'로그인>OTP 인증번호 로그인', //가상페이지 화면명
                'location':window.location.protocol + '//' + window.location.host + decodeURI(window.location.pathname) + '/otplogin' //가상페이지URL
            });
        }catch(e) {
            console.log(e);
        }
    });

    $("#idShow").click(function(){
        $("#handsomeCust .inner_box .title_wrap:first").html("<h4>회원</h4>");
        $("#loginForm").find("input[name='j_username']").focus();
        
        $('#hpIPLogin').show();
        $('#hpOtpLogin').hide(); 
        $('#isOtp').show();
    });
	/*
	$('#id_save').click(function(){
    	
        if($(this).is(':checked')){
        	layerAlert("눌림");
            $("#IdSave").val("Y"); 
        }else{
            $("#IdSave").val(""); 
        }
    }); 
    */
});

function hpSsoSuccess(){
	GA_Event('로그인', '로그인', '로그인');
    $("#hpointLoginForm").submit();        
}

//HP휴면
function hpDorm(data, ltype){
    var msg = "휴면고객입니다.<br/>로그인 하시면 휴면상태가 해제됩니다.<br/>로그인 하시겠습니까?";
    layerConfirm(msg,"휴면해제","취소");
    
    $("#clsBtn").on("click",function(){
    });
    
    $("#cfBtn").on("click",function(){
        $("#otpIdD").val(data.otpId);
        $("#mcustNoD").val(data.mcustNo);
        $("#isLogin").val(data.login);
        var paramDatas = $("#dormMcustForm").serialize();
        $.ajax({
            type:"POST",
            url:"/ko/member/dormMcust",
            data:paramDatas,
            success:function(rdata){
                if(rdata.resultCode == "S"){
                    if(rdata.dormCode == "L004"){
                        if(data.login == "Y"){
                            hpoinPwChange(rdata);
                        }else if(data.login == "N"){
                            hpoinPwChange2(rdata);
                        }
                    }else if(rdata.dormCode == "L003"){
                        layerAlert("로그인 할 수 없습니다.<br/>H.Point 고객센터(1800-2800)로<br/>문의해주세요.");
                    }else if(rdata.dormCode == "0000"){
                        if(data.login == "Y"){
                            $("#hpointLoginForm").find("#j_username").val(rdata.otpId);
//                             $("[id='j_username']").eq(1).val(rdata.otpId);
                            gfnReqSSoToknIssuAjax(rdata.hpMcustNo, rdata.hpSsoAuthCd, 'https://sso.h-point.co.kr:29865', hpSsoSuccess);
                        }else if(data.login == "N"){
//                             $("#ssoMcustNo").val(rdata.hpMcustNo);
//                             layerPopup('open'); 
                            location.href="/ko/member/login?error=true";
                        }
                    }
                }else if(data.resultCode == "R"){
                    /* if(data.dormCode == "L004"){
                        hpoinPwChange2();
                    } */
                    layerAlert("탈퇴 후 90일 전에는 로그인 및 재가입 하실 수 없습니다.");
                }else{
                    if(ltype == "h"){
                        layerAlert(rdata.resultMessage);
//                         document.getElementById("hpErrMsg").textContent=rdata.resultMessage;
                    }else{
                        layerAlert(rdata.resultMessage);
//                         document.getElementById("otpErrMsg").textContent=rdata.resultMessage;
                    }
                }
            },
            error:function(e){
                layerAlert("로그인 처리 중 오류가 발생했습니다.");
            }
        });
    });     
}

function isShow(custType){
    if(custType=='h'){
        $('#handsomeCust').show();
        $("#loginForm").find("input[name='j_username']").focus();
        $('#isOtp').show();
        
        /* $("#hc1").removeClass("on");
        $("#hc2").addClass("on");
        $('#handsomeCust').hide();
        $('#hpCust').show();
        $('#hpIPLogin').show();
        $('#hpOtpLogin').hide();
        $('#isIdNpw').hide();
        $('#isOtp').show();
        $("#hpId").focus();  */    
    }else{
        $('#handsomeCust').hide();
        $('#isOtp').hide();
        
        /* $("#hc1").addClass("on");
        $("#hc2").removeClass("on");
        $('#handsomeCust').show();
        $('#hpCust').hide();
        $('#hpIPLogin').show();
        $('#hpOtpLogin').hide(); 
        $('#isIdNpw').hide();
        $('#isOtp').show(); */
        
    }
}

function ssoTokenSuc(data){
    if (data.succYn == "Y") {
        $.ajax({
            type:"GET",
            url:"/ko/member/hpAutoLogin",
            data: {"mcustNo":data.mcustNo},
            success:function(data){
                if(data.resultCode == "S"){
                    $("#hpointLoginForm").find("#j_username").val(data.tempId);
                    //$("[id='j_password']").eq(1).val(data.tempPw);
//                     $("#hpointLogin").submit(); 
                    hpSsoSuccess();
                }
            },
            error:function(e){
            }
        });
    }
}

function hpoinPwChange(data){
	tempData = data;
    gfnReqSSoToknIssuAjax(data.hpMcustNo, data.hpSsoAuthCd, 'https://sso.h-point.co.kr:29865', hpPwChange);
}


function hpoinPwChange2(data){
    var msg = "통합멤버십 비밀번호 변경 대상 회원입니다. <br/>비밀번호를 변경해주세요.";
    layerConfirm2(msg,"비밀번호변경","다음에변경");
    
    var mcustNo = data.hpMcustNo;
    
    $("#clsBtn").on("click",function(){
        //비밀번호 다음에변경하기 
        $.ajax({
            type:"GET",
            url:"/ko/member/pwdExcept",
            data: {"mcustNo":mcustNo},
            success:function(data){
                hpSsoSuccess();
            },
            error:function(e){
                hpSsoSuccess();
            }
        });
        
    });
    
    $("#cfBtn").on("click",function(){
    	var hdUrl = "https://www.h-point.co.kr/cu/mem/showCustInfo.shd";
    	window.open(hdUrl,"pwChange_window");
    	hpSsoSuccess();
    });
}

function hpPwChange(){
	var data = tempData;
    var msg = "통합멤버십 비밀번호 변경 대상 회원입니다. <br/>비밀번호를 변경해주세요.";
    layerConfirm2(msg,"비밀번호변경","다음에변경");
    
//     $("[id='j_username']").eq(1).val(data.otpId);
    $("#hpointLoginForm").find("#j_username").val(data.otpId);
    
    $("#clsBtn").on("click",function(){
        //비밀번호 다음에변경하기 
        $.ajax({
            type:"GET",
            url:"/ko/member/pwdExcept",
            data: {"mcustNo":data.mcustNo },
            success:function(data){
                hpSsoSuccess();
            },
            error:function(e){
                hpSsoSuccess();
            }
        });
    });
    
    $("#cfBtn").on("click",function(){
        var hdUrl = "https://www.h-point.co.kr/cu/mem/showCustInfo.shd";
        window.open(hdUrl,"pwChange_window");
        hpSsoSuccess();
    });
}

function simpJoin(){
    var hdUrl = "https://www.h-point.co.kr/cu/join/simpJoinStart.nhd";
    window.open(hdUrl,"simpStart_window");
    
    document.getElementById("ptcoReqnMdaInf").value = "pc";
    $("#simpJoinForm").attr("action", hdUrl);
    $("#simpJoinForm").submit();
    $("#simpJoinLayer").hide();  
}

//가입 유도 팝업    
function layerPopup(division) {
    if(division == "open") {
        $("#simpJoinLayer").show();
    } else {
        $("#simpJoinLayer").hide();  
    }   
}

function easyMemJoin() {
    var lc = new layerConfirm("<span style='color:red;'>간편회원으로 가입</span>하실 경우,<br> <span style='color:red;'>한섬마일리지 및 H.Point 적립이 불가</span>하며,<br><span style='color:red;'>한섬 온라인 멤버십 서비스 ‘THE 클럽’의 혜택을 받으실 수 없습니다.<br></span> 간편회원 가입을 진행하시겠습니까?", "간편회원 가입");
    lc.confirmAction = function(){
        location.href = "/member/joinprovision";
    };
    return;
}

/* function kakaoLoginCallback(data) {
	if ( 'Y' == '' ) {
	    data = JSON.parse(data);
	    if ( data.resultCode == "S" ) {
            if ( data.dormCode == "L002" ) {
                hpDorm(data, "");
            } else if ( data.dormCode == "L004" ) {
                if(data.login == "Y"){
                    hpoinPwChange(data);
                }else if(data.login == "N"){
                    hpoinPwChange2();
                }
            } else if ( data.dormCode == "L003" ) {
                layerAlert("로그인 할 수 없습니다.<br/>H.Point 고객센터(1800-2800)로<br/>문의해주세요.");
            } else if ( data.dormCode == "0000" ) {
                if ( data.login == "Y" ) {
                    $("#hpointLoginForm").find("#j_username").val(data.otpId);
                    gfnReqSSoToknIssuAjax(data.hpMcustNo, data.hpSsoAuthCd, 'https://sso.h-point.co.kr:29865', hpSsoSuccess);
                } else if ( data.login == "N" ) {
                    location.href="/ko/member/login?error=true";
                }
            }
        } else if ( data.resultCode == "M" ) {
            layerAlert(data.resultMessage);
        } else if ( data.resultCode == "R" ) {
            layerAlert("탈퇴 후 90일 전에는 로그인 및 재가입 하실 수 없습니다.");
        } else {
        	layerAlert(data.resultMessage);
        }
	}
} */

function kakaoLogin(){
    
    var ret=window.open('about:blank', 'hpKkoLogin', "width=430,height=650", false);
    var frm=document.kakaoForm;
    frm.action="https://www.h-point.co.kr/api/login/kakaoLoginApi.nhd";
    frm.target="hpKkoLogin";
    frm.method="post";
    frm.submit();
}
//]]>
</script>
<form id="kakaoForm" name="kakaoForm" method="post" action="" target="hpKkoLogin">
<input type="hidden" name="prtnrId" value="D080">
    <input type="hidden" name="chnnlId" value="1705">
    <input type="hidden" name="kkoRetUrl" id="kkoRetUrl" value="https://www.thehandsome.com:443/ko/member/isKakaoMember">
</form>
<form id="hpointLoginForm" name="hpointLoginForm" action="/ko/j_spring_security_check" method="post">
    <input type="hidden" id="j_password" name="j_password" value="sso">
    <input type="hidden" id="j_username" name="j_username">
    <input type="hidden" id="hpPwChange" name="hpPwChange" value="">
    <input type="hidden" id="IdSave" name="IdSave" value="">
</form>
<form id="hpointHiddenForm" method="post" action="" target="joinStart_window">
    <input type="hidden" name="prtnrReqGb" value="02">
    <input type="hidden" name="prtnrId" value="D080">
    <input type="hidden" name="chnnlId" value="1705">
    <input type="hidden" name="ptcoReqnMdaInf" id="ptcoReqnMdaInf">
</form>
<form id="simpJoinForm" method="post" action="" target="simpStart_window">
    <input type="hidden" name="prtnrId" value="D080">
    <input type="hidden" name="chnnlId" value="1705">
    <input type="hidden" name="ssoMcustNo" id="ssoMcustNo" value="">
    <input type="hidden" name="ptcoReqnMdaInf" id="ptcoReqnMdaInf">
</form>
<form id="dormMcustForm" action="/ko/member/login" method="post"><input type="hidden" name="mcustNo" id="mcustNoD" value="">
    <input type="hidden" name="otpId" id="otpIdD" value="">
<div>
<input type="hidden" name="CSRFToken" value="1ca503cd-f035-4118-8b48-9355905e6a1d">
</div></form><!-- 다국어 한국에서만 사용 -->
<input type="hidden" name="loginLayer" id="loginLayer" value="E">
<div id="bodyWrap" class="login">
    <h3 class="cnts_title"><span>로그인</span></h3>
    <div class="sub_container">
         <div id="handsomeCust" class="login_wrap box_type_1 renewal1904">
            <div class="border_box1"><!-- 추가 190417 -->
                <div class="inner_box">
	                <div class="title_wrap">
	                    <h4>회원</h4>
	                </div>
	                <div id="hpIPLogin">
	                <!-- 스프링 시큐리티 적용하기 (황명하)  -->
	                <form id="loginForm" name="loginForm" action="/LoginAction" method="post">
	                    <input type="hidden" name="inputId" id="inputId" value="">
	                    <fieldset>
	                        <legend>로그인 입력항목</legend>
	                        <div class="login_section">
	                                
	                            <p class="login_err_txt" id="hpErrMsg" style="margin-left:0px;"></p>
	                            <div>
	                                <div>
	                                    <input type="text" id="j_username" name="j_username" placeholder="아이디 / 이메일을 입력하세요." title="아이디" value="">
	                                </div>
	                                <div>
	                                    <input type="password" id="j_password" name="j_password" placeholder="비밀번호를 입력하세요." title="비밀번호">
	                                </div>
	                            </div>
	                            <a class="btn_login" id="login_btn">로그인</a>
	                            <div class="id_save">
	                               <input type="checkbox" id="id_save" name="id_save" value="Y"> <label for="id_save">아이디 저장</label>
	                            </div>
	                        </div>
	                    </fieldset>
	                    <!-- <div class="login_opt_1904" id="isOtp">
                           <ul class="three_type_opt">
                               <li><a href="javascript:kakaoLogin();" >카카오 간편로그인</a></li>
                               <li><a href="#;" id="otpShow" class="otp">OTP 인증번호 로그인</a></li>
                               <li><a href="/ko/member/nonMemberLogin">비회원 주문조회</a></li>
                           </ul>
                        </div> -->
                        <div class="login1905">
                            <div><a href="#;" id="otpShow" class="otp" onclick="GA_Event('로그인', '로그인', 'OTP_인증번호_로그인');">OTP 인증번호 로그인</a></div>
                            <div><a href="/ko/member/nonMemberLogin" onclick="GA_Event('로그인', '로그인', '비회원_주문조회');">비회원 주문조회</a></div>
                        </div>
	                </form>
	                </div>
	                
	                <div id="hpOtpLogin" style="display:none">
                       <div class="login_section otp190424">
                           <p class="login_err_txt" id="otpErrMsg"></p>
                           <div>
                               <div>
                                   <input type="text" id="otpNo" name="otpNo" placeholder="OTP 인증번호를 입력하세요.">
                               </div>
                           </div>
                           <a href="javascript:void(0);" class="btn_login" id="otplogin">로그인</a>
                           <p class="login_sub_txt">
                              H.Point 모바일앱 실행 &gt; 설정메뉴 &gt; ’OTP인증번호발급메뉴’ 를 통해<br>
                              OTP인증번호를 발급하고 발행된 인증번호를 입력해 주세요.
                          </p>
                       </div>
                       <div class="login1905" id="idId">
                           <div><a href="#;" id="idShow" onclick="GA_Event('로그인', '로그인', '아이디/비밀번호 로그인');">아이디 / 비밀번호 로그인</a></div>
                           <div><a href="/ko/member/nonMemberLogin" onclick="GA_Event('로그인', '로그인', '비회원_주문조회');">비회원 주문조회</a></div>
                       </div>
                    </div>
	                
	                
	                <div class="section_bottom"><!-- 추가 190417 -->
	                    <p class="mb0">
	                       <span class="bul_sty01">한섬 회원 아이디 / 비밀번호를 잊으셨나요?</span>
	                       <a href="/ko/member/findIdPwPage" class="btn add_ss" onclick="GA_Event('로그인', '간편회원_찾기', '한섬회원_아이디/비밀번호_찾기');">한섬 회원 아이디 / 비밀번호 찾기</a>
	                    </p>
                    </div>
	            </div>
            </div>
            <div class="border_box2"><!-- 추가 190417 -->
                <div class="inner_box step2">
	                <div class="title_wrap">
	                    <h4 class="tlt_typ1">더한섬닷컴 간편회원 가입</h4>
	                    <p class="txt" style=" line-height: 1.5;">본인인증 절차 없이, 더한섬닷컴에서 제공하는 서비스만 제한적으로<br>이용할 수 있는 ID를 만듭니다.</p>
	                    <p class="join_txt2 mt10">더한섬닷컴에서 사용 가능하며, 오프라인 매장에서는 사용할 수 없습니다.<br><span>한섬마일리지와 현대백화점그룹 H.Point 혜택, 한섬의 온라인 멤버십 서비스<br>‘THE 클럽’의 혜택은 제공되지 않습니다. </span></p>
	                </div>                      
	                <div class="title_wrap hide" id="eg_block">
	                    <a onclick="easyMemJoin();GA_Event('로그인', '가입', '간편회원_가입');" class="btn add_ss join" style="width:366px">간편회원 가입</a>
	                    <p class="join_txt2 mt20">
	                        <span>※ 간편회원은 e-Gift Card 구매 및 등록이 불가능합니다.<br>통합회원 가입 후 이용해 주세요.</span>
	                    </p>
	                </div>
	            </div>
            </div>
        </div>
         <!--//login wrap-->
    </div>
    <!--//sub_container-->
</div>
<div class="layerArea" id="simpJoinLayer" style="display:none;">
    <div class="layerBg" style="display:block;" tabindex="-1"></div> 
    <div class="popwrap w_type_8" id="" style="position: absolute; z-index: 201; display: block;" tabindex="-1">
        <div class="pop_tltwrap3">
            <h3>더한섬닷컴 회원가입</h3>
        </div>
        <div class="pop_cnt">
            <div class="hpoint">
                <p class="img"><img src="/resources/_ui/desktop/common/images/popup/join_pop_icon.jpg" style="vertical-align:top"></p>
                <p class="txt">
                    H.Point통합회원 정보로 더한섬닷컴에 회원가입이 가능합니다.<br>
                    단, 더한섬닷컴 가입확인을 위해 아래의 정보로 조회가 진행됩니다.<br>
                    동의하시면 회원가입 해주세요.<br>
                    <span>※ 조회정보 : 이름, 생년월일, 휴대폰번호</span>
                </p>
                <div class="btnwrap mt30">
                    <input class="btn gray" value="더한섬닷컴 가입" type="button" style="width:200px" onclick="simpJoin();">
                </div>
            </div>
        </div>
        <a href="#" class="btn_close" id="closeLayerPop" onclick="layerPopup('close');"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png"></a>
    </div>
</div>

<%@include file = "../include/footer.jsp"  %>