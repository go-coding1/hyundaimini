<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file = "member_header.jsp"  %>
		
		<script type="text/javascript">
//<![CDATA[ 
$(document).ready(function(){
    

     var nowYear = parseInt('2008');
     var nowMonth = parseInt('05');
     var nowDay = parseInt('03');
     var monthArray = [0, 31, 28, 31, 30, 31, 30, 31, 31 ,30, 31, 30, 31];

     
     
    
    //if(nowYear < 2000) nowYear += 1900;
    
    //년도 
    for(var i=nowYear; i>=1900; i--) {
        $('#selYear').append("<option value='" + i + "'>" + i + "</option>");
    }
    
    $("#selYear").change(function(){


    	var selYear1 = $('#selYear').val();
    	
		if($('#selMonth').val() == 02){
			if($("#selDay option:last").val() >= 29){
				
    			$("#selDay option[value='29']").remove();
    			$("#selDay option[value='30']").remove();
    			$("#selDay option[value='31']").remove();
    		}
    		
			if((selYear1%4 == 0 && selYear1%100 !=0) || selYear1%400 == 0 ){
    			$("#selDay").append("<option value='29'>29</option>");
    		}
    	}
		
		
		//만14세미만 가입X
		if(nowYear == selYear1){
			for(var i = nowMonth+1;i <= 12; i++){
				if(i<10){$("#selMonth option[value='0"+i+"']").remove();}
				else{$("#selMonth option[value='"+i+"']").remove();}
				if($("#selMonth").val() > nowMonth)$("#selMonth").val('').prop("selected", true);
			}
			
			if(nowMonth == parseInt($('#selMonth').val())){
				
				var n_selMonth = parseInt($('#selMonth').val());
				var maxDay = monthArray[n_selMonth];

				for(var i = nowDay+1;i <= maxDay;i++){
					if(i<10){$("#selDay option[value='0"+i+"']").remove();}
					else{$("#selDay option[value='"+i+"']").remove();}
					if($("#selDay").val() > nowDay){$("#selDay").val('').prop("selected", true);}
				}
			}
		}else{
			var n_selMonth = parseInt($('#selMonth').val());
			var maxDay = monthArray[n_selMonth];
			
			if($("#selMonth option:last").val() < 12){
				for(var i = nowMonth+1;i <= 12; i++){
					if(i<10){$("#selMonth").append("<option value='0"+i+"'>0"+i+"</option>");}
					else{$("#selMonth").append("<option value='"+i+"'>"+i+"</option>");}
				}
			}
			
			
			if($("#selDay option:last").val() < maxDay){
				
				if($('#selMonth').val() == 02){
					if((selYear1%4 == 0 && selYear1%100 !=0) || selYear1%400 == 0 ){maxDay=29;}
				}
				
				for(var i = parseInt($("#selDay option:last").val())+1;i <= maxDay;i++){
					if(i<10){$("#selDay").append("<option value='0"+i+"'>0"+i+"</option>");}
					else{$("#selDay").append("<option value='"+i+"'>"+i+"</option>");}
				}
			}
			
		}
    });
    
    $("#selMonth").change(function(){
    	var lastDay = $("#selDay option:last").val();
    	var selYear1 = $('#selYear').val();
    	var n_selMonth = parseInt($('#selMonth').val());
		var maxDay = monthArray[n_selMonth];
    	
    	if($(this).val() == 02){
    		
    		
    		$("#selDay option[value='31']").remove();
			$("#selDay option[value='30']").remove();
			$("#selDay option[value='29']").remove();
    		
    		if((selYear1%4 == 0 && selYear1%100 !=0) || selYear1%400 == 0){
    			$("#selDay").append("<option value='29'>29</option>");
        		
    		};

    		
    	}else if($(this).val() == 04 || $(this).val() == 06 || $(this).val() == 09 || $(this).val() == 11){
    		
    		
    			if(lastDay == 28){
					$("#selDay").append("<option value='29'>29</option>");
					$("#selDay").append("<option value='30'>30</option>");
    			}else if(lastDay == 29){
					$("#selDay").append("<option value='30'>30</option>");
    			}else if(lastDay == 31){
					$("#selDay option[value='31']").remove();
    			}
    		
    			
    	}else{
    		
    		if(lastDay == 28){
    			$("#selDay").append("<option value='29'>29</option>");
    			$("#selDay").append("<option value='30'>30</option>");
    			$("#selDay").append("<option value='31'>31</option>");
    		}else if(lastDay == 29){
    			$("#selDay").append("<option value='30'>30</option>");
    			$("#selDay").append("<option value='31'>31</option>");
    		}else if(lastDay == 30){
				$("#selDay").append("<option value='31'>31</option>");
    		}
    	}
    	
    	
    	//만14세미만 가입X
		if(nowYear == selYear1 && nowMonth == $('#selMonth').val()){
			
				for(var i = nowDay + 1;i <= $("#selDay option:last").val();i++){
					if(i<10){$("#selDay option[value='0"+i+"']").remove();}
					else{$("#selDay option[value='"+i+"']").remove();}
					if($("#selDay option:last").val() < $("#selDay").val())$("#selDay").val('').prop("selected", true);
				}
		}else{
			
			if($("#selDay option:last").val() < maxDay){
				for(var i = parseInt($("#selDay option:last").val()) + 1;i <= maxDay;i++){
					if(i<10){$("#selDay").append("<option value='0"+i+"'>0"+i+"</option>");}
					else{$("#selDay").append("<option value='"+i+"'>"+i+"</option>");}
				}
			}
		}
    });
    
    emailTypeDomainSelectController("#emailDomain","#emailDomainSel");

    passwordValidationCheck('pw');
    passwordValidationCheck('pwc');
    
    
    
    $("#pw").keypress(function(event){

        if(capsLock(event)){
            $("#pwcapsLockMsg").text("<Caps Lock>이 켜져 있습니다.");
        } else {
            $("#pwcapsLockMsg").text("");
        }
        if($("#pw").val().length > 0)
            $("#pwMsg").text("비밀번호는 8~15자리 이하로 영문/숫자/특수문자를 혼합해주세요");
     });
     
     $("#pw").focus(function(event){
        $("#pwMsg").text("비밀번호는 8~15자리 이하로 영문/숫자/특수문자를 혼합해주세요");
     });
     
     $("#pw").blur(function(){
         if($(this).val().length > 0){
            var pwRegExp = /^(?=.*[a-zA-Z])(?=.*[\?\<\>\;\:\'\"\`\(\)\{\}\[\]\|\\\~\,\.!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
            if(!pwRegExp.test($(this).val())){  
                $("#pwMsg").text("비밀번호는 8~15자리 이하로 영문/숫자/특수문자를 혼합해주세요");
                $("#pwTypeChk").val("");
                return true;
            }
            $("#pwTypeChk").val("Y");   
            $("#pwMsg").text("");
            $("#pwcMsg").text("");
            $("#pwConfirmChk").val("");
        }
     });
     
     $("#pwc").keypress(function(event){
         
        if(capsLock(event)){
            $("#pwcCapsLockMsg").text("<Caps Lock>이 켜져 있습니다.");
        } else {
            $("#pwcCapsLockMsg").text("");
        }
        
        if($("#pwc").val().length > 0)
            $("#pwcMsg").text("비밀번호는 8~15자리 이하로 영문/숫자/특수문자를 혼합해주세요");
         
     });
     
     $("#pwc").focus(function(event){
            $("#pwcMsg").text("비밀번호는 8~15자리 이하로 영문/숫자/특수문자를 혼합해주세요");
            
     });
     
     $("#pwc").blur(function(){
        if($("#pw").val()!=$("#pwc").val()){
            $("#pwcMsg").text("비밀번호가 일치하지 않습니다");
            $("#pwConfirmChk").val("");
            //$("#pwc").val("");
            return true;
        }
        if($("#pw").val()!= ""){
            $("#pwConfirmChk").val("Y");
            $("#pwcMsg").text("비밀번호가 확인되었습니다.");
        }
     });
     
     // 아이디 중복체크 생성(황명하)
     $('#idDubChkBtn').click(function(){
         var vc = new ValidationCheck();
         vc.checkIdList = ['id'];
         vc.msgFn = function(msg){
             $("#idMsg").text(msg);
         };
         if(vc.isValid()){
             $.ajax({
                 type:"GET",
                 url:"/member/isduplid?id="+$("#id").val(),
                 success:function(result){
                     if(result=="true"){
                         $("#idMsg").text('이미 사용중인 아이디입니다.');
                     }else{
                         $("#idMsg").text('사용 가능한 아이디입니다.');
                         $("#idDuplChk").val('Y');
                     }
                 },
                 error:function(e){
                     console.log(e);
                 }
             });
         }
     });
     //아이디 입력창 내용이 바뀌면 설정 초기화
     $("#id").change(function(){
         $("#idMsg").text('');
         $("#idDuplChk").val(''); 
         //var email1 = "ghkd2676@naver.com";
         //var email2= $("#email").val()+"@"+$("#emailDomain").val();
     });  
     
     
     // 이메일 중복체크 생성(황명하)
     $('#emailDubChkBtn').click(function(){
         var vc = new ValidationCheck();
         vc.checkIdList = ['email','emailDomain'];
         vc.msgFn = function(msg){
             $("#emailMsg").text(msg);
         };
         if(vc.isValid()){
             $.ajax({
                 type:"GET",
                 url:"/member/isduplemail?email="+$("#email").val()+"@"+$("#emailDomain").val(),
                 success:function(result){
                     if(result=="true"){
                         $("#emailMsg").text('이미 사용중인 이메일입니다.');
                     }else{
                         $("#emailMsg").text('사용 가능한 이메일입니다.');
                         $("#emailDuplChk").val('Y');
                     }
                 },
                 error:function(e){
                     console.log(e);
                 }
             });
         }
     });
   //이메일 입력창 내용이 바뀌면 설정 초기화
     $("#email, #emailDomain, #emailDomainSel").change(function(){
         $("#emailMsg").text('');
         $("#emailDuplChk").val(''); 
         //var email1 = "ghkd2676@naver.com";
         //var email2= $("#email").val()+"@"+$("#emailDomain").val();
         
     });     

     /*
     $('#emailDubChkBtn').click(function(){
         var vc = new ValidationCheck();
         vc.checkIdList = ['email','emailDomain'];
         vc.msgFn = function(msg){
             $("#emailMsg").text(msg);
         };
         if(vc.isValid()){
             $.ajax({
                 type:"GET",
                 url:"/ko/member/isduplemail?email="+$("#email").val()+"@"+$("#emailDomain").val(),
                 success:function(response){
                     if(response==true){
                         $("#emailMsg").text('이미 사용중인 이메일입니다.');
                     }else{
                         $("#emailMsg").text('사용 가능한 이메일입니다.');
                         $("#emailDuplChk").val('Y');
                         
                     }
                 },
                 error:function(e){
                     console.log(e);
                 }
             });
         }
     });
     
     $("#email, #emailDomain, #emailDomainSel").change(function(){
          $("#emailMsg").text('');
          $("#emailDuplChk").val(''); 
          var email1 = "ghkd2676@naver.com";
          var email2= $("#email").val()+"@"+$("#emailDomain").val();
          
          if(email1 != email2){
	          $("#ck1").prop('checked', false);
	          $("#ck1").attr('checked', false);
          }
      });     
     */
     
     
     // 전화번호 중복체크 생성(황명하)
     $('#pnDubChkBtn').click(function(){
         var vc = new ValidationCheck();
         vc.checkIdList = ['phoneDomainSel', 'phoneMiddle', 'phoneEnd'];
         vc.msgFn = function(msg){
             $("#pnMsg").text(msg);
         };
         if(vc.isValid()){
             $.ajax({
                 type:"GET",
                 url:"/member/isduplpn?pn="+$("#phoneDomainSel").val()+$("#phoneMiddle").val()+$("#phoneEnd").val(),
                 success:function(result){
                     if(result=="true"){
                         $("#pnMsg").text('이미 가입된 번호입니다.');
                     }else{
                         $("#pnMsg").text('사용 가능한 번호입니다.');
                         $("#pnDuplChk").val('Y');
                     }
                 },
                 error:function(e){
                     console.log(e);
                 }
             });
         }
     });
     
     //아이디 입력창 내용이 바뀌면 설정 초기화
     $("#phoneDomainSel, #phoneMiddle, #phoneEnd").change(function(){
         $("#pnMsg").text('');
         $("#pnDuplChk").val(''); 
         //var email1 = "ghkd2676@naver.com";
         //var email2= $("#email").val()+"@"+$("#emailDomain").val();
     });  
          
     
     
     
      $("#cancleBtn").click(function(){
          var lc = new layerConfirm('회원가입을 취소하시겠습니까?', '확인', '취소');
          lc.confirmAction = function(){
              location.href="/";
          };
      });

      
      var joinCfBtnChk = 0;
      $("#joinBtn").click(function(){

          var vc = new ValidationCheck(); 
          vc.checkIdList = ['id', 'pw', 'pwc','phoneDomainSel','phoneMiddle','phoneEnd', 'name', 'selYear', 'selMonth', 'selDay'];

          if(!vc.isValid()){
              return;
          }
          var idDuplChk = $("#idDuplChk").val();
          var pwTypeChk = $("#pwTypeChk").val();
          var pnDuplChk = $("#pnDuplChk").val();
          var pwConfirmChk = $("#pwConfirmChk").val();
          var emailDuplChk = $("#emailDuplChk").val();
		
          
          // 아이디 관련 미흡 사항 전달
          if($("#id").val()!=""){
              if ( idDuplChk !== "Y") {
                  layerAlert("아이디 중복확인이 되지 않았습니다.");
                  return;
              }
              
              var email = $("#id").val();
              
              if(email.length > 30) {
                  layerAlert("아이디는 최대 30자입니다.");
                  return;
              }
          }
          
          
          
          if ( pwTypeChk !== "Y") {
              layerAlert("비밀번호는 8~15자리 이하로 영문/숫자/특수문자를 혼합해주세요 ");
              return;
          }
          
          if ( pwConfirmChk !== "Y") {
              layerAlert("비밀번호가 일치하지 않습니다 ");
              return;
          }
          
          
          if($("#phoneDomainSel").val()!=""){
              if ( pnDuplChk !== "Y") {
                  layerAlert("전화번호 중복확인이 되지 않았습니다.");
                  return;
              }
          }
          
          if($("#email").val()!=""){
              if ( emailDuplChk !== "Y") {
                  layerAlert("E-mail 중복확인이 되지 않았습니다.");
                  return;
              }
              
              var email = $("#email").val()+"@"+$("#emailDomain").val();
              if (!validateEmail(email)) {
                  layerAlert("잘못된 E-mail 형식입니다.");
                  return;
              }
              
              if(email.length > 50) {
                  layerAlert("E-mail은 최대 50자입니다.");
                  return;
              }
          }else{
              if($("#emailReceiveYn").is(':checked')){
                  layerAlert("E-mail (정보수신용) 을 입력해 주세요.");
                  return;
              }
          }
          
          $("#cancleBtn").attr("disabled", true);
          $("#joinBtn").attr("disabled", true);
          
          $("#collectionAgreementYN").val("Y");
          $("#emailAddress").val($("#email").val()+"@"+$("#emailDomain").val());
          
          if($("#email").val()==""){
              $("#emailAddress").val("");
          }
          $("#sBirthday").val($("#selYear").val() + $("#selMonth").val() + $("#selDay").val());
          $("#memberJoinForm").attr("action", "/member/joincomplete");
          $("#memberJoinForm").submit();
      });
      
      
      $("#email,#emailDomain").keypress(function(event){
          if(event.which == 32){
              return false;
          }
      });
      /*
      $('#ck1').click(function(){
          if($(this).is(':checked')){
              var email = "ghkd2676@naver.com";
              var emailArray = email.split("@");
              
              $("#email").val(emailArray[0]);
              $("#emailDomainSel").val(emailArray[1]);
              $("#emailDomain").val(emailArray[1]);
              $("#emailDomainSel option:eq(0)").prop("selected", "selected");
              $("#emailDomain").show();
          }
      }); 
      */
      $(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
      
      $('.email-prev-detail-btn').click(function(e) {
          e.preventDefault();
          $('.email-detail-pop').show();
          $('.btn_close').click(function(e) {
              e.preventDefault();
              $('.email-detail-pop').hide();
          });
      });
});


/*
 * 비밀번호태그 Key 이벤트 [2017.01.11 - 이현승]
 */
var passwordValidationCheck = function(fid){
    var t = this;
    
    this.msgFn = function(msg){
        $('#'+fid).blur();
        layerAlert(msg)
    };
    
    this.notLockFn = function(){
        //default do nothing. but you can do something!
    };
    
    $('#'+fid).keyup(function(event){
        passwordSamePassCheck(fid);
    });
}

/*
 * 비밀번호 유효성 체크 [2017.01.11 - 이현승]
 */
var readonlyFlag = false;
function passwordSamePassCheck(fid){
    
    var SamePass_0 = 0; // 동일문자 카운트
    var SamePass_1 = 0; // 연속성(+) 카운드
    var SamePass_2 = 0; // 연속성(-) 카운드
    
    var inputdata = $('#'+fid).val();
    
    for (var i = 0; i < inputdata.length; i++) {     // 4자리
        var chr_pass_0 = inputdata.charCodeAt(i - 2);//3);
        var chr_pass_1 = inputdata.charCodeAt(i - 1);//2);
        var chr_pass_2 = inputdata.charCodeAt(i);// - 1);
        
        if (i > 1) {
            // 동일문자 카운트
            if ((chr_pass_0 == chr_pass_1) && (chr_pass_1 == chr_pass_2)) {
                SamePass_0++;
            } else {
                SamePass_0 = 0;
            }
            // 연속성(+) 카운드
            if (chr_pass_0 - chr_pass_1 == 1 && chr_pass_1 - chr_pass_2 == 1) {
                SamePass_1++;
            } else {
                SamePass_1 = 0;
            }
            // 연속성(-) 카운드
            if (chr_pass_0 - chr_pass_1 == -1 && chr_pass_1 - chr_pass_2 == -1) {
                SamePass_2++;
            } else {
                SamePass_2 = 0;
            }
        }
        
        if(!readonlyFlag){
            if (SamePass_0 > 0) {
                readonlyFlag = true;
                $("input").attr("readonly",readonlyFlag);
                var la = new layerAlert("동일문자를 3번 이상 사용할 수 없습니다.");
                la.confirmAction = function(){
                    readonlyFlag = false;
                    $("input").attr("readonly",readonlyFlag);
                    $('#'+fid).focus();
                };
            } else if (SamePass_1 > 0 || SamePass_2 > 0) {
                readonlyFlag = true;
                $("input").attr("readonly",readonlyFlag);
                var la = new layerAlert("연속된 문자열(123 또는 321, abc, cba 등) 3자리이상 올 수 없습니다.");
                la.confirmAction = function(){
                    readonlyFlag = false;
                    $("input").attr("readonly",readonlyFlag);
                    $('#'+fid).focus();
                };
            }
        }
    }
}


      

function validateEmail(email) {
  var re = /^((([^<>()[\]\\.,;:\s@\"~`!@#$%^&*+={}|'/?]+(\.[^<>()[\]\\.,;:\s@\"~`!@#$%^&*+={}|'/?]+)*))|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(email);
}
//]]>
</script>

<!--  주소api 관련 스크립트  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    //document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('address').value = data.zonecode;
                document.getElementById("line1").value = addr+extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("line2").focus();
            }
        }).open();
    }
</script>

<form id="memberJoinForm" action="/ko/member/joininfoform" method="POST">
		<input type="hidden" name="idDuplChk" id="idDuplChk" value="" title="아이디 중복">
		<input type="hidden" name="emailDuplChk" id="emailDuplChk" value="" title="이메일 중복">
        <input type="hidden" name="pnDuplChk" id="pnDuplChk" value="" title="전화번호 중복">
        <input type="hidden" name="pwTypeChk" id="pwTypeChk" value="" title="비밀번호 형식">
        <input type="hidden" name="pwConfirmChk" id="pwConfirmChk" value="" title="비밀번호 일치">
        <input type="hidden" id="uid" name="uid" value="ghkd2676@naver.com">
        <input type="hidden" id="emailAddress" name="emailAddress" value="">
        <input type="hidden" id="sBirthday" name="sBirthday" value="">
        <input type="hidden" id="collectionAgreementYN" name="collectionAgreementYN" value="">
        

        <div id="bodyWrap">
            <!--title-->
            <h3 class="cnts_title"><span>회원가입</span></h3>
            <!--//title-->
            <!--sub container-->
            <div class="sub_container">
                <div class="join_title">
                    <p class="title">고객님의 회원정보를 입력해주세요.</p>
                </div>
                    <fieldset>
                        <legend>회원정보입력</legend>
                        <div class="box_type_1">
                            <div class="title_wrap clearfix">
                                <h4 class="float_left">회원정보</h4>
                                <p class="reqd_txt float_right"><strong class="reqd">*</strong> 표시는 필수항목입니다.</p>
                            </div>
                                <div class="tblwrap">
                                <table class="tbl_wtype1">
                                    <caption>회원가입 입력항목</caption>
                                    <colgroup>
                                        <col style="width:160px">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                        	<!-- 아이디 기입란 생성(황명하) -->
                                            <th scope="row"><strong class="reqd">*</strong><label for="id">아이디</label></th>
                                            <td>
                                             <input type="text" id="id" name="id" style="width:150px" title="아이디">
                                             <input type="button" class="btn add_s" id="idDubChkBtn" value="중복확인"> 
                                             <span class="guide_comment" id="idMsg"></span>
                                            </td>
                                            
                                        </tr>
                                        <tr>
                                            <th scope="row"><strong class="reqd">*</strong><label for="pw">비밀번호</label></th>
                                            <td>
                                                <input type="password" id="pw" name="passwd" style="width:150px" title="비밀번호">
                                                <span class="guide_comment lh_30" id="pwMsg"></span>
                                                <span class="guide_comment lh_30" id="pwcapsLockMsg"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><strong class="reqd">*</strong> <label for="pw2">비밀번호 확인</label></th>
                                            <td>
                                                <input type="password" id="pwc" style="width:150px" title="비밀번호 확인">
                                                <span class="guide_comment" id="pwcMsg"></span>
                                                <span class="guide_comment" id="pwcCapsLockMsg"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                        	<!-- 전화번호 기입란 생성 (황명하) -->
                                        	<th scope="row"><strong class="reqd">*</strong> <label for="phone">전화번호</label></th>
                                        	<td>
                                        		<select id="phoneDomainSel" name="phonenum1" style="width:90px; text-align-last: center" title="전화번호">
                                                    <option value="010">010</option>
                                                    <option value="011">011</option>
                                                    <option value="016">016</option>
                                                    <option value="017">017</option>
                                                    <option value="018">018</option>
                                                    <option value="019">019</option>
                                                    <option value="02">02</option>
                                                    <option value="031">031</option>
                                                    <option value="033">033</option>
                                                    <option value="043">034</option>
                                                    <option value="041">041</option>
                                                    <option value="054">054</option>
                                                    <option value="055">055</option>
                                                    <option value="063">063</option>
                                                    <option value="061">061</option>
                                                    <option value="064">064</option>
                                                    <option value="070">070</option>
                                                    <option value="080">080</option>
                                                </select>
                                                <span class="andphone">-</span>
                                        		<input type="text" style="width:60px" title="중간번호" id="phoneMiddle" name="phonenum2" maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 
                                                <span class="andphone">-</span>
                                                <input type="text" style="width:60px" title="마지막번호" id="phoneEnd" name="phonenum3" maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                                                <input type="button" class="btn add_s" id="pnDubChkBtn" value="중복확인"> 
                                                <span class="guide_comment" id="pnMsg"></span>
                                        	</td>
                                        </tr>
                                        <tr>
                                        	<th scope="row"><label for="address">회원 주소</label></th>
                                        	<td>
                                        		<!-- 주소 -->
		                                        <input type="text" id="address" name= "zipcode" placeholder="우편번호">
		                                        <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn add_s"><br>
		                                        <div id="basis_bk_flag">
		                                        <input type="text" id="line1" name= "address1" placeholder="주소"  class="post_wall top" type="text" readonly><br>
		                                        </div>
		                                        <input type="text" id="line2" name= "address2" placeholder="상세주소" class="post_wall" type="text" maxlength="110"
		                                        placeholder="나머지 주소를 입력해 주세요.">
                                        	</td>
                                        </tr>
                                        
                                        <tr>
                                            <th scope="row"><label for="email">E-mail (정보수신용)</label></th>
                                            <td>
                                                <input type="text" style="width:120px" title="이메일" id="email" name="email1"> 
                                                <span class="andmail">@</span>
                                                <select id="emailDomainSel" name="email2" style="width:120px" title="이메일">
                                                    <option value="">직접입력</option>
                                                    <option value="naver.com">naver.com</option>
                                                    <option value="daum.net">daum.net</option>
                                                    <option value="gmail.com">gmail.com</option>
                                                    <option value="yahoo.co.kr">yahoo.co.kr</option>
                                                    <option value="lycos.co.kr">lycos.co.kr</option>
                                                    <option value="nate.com">nate.com</option>
                                                    <option value="empas.com">empas.com</option>
                                                    <option value="hotmail.com">hotmail.com</option>
                                                    <option value="msn.com">msn.com</option>
                                                    <option value="hanmir.com">hanmir.com</option>
                                                    <option value="chol.net">chol.net</option>
                                                    <option value="korea.com">korea.com</option>
                                                    <option value="netsgo.com">netsgo.com</option>
                                                    <option value="dreamwiz.com">dreamwiz.com</option>
                                                    <option value="hanafos.com">hanafos.com</option>
                                                    <option value="freechal.com">freechal.com</option>
                                                    <option value="hitel.net">hitel.net</option>
                                                </select>
                                                <input type="text" id="emailDomain" name = "email3" style="width:120px" value="" title="이메일 도메인">
                                                <input type="button" class="btn add_s" id="emailDubChkBtn" value="중복확인">
                                                <span class="guide_comment" id="emailMsg"></span>
                                                <!--
                                                <div class="wtype_comment pt10">
                                                    <input type="checkbox" id="ck1"><label for="ck1">이메일 아이디 적용</label>
                                                </div>
                                                 -->
                                                <div class="wtype_comment pt5">
                                                    <input type="checkbox" id="emailReceiveYn" name="emailReceiveYn" value="Y"><label for="emailReceiveYn">이메일을 통한 상품 및 이벤트 정보 수신에 동의합니다. (선택)</label>
                                                    <a href="javascript:void(0);" class="email-prev-detail-btn">자세히 보기</a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><strong class="reqd">*</strong><label for="name">이름</label></th>
                                            <td>
                                                <input type="text" style="width:120px" id="name" name="name"> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><label for="gender">성별</label></th>
                                            <td>
                                             	<select style="width:80px" id="gender" name="gender" title="성별">
                                                    <option value="0">미선택</option>
                                                    <option value="1">남성</option>
                                                    <option value="2">여성</option>
                                                    <option value="3">중성</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><strong class="reqd">*</strong><label for="birth">생년월일</label></th>
                                            <td>
                                                <select style="width:80px" id="selYear" name="birth1" title="년도">
                                                    <option value="">년</option>
                                                <option value="2008">2008</option><option value="2007">2007</option><option value="2006">2006</option><option value="2005">2005</option><option value="2004">2004</option><option value="2003">2003</option><option value="2002">2002</option><option value="2001">2001</option><option value="2000">2000</option><option value="1999">1999</option><option value="1998">1998</option><option value="1997">1997</option><option value="1996">1996</option><option value="1995">1995</option><option value="1994">1994</option><option value="1993">1993</option><option value="1992">1992</option><option value="1991">1991</option><option value="1990">1990</option><option value="1989">1989</option><option value="1988">1988</option><option value="1987">1987</option><option value="1986">1986</option><option value="1985">1985</option><option value="1984">1984</option><option value="1983">1983</option><option value="1982">1982</option><option value="1981">1981</option><option value="1980">1980</option><option value="1979">1979</option><option value="1978">1978</option><option value="1977">1977</option><option value="1976">1976</option><option value="1975">1975</option><option value="1974">1974</option><option value="1973">1973</option><option value="1972">1972</option><option value="1971">1971</option><option value="1970">1970</option><option value="1969">1969</option><option value="1968">1968</option><option value="1967">1967</option><option value="1966">1966</option><option value="1965">1965</option><option value="1964">1964</option><option value="1963">1963</option><option value="1962">1962</option><option value="1961">1961</option><option value="1960">1960</option><option value="1959">1959</option><option value="1958">1958</option><option value="1957">1957</option><option value="1956">1956</option><option value="1955">1955</option><option value="1954">1954</option><option value="1953">1953</option><option value="1952">1952</option><option value="1951">1951</option><option value="1950">1950</option><option value="1949">1949</option><option value="1948">1948</option><option value="1947">1947</option><option value="1946">1946</option><option value="1945">1945</option><option value="1944">1944</option><option value="1943">1943</option><option value="1942">1942</option><option value="1941">1941</option><option value="1940">1940</option><option value="1939">1939</option><option value="1938">1938</option><option value="1937">1937</option><option value="1936">1936</option><option value="1935">1935</option><option value="1934">1934</option><option value="1933">1933</option><option value="1932">1932</option><option value="1931">1931</option><option value="1930">1930</option><option value="1929">1929</option><option value="1928">1928</option><option value="1927">1927</option><option value="1926">1926</option><option value="1925">1925</option><option value="1924">1924</option><option value="1923">1923</option><option value="1922">1922</option><option value="1921">1921</option><option value="1920">1920</option><option value="1919">1919</option><option value="1918">1918</option><option value="1917">1917</option><option value="1916">1916</option><option value="1915">1915</option><option value="1914">1914</option><option value="1913">1913</option><option value="1912">1912</option><option value="1911">1911</option><option value="1910">1910</option><option value="1909">1909</option><option value="1908">1908</option><option value="1907">1907</option><option value="1906">1906</option><option value="1905">1905</option><option value="1904">1904</option><option value="1903">1903</option><option value="1902">1902</option><option value="1901">1901</option><option value="1900">1900</option></select>
                                                <select style="width:80px" id="selMonth" name="birth2" title="월">
                                                    <option value="">월</option>
                                                    <option value="01">01</option>
                                                    <option value="02">02</option>
                                                    <option value="03">03</option>
                                                    <option value="04">04</option>
                                                    <option value="05">05</option>
                                                    <option value="06">06</option>
                                                    <option value="07">07</option>
                                                    <option value="08">08</option>
                                                    <option value="09">09</option>
                                                    <option value="10">10</option>
                                                    <option value="11">11</option>
                                                    <option value="12">12</option>
                                                </select>
                                                <select style="width:80px" id="selDay" name="birth3" title="일">
                                                    <option value="">일</option>
                                                    <option value="01">01</option>
                                                    <option value="02">02</option>
                                                    <option value="03">03</option>
                                                    <option value="04">04</option>
                                                    <option value="05">05</option>
                                                    <option value="06">06</option>
                                                    <option value="07">07</option>
                                                    <option value="08">08</option>
                                                    <option value="09">09</option>
                                                    <option value="10">10</option>
                                                    <option value="11">11</option>
                                                    <option value="12">12</option>
                                                    <option value="13">13</option>
                                                    <option value="14">14</option>
                                                    <option value="15">15</option>
                                                    <option value="16">16</option>
                                                    <option value="17">17</option>
                                                    <option value="18">18</option>
                                                    <option value="19">19</option>
                                                    <option value="20">20</option>
                                                    <option value="21">21</option>
                                                    <option value="22">22</option>
                                                    <option value="23">23</option>
                                                    <option value="24">24</option>
                                                    <option value="25">25</option>
                                                    <option value="26">26</option>
                                                    <option value="27">27</option>
                                                    <option value="28">28</option>
                                                    <option value="29">29</option>
                                                    <option value="30">30</option>
                                                    <option value="31">31</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            
                            <div class="btnwrap">
                                <input type="button" value="취소" class="btn wt" id="cancleBtn">
                                <input type="button" value="회원가입" class="btn gray mr0" id="joinBtn">
                            </div>
                        </div>
                    </fieldset>
            </div>
            <!--//sub container-->
        </div>
        
        <div class="layerArea email-detail-pop" style="display: none;">
            <div class="layerBg"></div>
            <div class="popwrap w_type_11">
                <div class="terms_box box_type_2">
                    ■ 개인정보의 수집항목 및 이용<br><br>
                    더한섬닷컴은 별도의 회원가입 절차 없이 대부분의 컨텐츠에 자유롭게 접근할 수 있습니다. 더한섬닷컴의 서비스를 이용하시는 경우 다음의 정보를 고객의 동의를 받아 수집할 수 있으며 선택항목을 입력하지 않아도 서비스 이용에 제한은 없습니다.<br><br>
                    <span style="color:#000; display:block; margin-bottom:12px;">회원가입 및 주문 등 필요시점에 수집하는 개인정보의 범위</span>
                    <table class="tbl_ltype">
                        <caption>회원가입 및 주문 등 필요시점에 수집하는 개인정보의 범위</caption>
                        <colgroup>
                            <col style="width:auto">
                            <col style="width:202px;">
                            <col style="width:103px;">
                            <col style="width:254px;">
                            <col style="width:auto;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">수집 방법</th>
                                <th scope="col">이용 목적</th>
                                <th scope="col">수집 정보</th>
                                <th scope="col">수집 항목</th>
                                <th scope="col">보유 기간</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="frt">간편회원가입</td>
                                <td><strong>신규서비스/상품안내</strong></td>
                                <td>선택</td>
                                <td>이메일</td>
                                <td>회원 탈퇴 시 또는 동의 철회 시</td>
                            </tr>
                        </tbody>
                    </table>
                    <a href="javascript:void(0)" class="btn_close"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
                </div>
            </div>
        </div>
<div>
<input type="hidden" name="CSRFToken" value="b33ea5e0-3808-40af-a10e-a6803ac72893">
</div></form>


<%@include file = "../include/footer.jsp" %>