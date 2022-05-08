
<!-- 8월 올빼미 이벤트 :s -->
<!-- 셋팅시간 -->
<!-- 노출여부 -->
<!-- 8월 올빼미 이벤트  :e -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
<c:when test="${sessionScope.user.mrole == 'ROLE_ADMIN'}">
<%@include file="admin/admin_header.jsp" %>
</c:when>
<c:otherwise>
<%@include file="include/header.jsp" %>
</c:otherwise>
</c:choose>\
    <!-- //201803 util menu -->
		<!-- //headerWrap -->
		
		<script type="text/javascript">
        var newItemsSlider = "";
        var bestItemsSlider = "";
        var newProductCategory = "";
        var bestProductCategory = "";
        var checkInstagramInfo = false;
        var allLinkTemp = [];
        var allUrlTemp = [];
        var allCaptionTemp = [];
        var allIndex = 0;
        var accountCount = 0;
        var horiz = $(".horiz_topbanner").length;
        
        var rate_en = "";
        var symbol_en = "";
        var rate_zh = "";
        var symbol_zh = "";
        
        $(document).ready(function(){
            var todayDate = new Date(); 
            
            if(getCookie('newYearPopup2022') != todayDate.getDate()) {
                var startNewYear = new Date('2022/01/25 21:00:00'), endNewYear = new Date('2022/02/01 23:59:59');
                if (todayDate.getTime() >= startNewYear.getTime() && todayDate.getTime() <= endNewYear.getTime()) {
                    layerPopup9('open'); 
                }
            }
            
            if(getCookie('HSlayerPopup3') != todayDate.getDate()) { // 추석
                var startDate1 = new Date('2020/09/26 12:00:00'), endDate1 = new Date('2020/10/03 23:59:59');
                if (todayDate.getTime() >= startDate1.getTime() && todayDate.getTime() <= endDate1.getTime()) {
                    layerPopup6('open');
                }
            }
            if(getCookie('newYearPopup') != todayDate.getDate()) { //설날
                var startNewYear = new Date('2020/01/20 00:00:00'), endNewYear = new Date('2020/01/28 00:00:00');
                if (todayDate.getTime() >= startNewYear.getTime() && todayDate.getTime() < endNewYear.getTime()) {
                    layerPopup7('open'); //설날
                }
            }
            
           //설날 공지 팝업(2021)
            if(getCookie('newYearPopup2021') != todayDate.getDate()) {
                var startNewYear = new Date('2021/02/03 11:59:59'), endNewYear = new Date('2021/02/14 23:59:59');
                if (todayDate.getTime() >= startNewYear.getTime() && todayDate.getTime() <= endNewYear.getTime()) {
                	layerPopup9('open'); 
                }
            }

            //추석 공지 팝업(2021)
            if(getCookie('chuseokPopup2021') != todayDate.getDate()) {
                var startChuseok = new Date('2021/09/15 16:00:00'), endChuseok = new Date('2021/09/21 23:59:59');
                if (todayDate.getTime() >= startChuseok.getTime() && todayDate.getTime() <= endChuseok.getTime()) {
                    layerPopup11('open'); 
                }
            }
            
         	//통합 멤버십 약관 제정 안내 팝업(2021/03/01~2021/03/07)
            if(getCookie('membershipInfoMain') == "") {
                var startMemberInfoMain = new Date('2021/03/01 00:00:00'), endMemberInfoMain = new Date('2021/03/07 23:59:59');
                //유효기간 validation
                if (todayDate.getTime() >= startMemberInfoMain.getTime() && todayDate.getTime() <= endMemberInfoMain.getTime()) {
                	//팝업 호출
                	layerPopup10('open'); 
                }
            } 
            if(horiz > 0) {
                $("#mainNoticeWrap").css("top","230px");
                $(".popWrap1901").css("top", "78px");
            }
            
            mainSlider1903();
            edtSlider1903();
            videoPlay1903();
            
            $.ajax({
            	type: "get",
            	url : "/resources/ko/intro/mainCategoryList",
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                	if(result.length > 0) {
                		var newHtml = "";
                		var bestHtml = "";
                		var newCount = 0;
                		var bestCount = 0;
                		var isoCode = "ko";
                		var categoryName = "";
                		
                		for(var i=0; i < result.length; i++) {
                			if(isoCode == "ko") {
                				categoryName = result[i].categoryName;
                			} else if(isoCode == "en") {
                				categoryName = result[i].categoryNameEN;
                			} else if(isoCode == "zh") {
                				categoryName = result[i].categoryNameZH;
                			}
                			
               				if(result[i].displayTypeYn == true) {
	                			if(result[i].displayType == true) {
		                			if(newCount == 0) {
		                				newProductCategory = result[i].categoryCode;
		                				newHtml += '<li class="on">';
		                			} else {
		                				newHtml += '<li>';
		                			}
		                			
		                			newHtml += '	<a href="javascript:getNewProductList(\''+result[i].categoryCode+'\')" onclick="GA_Event(\'메인\', \'신상품\', \''+categoryName+'\');">'+categoryName+'</a>';
		                			newHtml += '</li>';
		                			newCount++;
	                			} else if(result[i].displayType == false) {
	                				if(bestCount == 0) {
	                					bestProductCategory = result[i].categoryCode;
	                					bestHtml += '<li class="on">';
		                			} else {
		                				bestHtml += '<li>';
		                			}
		                			
	                				bestHtml += '	<a href="javascript:getBestProductList(\''+result[i].categoryCode+'\')" onclick="GA_Event(\'메인\', \'베스트\', \''+categoryName+'\');">'+categoryName+'</a>';
	                				bestHtml += '</li>';
	                				bestCount++;
	                			}
               				}
                		}
                		$(".nbe_cnt.new .product_left_menu > ul").html(newHtml);
                		tabNew();
                		getNewProductList(newProductCategory);
                		$(".nbe_cnt.best .product_left_menu > ul").html(bestHtml);
                		tabBest();
                		getBestProductList(bestProductCategory);
                	}
                }
            });
            
            getMagazineList();
            
            var getUrlParameter = function getUrlParameter(sParam) {//URL에 포함된 파라미터 이용하기
                var sPageURL = window.location.search.substring(1),
                    sURLVariables = sPageURL.split('&'),
                    sParameterName,
                    i;
                for (i = 0; i < sURLVariables.length; i++) {
                    sParameterName = sURLVariables[i].split('=');
                    if (sParameterName[0] === sParam) {
                        return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
                    }
                }
            };
            //layerPopup front test (노출 기한 상관 없이 pk 이용하여 메인에서 팝업 보기)
            var pop1 = getUrlParameter('pop1'); 
            if (typeof pop1 == "undefined") pop1 = "N";
            
            $.ajax({
                type: "get",
                url : "/resources/ko/svcenter/mainNotice",
                cache : false,
                data: {"pop1":pop1},
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){     
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                    var todayDate = new Date(); 
                    var switchMain = "";
                    if(result.length > 0) switchMain = result[0].readCount;
                    if("N" != switchMain){//switchMain = "N" 이면 메인팝업 기존방식(하드코딩)으로 돌리기 
                        if(result.length > 0) {
                            var documentResult="";
                            var isocode = "ko";
                            for(var i = 0 ; i < result.length ; i ++ ){
                                var showYn = "N";
                                if(getCookie(result[i].pk+isocode) != todayDate.getDate()) showYn = "Y"; // 오늘은 그만보기
                                if(pop1 != "N") showYn = "Y"; //팝업 미리보기
                                if(showYn == "Y") {
                                     if(null != result[i].bgImage && "" != result[i].bgImage.trim()) {
                                        documentResult += "<div class='popwrap_renewal1910 txtonimg add1' id='"+result[i].pk+isocode+"'>";
                                        documentResult += "<img src='"+result[i].bgImage+"' alt='' class='pop_backimg'>";
                                     } else {
                                         documentResult += "<div class='popwrap_renewal1910' id='"+result[i].pk+isocode+"'>";
                                     }
                                     documentResult += "    <div class='pop_cnt'>";
                                     if(null != result[i].noticeContentsYN && result[i].noticeContentsYN) {//단순 텍스트 출력 시 title 노출, html 포함 출력 시 title 비노출(html 코드에 title 포함)
                                         if(null != result[i].noticeTitle && "" != result[i].noticeTitle.trim()) {
                                             var noticeTitle = result[i].noticeTitle;
                                             var replacedTitle = noticeTitle.replace(/(?:\r\n|\r|\n)/g, '<br>');
                                             documentResult += '<h3 class="pop_tlt">'+replacedTitle+'</h3>';
                                         }
                                     } 
                                     if(null != result[i].noticeContents && "" != result[i].noticeContents.trim()){
                                         if(result[i].noticeContentsYN) {
                                             documentResult += "        <p class='pop_txt'>";
                                         } else {//html 코드 출력
                                             documentResult += "        <p class='pop_txt' style='min-height: 0; padding: 25px 0 0 0;'>";
                                         }
                                         var noticeContents = result[i].noticeContents;
                                         var replacedContents = noticeContents.replace(/(?:\r\n|\r|\n)/g, '<br>');
                                         documentResult +=                replacedContents;
                                         documentResult += "        </p>";
                                     }
                                     if(null != result[i].bannerLink && "" != result[i].bannerLink.trim()){
                                         documentResult += "        <div class='linkbox'>";
                                         documentResult += "            <a href='"+result[i].bannerLink+"'>";
                                        if(null != result[i].bannerLinkText && "" != result[i].bannerLinkText.trim()) documentResult += result[i].bannerLinkText;
                                         documentResult += "            </a>";
                                         documentResult += "        </div>";
                                     }
                                     documentResult += "    </div>";
                                     documentResult += "    <div class='btnwrap'>";
                                     documentResult += "        <input type='button' class='btn stoptoday closeLayerPopup' value=\"오늘은 그만보기 \">";
                                     documentResult += "        <input type='button' class='btn close closeLayerPopup' value=\"닫기\">";
                                     documentResult += "    </div>";
                                     documentResult += "    <a href='#' class='btn_close closeLayerPopup'><img src='/resources/_ui/desktop/common/images/popup/ico_close.png' alt=\"닫기\"></a>";
                                     documentResult += "</div>";
                                }
                            }
                            $("#mainNoticeWrap").html(documentResult);
                            
                            $(".closeLayerPopup").on("click", function(){
                                if($(this).hasClass("stoptoday")){//오늘은 그만보기
                                    var todayDate = new Date(); 
                                    var cookieId = $(this).parents(".popwrap_renewal1910").attr("id");
                                    setCookie(cookieId, todayDate.getDate(),1);
                                }
                                $(this).parents(".popwrap_renewal1910").css("display","none");
                            });
                            
                        }
                    } else {
                        // 한섬마일리지 조회/사용불가
                        if(getCookie('HSlayerPopup3') != todayDate.getDate()) {
                            var startDate1 = new Date('2018/12/28 16:00:00'), endDate1 = new Date('2019/02/31 00:00:00');
                            if (todayDate.getTime() >= startDate1.getTime() && todayDate.getTime() <= endDate1.getTime()) {
                                //layerPopup6('open');
                            }
                        }
                    }
                }
            });
                     
            $(".closeLayerPopup").on("click", function(){
                if($(this).hasClass("stoptoday")){//오늘은 그만보기
                    var todayDate = new Date(); 
                    var cookieId = $(this).parents(".popwrap_renewal1910").attr("id");
                    setCookie(cookieId, todayDate.getDate(),1);
                }
                $(this).parents(".popwrap_renewal1910").css("display","none");
            });
            
            //추천 상품 호출
            getProductInfo("RECOMMEND");
            //비로그인 상태에서 메인페이지 진입시 쿠키 삭제 
            
                deletecookiePath("UID", "/");           
                deletecookiePath("criteoEmail", "/");   
                deletecookiePath("memberGb", "/");
            
            
            var todayDate = new Date();
            
            //전환된 회원일 경우 처리
            
            
            //전환가입유도 팝업
            
           
            //자동로그인 팝업
            
                    var ssoUrl = "https://sso.h-point.co.kr:29865" + "/resources/co/setSsoReqJSONP.hd";
                    gfnSsoReqAjax(ssoUrl, ssoTokenSuc);
                
            
            //인스타그램 생성 --START-- 중국어 인스타 그램 제외
            
            $.ajax({
    	        type: "get",
    	        url : "/resources/ko/magazine/getAllInstargram"+"?type=search",
    	        cache : false,
    	        dataType : "json",
    	        async : true,
    	        contentType : "application/json",
    	        error : function( request, status, error ){     
    	            console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
    	        }, 
    	        success : function( result ){
    	            if(result.length > 0){
    	                //정보 보여주기
    	                var allHtml = [];
    	                var account = "", logoImg = "";
    	                var html = "";
    	                accountCount = result.length;
    	                
   	                    for(var i=0; i < result.length; i++){
   	                    	account = result[i].account;
   	                    	logoImg = result[i].accountLogoImage;
   	                    	
   	                        allHtml = JSON.parse(result[i].html).data;
   	                        allHtml.sort(function (a,b) {
                       			return a.created_time > b.created_time ? -1 : a.created_time < b.created_time ? 1 : 0;
                       		});
   	                        
   	                        $.each(allHtml, function(j, v){
                                if(j == 0){
                                    if(v.user.username != "fourm_official" && v.user.username != "youarehandsome"){
                                        html += '<li class="swiper-slide">';
                                        html += '    <a href="' + '/ko/magazine/instagram"' + ' onclick="GA_main(\'moment\',$(this))">';
   		                                html += '       <img src="' + v.images.low_resolution.url + '" class="respon_image" onerror="this.src=\'http://cdn.thehandsome.com/_ui/desktop/common/images/instagram_video_thumb_283.jpg\'" />';
   		                                html += '		<div class="insta_account1903">';
   		                                html += '			<div class="account">';
   		                                html += '				<div class="img_wrap">';
   		                                if(account == v.user.username) {
   		                                html += '					<img src="'+logoImg+'/resources/dims/resize/50x50" alt="brandimg">';
   		                                }
   		                                html += '				</div>';
   		                                html += '				<p>@'+v.user.username+'</p>';
   		                                html += '			</div>';
   		                                html += '		</div>';
   		                                html += '		<div class="insta_pic_info"></div>';
   		                                html += '		<div class="insta_pic_info_txt">';
   		                                if(v.caption != null){
   		                                html += '			<p class="title">' + v.caption.text.normalize('NFC') + '</p>';
   		                                }else{
   		                                html += '          <p class="title"></p>';
   		                                }
   		                                html += '		</div>';
   		                                html += '	</a>';
   		                                html += '	<div class="insta_cover_dim"></div>';
   		                                html += '</li>';
                                    }
                                }
   	                        });
   	                    }
    	            }
                    
    	            $('#instaContents > ul').html(html);
    	            
    	            instagramSlider1903();
    	            instaImgHover();
    	        }
    	    });
        
            //인스타그램 생성 --END--
		
            //룰렛 이벤트
       	     
        var uid = "anonymous";
        var chkUid = ["test1", "test2", "test3", "test4", "test5", "dlwnsdnjs7@yopmail.com",
                      "test6","test7","test8","test10", "dlwnsdnjs70@yopmail.com"];
		var todayRouletteDate = new Date();
		//evt_roulette
		if(getCookie('rouletteEventPopup') != todayRouletteDate.getDate()) {  
			var rouletteStartDate = new Date('2019/10/07 00:00:00'), rouletteEndDate = new Date('2019/11/01 00:00:00');
			//이벤트 기간
			if(todayRouletteDate.getTime() >= rouletteStartDate.getTime() && todayRouletteDate.getTime() < rouletteEndDate.getTime()){
				//통합회원 일때
				if("" == "MEMBER_UNION" || chkUid.indexOf(uid) > -1){
		 	   		$.ajax({
				   		type:"GET",
				        url:"/resources/ko/magazine/event/checkUser",
				        data: {pk:'8799828694912'},
				        success:function(data){
				        	
				        	if(data=="SUCCESS"){
				            	var innerHtml = "";
		
		                          	innerHtml += "<div class=\"popWrap1901\" id=\"popRouletteEvt\" style=\"position:absolute;top:78px;right:10px;z-index:20;\">";
		                            innerHtml += "	<div class=\"popwrap main_banner position1\" style=\"position:relative;\">";
		                            innerHtml += "		<div class=\"pop_cnt\" style=\"position:relative;\">";
		                            innerHtml += "			<img usemap=\"#main_popup\" src=\"http://cdn.thehandsome.com/pc/event/detail/image/190923_event/evt_190917_mainpop.jpg\" alt=\"\"> ";
		                            innerHtml += "			<a href=\"javascript:goRouletteEvent();\" style=\"display:block;overflow:hidden;text-indent:-999em;position:absolute;left:50%;transform:translate3d(-50%,0,0);bottom:40px;width:212px;height:47px;\">지금응모하기</a> ";
		                            innerHtml += "		</div> ";
		                            innerHtml += "		<div class=\"chkbox_cls\" style=\"background:#363636;\"> ";
		                            innerHtml += "			<input type=\"checkbox\" id=\"cls\" onclick=\"rouletteEvtPopClose(\'day_close\')\"><label for=\"cls\">오늘 하루 보지 않기</label> ";
		                            innerHtml += "		</div> ";
		                            innerHtml += "		<a href=\"#\" class=\"btn_close\" onclick=\"rouletteEvtPopClose(\'close\')\">닫기</a> ";
		                            innerHtml += "	</div>";
		                            innerHtml += "</div> ";
		                            
		                            $("#bodyWrap").prepend(innerHtml);
				            		
				            }
				         }
				     });
		 	   }
		    	
			} 
		}
		
		var jeventStartDate = new Date('2019/11/01 00:00:00'), jeventEndDate = new Date('2019/12/31 00:00:00');
	       
        if(location.href.indexOf("www.thehandsome.com") > -1){
            jeventStartDate = new Date('2019/12/01 00:00:00')
        }
        //이벤트 기간
        if(todayDate.getTime() >= jeventStartDate.getTime() && todayDate.getTime() < jeventEndDate.getTime()){
            //통합회원 일때
            if("" == "MEMBER_UNION" || "" == "MEMBER_TRANS"  || chkUid.indexOf(uid) > -1){
                $.ajax({
                    type:"GET",
                    url:"/resources/ko/magazine/event/checkEventPopJoinUser",
                    success:function(data){
                        if(data == "SUCCESS"){
                            
                            var innerHtml = "";
        
                                innerHtml += "<div class=\"layerArea191029\" style=\"display:block;outline:none;\" id=\"joinEventPopup\">";
                                innerHtml += "  <div class=\"layerBg\" style=\"display:block;width:100%;height:100%;position:fixed;top:0;left:0;background:rgba(0,0,0,0.5);z-index:999;\"></div>";
                                innerHtml += "      <div class=\"popwrap notipop_20191127\" style=\"display:block;\">                                                     ";
	                            innerHtml += "          <div class=\"inner_notipop_20191127\">                                                                          ";
	                            innerHtml += "              <img src=\"http://cdn.thehandsome.com/pc/event/detail/image/pc_evt_191127_pop.jpg\" alt=\"쿠폰함 바로가기\">  ";
	                            innerHtml += "              <a href=\"/resources/ko/mypage/voucher\" class=\"go_coupon_page_191127\">쿠폰함 바로가기</a> ";
	                            innerHtml += "          </div>                                                                                                        ";
	                            innerHtml += "          <a href=\"javascript:popClose1911();\" class=\"btn_close\" >닫기</a>                                                       ";
	                            innerHtml += "      </div>                                                                                                            ";
                                innerHtml += "  </div>";
                                innerHtml += "</div> ";
                                
                                $("#bodyWrap").prepend(innerHtml);
                                
                        }
                     }
                 });
           }
        } 
	       
		
		var eventStartDate = new Date('2019/10/29 00:00:00'), eventEndDate = new Date('2019/12/01 00:00:00');
		
		if(location.href.indexOf("www.thehandsome.com") > -1){
			eventStartDate = new Date('2019/11/01 13:00:00')
		}
		//이벤트 기간
		if(todayDate.getTime() >= eventStartDate.getTime() && todayDate.getTime() < eventEndDate.getTime()){
			//통합회원 일때
			if("" == "MEMBER_UNION" || chkUid.indexOf(uid) > -1){
	 	   		$.ajax({
			   		type:"GET",
			        url:"/resources/ko/magazine/event/checkEventPopUser",
			        data: {pk:'8799959734144'},
			        success:function(data){
			        	if(data=="SUCCESS"){
			            	var innerHtml = "";
	    
	                          	innerHtml += "<div class=\"layerArea191029\" style=\"display:block;outline:none;\" id=\"playHandsomeStyle\">";
	                            innerHtml += "	<div class=\"layerBg\" style=\"display:block;width:100%;height:100%;position:fixed;top:0;left:0;background:rgba(0,0,0,0.5);z-index:999;\"></div>";
	                            innerHtml += "		<div class=\"locky_popup_1910\" style=\"position:fixed;top:50%;left:50%;transform:translate3d(-50%, -50%, 0);z-index:1000;\">";
	                            innerHtml += "			<div class=\"pop_inner\" style=\"position:relative;\"> ";
	                            innerHtml += "			<img src=\"http://cdn.thehandsome.com/pc/event/detail/image/191028_event/guide_popup.jpg\" alt=\"guide_popup\" style=\"display:block;\">";
	                            innerHtml += "			<a href=\"javascript:goHandsomeStyleEvent();\" style=\"display:block;width:304px;height:63px;position:absolute;bottom:32px;left:50%;transform:translate3d(-50%, 0, 0);overflow:hidden;text-indent:-999em;\">지금 응모하기</a> ";
	                            innerHtml += "			<a href=\"javascript:popClose1904();\" class=\"pop_close\" style=\"display:block;width:50px;height:50px;position:absolute;top:15px;right:15px;overflow:hidden;text-indent:-9999em;\">닫기</a>";
	                            innerHtml += "			</div>";
	                            innerHtml += "		</div> ";
	                            innerHtml += "	</div>";
	                            innerHtml += "</div> ";
	                            
	                            $("#bodyWrap").prepend(innerHtml);
			            		
			            }
			         }
			     });
	 	   }
		} 
		
    	
	    	for(var i=0; i < $("#edtSlider1903_0 > ul > li .price").length ; i++) {
	    		var exPrice = $("#edtSlider1903_0 > ul > li .price").eq(i).html();
	    		$("#edtSlider1903_0 > ul > li .price").eq(i).html(getExchangePrice(exPrice));
	    	}
	    	
	    	for(var i=0; i < $("#edtSlider1903_1 > ul > li .price").length ; i++) {
	    		var exPrice = $("#edtSlider1903_1 > ul > li .price").eq(i).html();
	    		$("#edtSlider1903_1 > ul > li .price").eq(i).html(getExchangePrice(exPrice));
	    	}
	    	
            // 마케팅 수신 동의 팝업
            
            
            //8월 올빼미 이벤트 팝업
        	//올빼미 테스트
        	var strArray = location.search.split('&');
        	var testDate = "";
        	
        	/* $.each(strArray, function (index, item){
        		if(item.indexOf('testDate') != -1) {
        			var strSubArray = item.split('=');
        			testDate = strSubArray[1];
        		}
        	});
        	
        	if (testDate !== "") {
        		if(parseInt(testDate) >= 20200807200000 && parseInt(testDate) <= 20200807235959 && getCookie('nightEvtFriPopup') != todayDate.getDate()) {
        			layerPopup8('open', 'fri');
        		}
        		if(parseInt(testDate) >= 20200808200000 && parseInt(testDate) <= 20200808235959 && getCookie('nightEvtSatPopup') != todayDate.getDate()) {
        			layerPopup8('open', 'sat');
        		}
        		if(parseInt(testDate) >= 20200809200000 && parseInt(testDate) <= 20200809235959 && getCookie('nightEvtSunPopup') != todayDate.getDate()) {
        			layerPopup8('open', 'sun');
        		}
        	} else {
            	if(false && getCookie('nightEvtFriPopup') != todayDate.getDate()) {
            		layerPopup8('open', 'fri');
            	}
            	if(false && getCookie('nightEvtSatPopup') != todayDate.getDate()) {
            		layerPopup8('open', 'sat');
            	}
            	if(false && getCookie('nightEvtSunPopup') != todayDate.getDate()) {
            		layerPopup8('open', 'sun');
            	}
        	} */
        	
        	// braze 메인 진입시
        	brazeLogCustomEvent("ENTER", "");
        });
      
        
	    
        function getNewProductList(categoryCode) {
        	$.ajax({
        		type: "get",
            	url : "/resources/ko/intro/mainNewProductList"+"?categoryCode="+categoryCode,
                dataType : "json",
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                	var html = "";
                	if(result.length > 0) {
                	    window.sessionStorage.setItem('main_new_ecommerceDataList', JSON.stringify(result));
                		html += '<div class="nbe_cnt_inner swiper-container" id="newListSlider">';
                		html += '	<ul class="items_list swiper-wrapper">';
                		for(var i=0; i < result.length; i++) {
               			html += '		<li class="swiper-slide">';
               			html += '			<div class="item_box">';
                		html += '				<a href="/resources/ko/p/'+result[i].productCode+'" class="item_info1" onclick="javascript:GA_main(\'newImg\',$(this));setEcommerceData('+ i +', \'NEW\', \''+categoryCode+'\');">';
               			html += '					<span class="item_img">';
               			html += '						<img src="'+result[i].T01imageUrl+'/dims/resize/234x353" alt="" name="'+result[i].productName+'" class="respon_image">';
               			html += '					</span>';
               			html += '				</a>';
               			html += '				<a href="/resources/ko/p/'+result[i].productCode+'" class="item_info2" onclick="javascript:GA_main(\'new\',$(this));setEcommerceData('+ i +', \'NEW\', \''+categoryCode+'\');">';
               			html += '					<span class="brand">'+result[i].brandName+'</span>';
               			html += '					<span class="price">'+ getExchangePrice(result[i].price) +'</span>';
               			html += '				</a>';
               			html += '			</div>';
               			html += '		</li>';
                		}
                		html += '	</ul>';
                		html += '<div class="swiper-button-next"></div>';
                        html += '<div class="swiper-button-prev"></div>';
                		html += '</div>';
                		$(".product_list1903 .nbe_cnt.new .nbe_cnt_inner_wrap").html(html);
			        	newProductListSlider1903();
                	} else {
                		$(".product_list1903 .nbe_cnt.new .nbe_cnt_inner_wrap").html(html);
                	}
                }
        	});
        }
        
        function getBestProductList(categoryCode) {
        	$.ajax({
        		type: "get",
            	url : "/resources/ko/intro/mainBestProductList"+"?categoryCode="+categoryCode,
                dataType : "json",
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                	var html = "";
                	if(result.length > 0) {
                	    window.sessionStorage.setItem('main_best_ecommerceDataList', JSON.stringify(result));
                		html += '<div class="nbe_cnt_inner swiper-container" id="bestListSlider">';
                		html += '	<ul class="items_list swiper-wrapper">';
                		for(var i=0; i < result.length; i++) {
               			html += '		<li class="swiper-slide">';
               			html += '			<div class="item_box">';
               			html += '				<a href="/resources/ko/p/'+result[i].productCode+'" class="item_info1" onclick="javascript:setEcommerceData('+ i +', \'BEST\', \''+categoryCode+'\');">';
               			html += '					<span class="item_img">';
               			html += '						<img src="'+result[i].T01imageUrl+'/dims/resize/234x353" alt="" name="'+result[i].productName+'" class="respon_image" onclick="GA_main(\'bestImg\',$(this))">';
               			html += '					</span>';
               			html += '				</a>';
               			html += '				<a href="/resources/ko/p/'+result[i].productCode+'" class="item_info2" onclick="javascript:GA_main(\'best\',$(this));setEcommerceData('+ i +', \'BEST\', \''+categoryCode+'\');">';
               			html += '					<span class="brand">'+result[i].brandName+'</span>';
               			html += '					<span class="price">'+ getExchangePrice(result[i].price) +'</span>';
               			html += '				</a>';
               			html += '			</div>';
               			html += '		</li>';
                		}
                		html += '	</ul>';
                		html += '<div class="swiper-button-next"></div>';
                        html += '<div class="swiper-button-prev"></div>';
                		html += '</div>';
                		$(".product_list1903 .nbe_cnt.best .nbe_cnt_inner_wrap").html(html);
	                	bestProductListSlider1903();
                	}else {
                    	$(".product_list1903 .nbe_cnt.best .nbe_cnt_inner_wrap").html(html);
                    }
                }
        	});
        }
        
        function getMagazineList() {
        	$.ajax({
        		type: "get",
            	url : "/resources/ko/intro/mainMagazine",
                cache : false,
                dataType : "json",
                async : true,
                contentType : "application/json",
                error : function( request, status, error ){
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                }, 
                success : function( result ) {
                	var categoryText = "";
                	var url = "";
                	var html = "";
                	if(result.length > 0) {
                		for(var i=0; i < result.length; i++) {
                			if(result[i].category == "뉴스") {
                				categoryText = "뉴스";
                			} else if(result[i].category == "SPOTLIGHT_ON") {
                				categoryText = "위클리 픽";
                			} else if(result[i].category == "HANDSOME_PEOPLE") {
                				categoryText = "핸썸피플";
                			} else if(result[i].category == "TREND_TO_KNOW") {
                				categoryText = "셀렉션";
                			} else if(result[i].category == "HOW_TO_STYLE") {
                				categoryText = "커버스토리";
                			} else if(result[i].category == "EDITORS_PICK") {
                				categoryText = "스타일 가이드";
                			} else if(result[i].category == "PLAY_PLAY") {
                				categoryText = "플레이";
                			} else if(result[i].category == "SHARP_SOME") {
                                categoryText = "#SOME";
                            }
                			
                			html += '<li class="swiper-slide">';
                			if(result[i].category == "뉴스") {
                			html += '	<a href="/resources/ko/magazine/newsDetail'+result[i].template+'?newsCode='+result[i].pk+'" class="img_wrap" onclick="GA_main(\''+i+'theMagazine\',$(this));">';
                			} else {
                			html += '	<a href="/resources/ko/magazine/editorials/'+result[i].pk+'" class="img_wrap" onclick="GA_main(\''+i+'theMagazine\',$(this));">';
                			}
                			if(result[i].imageUrl.indexOf(".mp4") > -1){
                			    html += '          <video autoplay muted playsinline loop preload="auto" style="width:100%; max-height:352px; auto;outline:none;" poster="">';
                			    html += '          <source src="'+result[i].imageUrl+'" type="video/mp4">';
                			    html += '          </video>';
                            }else{
                                html += '       <img src="'+result[i].imageUrl+'/dims/resize/348x352" alt="매거진이미지">';
                            }
                			
                			
                			html += '	</a>';
                			html += '	<div class="txt_wrap">';
                			html += '		<p class="magazine_tit">'+categoryText+'</p>';
                			html += '		<p class="tit">'+result[i].desktopTitle+'</p>';
                			html += '		<p class="s_t">'+result[i].desktopSubTitle+'</p>';
                			if(result[i].category == "뉴스") {
                			html += '		<a href="/resources/ko/magazine/newsDetail'+result[i].template+'?newsCode='+result[i].pk+'" class="detail" onclick="GA_main(\''+i+'theMagazine\',$(this));">자세히 보기</a>';
                			} else {
                			html += '		<a href="/resources/ko/magazine/editorials/'+result[i].pk+'" class="detail" onclick="GA_main(\''+i+'theMagazine\',$(this));">자세히 보기</a>';
                			}
                			html += '	</div>';
                			html += '</li>';
                			html += '';
                		}
                		$(".the_magazine_wrap1903 .magazine_slider1903 > ul").html(html);
        				magazinSlider1903();
                	}
                }
        	});
        }
        
         // 상단 띠 배너 닫기
        function popClose03() {
            $('.horiz_topbanner, .horiz_topbanner_inner').slideUp();
            if(horiz > 0) {
                $("#mainNoticeWrap").css("top","150px");
            }
        };

        // RECOMMEND 호출 ajax
        function getProductInfo(productOrderCode){
            
            var categorySize = 0;
            var categoryList = "";
            
            $.ajax({
                type: "get",
                url : "/resources/ko/intro/newRecommend",
                cache : false,
                dataType : "json",
                contentType : "application/json",
                error : function( request, status, error ){     
                    console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
                },
                success : function( result ){
                    //추천상풍 리스트
                    
                    var html = "";
                    if(result.length > 0){
                        window.sessionStorage.setItem('main_recommend_ecommerceDataList', JSON.stringify(result));
                    }
                    for(var i = 0; i < result.length; i++) {
                        var image = result[i].imageUrl;
                        if(image.indexOf("_T01") > -1){
                            image = image.replace("_T01","_S01");
                        }
                        
                        html +="<li>";
//                         html +="    <a href=\"javascript:goDetailPagebyRecommend('" + result[i].baseProductCode + "','" + result[i].clicklogRedirectLink + "')\" onclick=\"GA_main('recommend',$(this))\"> \n";
//                         html += '	<a href="/resources/ko/p/'+result[i].productCode+'" class="item_info1" onclick="javascript:GA_main(\'recommend\',$(this));setEcommerceData('+ i +', \'RECOMMEND\', \'\');">';
                        html += '   <a href="javascript:goDetailPagebyRecommend(\'' + result[i].baseProductCode + '\',\'' + result[i].clicklogRedirectLink + '\')" class="item_info1" onclick="javascript:GA_main(\'recommend\',$(this));setEcommerceData('+ i +', \'RECOMMEND\', \'\');">';
                        html +="        <img src=\""+ image +"/resources/dims/resize/289x289\"/resources/> \n";
                        html +="    </a>";
                        html +="    <span class=\"item_info2\">";
                        html += "            <span class=\"brand "+ result[i].brandCode +"\">"+ result[i].brandName +"</span> \n";
                        html += "            <span class=\"title\">"+ result[i].productName +"</span> \n";
                        if(result[i].price === 0) {
                            html += "        <span class=\"price\"></span> \n";  
                        } else {
                            html += "        <span class=\"price\">"+ getExchangePrice(result[i].price) +"</span> \n";
                        }
                        html +="    </span> \n";
                        html +="    <span class=\"flag\"></span> \n";
                        html +="</li>"; 
                    }
                    
                    if(result.length == 0){
                        $(".pickfor_wrap1903").hide();
                    }
                    $("#pickForSlider1903 ul").html(html);
	                pickForSlider1903();
                }
            });
        }
        
        //전환가입
        function hpoinJoin(){
            var url = "/resources/ko/hpoint/transInfo";
            
            $.ajax({
                type:"GET",
                url:url,
                success:function(data){
                    var hdUrl = data.hpUrl + "/resources/cu/join/start.nhd";
                    $("#prtnrId").val(data.pt1002.prtnrId);
                    $("#chnnlId").val(data.pt1002.chnnlId);
                    $("#custNm").val(data.pt1002.custNm);
                    $("#birthDt").val(data.pt1002.birthDt);
                    $("#mophNo").val(data.pt1002.mophNo);
                    $("#chId").val(data.pt1002.chId);
                    $("#custUniqKey").val(data.pt1002.custUniqKey);
                    $("#email").val(data.pt1002.email);
                    $("#sexGbCd").val(data.pt1002.sexGbCd);
                    
                    window.open(hdUrl,"transMember");
                    
                    document.getElementById("ptcoReqnMdaInf").value = "pc";
                    $("#userHiddenForm").attr("action", hdUrl);
                    $("#userHiddenForm").submit();
                    $("#hpMemberLayer").hide();
                },
                error:function(e){
                }
            });
        }
        
        function ssoTokenSuc(data){
            if (data.succYn == "Y") {
                $.ajax({
                    type:"GET",
                    url:"/resources/ko/hpoint/simpleJoinMember",
                    data: {"mcustNo":data.mcustNo},
                    success:function(data){
                        if(data.resultCode == "C"){
                            $("#ssoMcustNo").val(data.mcustNo);
                            layerPopup4('open'); 
                        }
                    },
                    error:function(e){
                    }
                });
            }
        }
        
        //간편회원가입 전송
        function simpJoin(){
            var hdUrl = "https://www.h-point.co.kr/cu/join/simpJoinStart.nhd";
            window.open(hdUrl,"simpStart_window");
            
            document.getElementById("ptcoReqnMdaInf").value = "pc";
            $("#simpJoinForm").attr("action", hdUrl);
            $("#simpJoinForm").submit();
            $("#simpJoinLayer").hide();  
        }
        
        //전환가입 유도 팝업    
        function layerPopup3(division) {
            if(division == "open") {
                $("#hpMemberLayer").show();
            } else if(division == "close") {       
                if($('#memPop').is(":checked")) { 
                    setCookie("memberTransPopup", 'Y', 90);
                }else{ 
                    setCookie("memberTransPopup", 'N', 0);
                }
                $("#hpMemberLayer").hide();
            } else if(division == "oneweek") {       
                if($('#oweek').is(":checked")) { 
                    setCookie("memberTransPopup", 'Y', 7);
                }else{ 
                    setCookie("memberTransPopup", 'N', 0);
                }
                $("#hpMemberLayer").hide();
            }
        }
        //간편가입팝업
        function layerPopup4(division) {
            if(division == "open") {
                $("#simpJoinLayer").show();
            } else {
                $("#simpJoinLayer").hide();  
            }   
        }
        
        function layerPopup6(division) {
            var documentResult = "";
            
            if(division == "open") {
                
//                     documentResult += '<div class="popWrap1901" style="position:fixed;top:90px;right:20px;z-index:3;">                                     ';
// 	                documentResult += '    <div class="popwrap main_banner position1" style="position:relative;">                                          ';
// 	                documentResult += '        <div class="pop_cnt">                                                                                       ';
// 	                documentResult += '            <img usemap="#main_popup" src="http://cdn.thehandsome.com/pc/notice/pc_delivnoti_ko_190906.jpg" alt=""> ';
// 	                documentResult += '            <div class="chkbox_cls">                                                                                ';
// 	                documentResult += '                <input type="checkbox" id="popPos3" name="popPos3" onclick="layerPopup6(\'close\');" > <label for="popPos3">오늘 하루 열지 않음</label>               ';
// 	                documentResult += '            </div>                                                                                                  ';
// 	                documentResult += '        </div>                                                                                                      ';
// 	                documentResult += '        <a href="#" class="btn_close" onclick="layerPopup6(\'close\');">닫기</a>                                           ';
// 	                documentResult += '    </div>                                                                                                          ';
// 	                documentResult += '</div>                                                                                                              ';
	                
	                documentResult += '<div class="popWrap1901" style="position:fixed;top:-22px;right:10px;z-index:20;">                                           ';
		            documentResult += '    <div class="popwrap main_banner position1" style="position:relative;">                                             ';
		            documentResult += '        <div class="pop_cnt" style="position:relative;">                                                               ';
		            documentResult += '            <img src="http://cdn.thehandsome.com/pc/notice/pc_delivnoti_ko_200922.jpg" alt="">                         ';
		            documentResult += '            <a href="/resources/ko/svcenter/notice" style="display:block;overflow:hidden;text-indent:-999em;position:absolute;left:50%;transform:translate3d(-50%,0,0);bottom:5%;width:140px;height:35px;">자세히보기</a>';
		            documentResult += '        </div>                                                                                                         ';
		            documentResult += '        <div class="chkbox_cls" style="background:#363636;">                                                           ';
		            documentResult += '            <input type="checkbox" id="popPos3" name="popPos3" onclick="layerPopup6(\'close\');"> <label for="popPos3">1일 동안 열지 않음</label>            ';
		            documentResult += '        </div>                                                                                                         ';
		            documentResult += '        <a href="#" class="btn_close" onclick="layerPopup6(\'close\');"">닫기</a>                                              ';
		            documentResult += '    </div>                                                                                                             ';
		            documentResult += '</div>                                                                                                                 ';
                    
                    $("#mainPopwrap1").html(documentResult);
                
            } else if(division == "close") {
                
                if($('#popPos3').is(":checked")) {
                    var todayDate = new Date(); 
                    setCookie("HSlayerPopup3",todayDate.getDate(),1);
                }
                $("#mainPopwrap1").data('scroll',$('#mainPopwrap1').scrollTop());
                $("#mainPopwrap1").hide();
            }
        }
      //설날 공지 팝업
        function layerPopup7(division) {
    	  
        	var todayDate = new Date();
        	var endBankCheck = new Date('2020/01/26 06:00:00');
            var documentResult = "";
            if(division == "open") {
                
	                documentResult += '<div class="popWrap1901" style="position:fixed;top:78px;right:10px;z-index:20;"><!--수정 200117--> ';
	                documentResult += '    <div class="popwrap main_banner position1" style="position:relative;">';
	                documentResult += '        <div class="pop_cnt" style="position:relative;">';
	                if(todayDate.getTime() < endBankCheck.getTime()){
	                	documentResult += '            <img src="http://cdn.thehandsome.com/pc/notice/pc_main_popup_holiday_20200122_ko.jpg" alt="2020년 명절배송안내"><!--수정 200117-->';
	                	documentResult += '            <a href="/resources/ko/svcenter/notice" style="display:block;overflow:hidden;text-indent:-999em;position:absolute;left:107px;bottom:10px;width:142px;height:37px;">자세히보기</a><!--수정 200122-->';
	                } else {
	                	documentResult += '            <img src="http://cdn.thehandsome.com/pc/notice/pc_main_popup_holiday_200116_ko.jpg" alt="2020년 명절배송안내"><!--수정 200117-->';
	                	documentResult += '            <a href="/resources/ko/svcenter/notice" style="display:block;overflow:hidden;text-indent:-999em;position:absolute;left:178px;transform:translate3d(-50%,0,0);bottom:29px;width:142px;height:37px;">자세히보기</a><!--수정 200117-->';
	                }
	                documentResult += '        </div>';
	                documentResult += '        <div class="chkbox_cls" style="background:#363636;">';
	                documentResult += '            <input type="checkbox" id="popPos4" name="popPos4" onclick="layerPopup7(\'close\');"><label for="popPos4">1일 동안 열지 않음</label>                      ';
	                documentResult += '        </div>';
	                documentResult += '        <a href="#" class="btn_close" onclick="layerPopup7(\'close\');">닫기</a>';
	                documentResult += '    </div>';
	                documentResult += '</div>';
                

                $("#mainPopwrap1").html(documentResult);
            } else if(division == "close") {
                
                if($('#popPos4').is(":checked")) {
                    var todayDate = new Date(); 
                    setCookie("newYearPopup",todayDate.getDate(),1);
                }
                $("#mainPopwrap1").data('scroll',$('#mainPopwrap1').scrollTop());
                $("#mainPopwrap1").hide();
            }
        }
      
      	//올빼미 8월 이벤트 팝업
        function layerPopup8(division, week) {
        	
        	if(division === "open") {
        		var documentResult = "";

        		if(week === "fri" || week === "sat" || week === "sun") {
        			documentResult += '<div class="layerArea" id="nightEvtPop">';
                    documentResult += '    <div class="layerBg" style="display:block;"></div>';
                    documentResult += '        <div class="popwrap notipop_20190813 images-event-popup" style="display:block;">';
                    documentResult += '            <div class="in-box">';
                    documentResult += '                <div class="in-ab">';
        			if(week === "fri") {
        				documentResult += '        <div class="event-img-zone">';
                        documentResult += '            <img src="http://cdn.thehandsome.com/mobile/event/detail/image/handsome_202008/happy_4hour_mob_popup_img_01.jpg" style="width:100%;" alt="">';
                        documentResult += '        </div>';
                        documentResult += '        <div class="grayCloseCheckBox190821 black">';
                        documentResult += '            <input type="checkbox" id="eventpop_check_fri" onclick="layerPopup8(\'close\', \'fri\');"><label for="eventpop_check">오늘 그만 보기</label>';
                        documentResult += '        </div>';
            		}
            		if(week === "sat") {
            			documentResult += '        <div class="event-img-zone">';
                        documentResult += '            <img src="http://cdn.thehandsome.com/mobile/event/detail/image/handsome_202008/happy_4hour_mob_popup_img_02.jpg" style="width:100%;" alt="">';
                        documentResult += '        </div>';
                        documentResult += '        <div class="grayCloseCheckBox190821 black">';
                        documentResult += '            <input type="checkbox" id="eventpop_check_sat" onclick="layerPopup8(\'close\', \'sat\');"><label for="eventpop_check">오늘 그만 보기</label>';
                        documentResult += '        </div>';
            		}
            		if(week === "sun") {
            			documentResult += '        <div class="event-img-zone">';
                        documentResult += '            <img src="http://cdn.thehandsome.com/mobile/event/detail/image/handsome_202008/happy_4hour_mob_popup_img_03.jpg" style="width:100%;" alt="">';
                        documentResult += '        </div>';
                        documentResult += '        <div class="grayCloseCheckBox190821 black">';
                        documentResult += '            <input type="checkbox" id="eventpop_check_sun" onclick="layerPopup8(\'close\', \'sun\');"><label for="eventpop_check">오늘 그만 보기</label>';
                        documentResult += '        </div>';
            		}
            		documentResult += '                <a href="javascript:void(0);" class="btn_close" onclick="nightEvtPopLayerClose();"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png"></a>';
            		documentResult += '            </div>';
            		documentResult += '        </div>';
            		documentResult += '    </div>';
                    documentResult += '</div>';
        		}
                
                $("#nightEventPopup").html(documentResult);
                
        	} else if(division === "close") {
        		
        		if(week === "fri" && $("#eventpop_check_fri").is(":checked")) {
        			var todayDate = new Date(); 
                    setCookie("nightEvtFriPopup",todayDate.getDate(),1);
        		}
        		
        		if(week === "sat" && $("#eventpop_check_sat").is(":checked")) {
        			var todayDate = new Date(); 
                    setCookie("nightEvtSatPopup",todayDate.getDate(),1);
        		}
        		
        		if(week === "sun" && $("#eventpop_check_sun").is(":checked")) {
        			var todayDate = new Date(); 
                    setCookie("nightEvtSunPopup",todayDate.getDate(),1);
        		}
        		
        		$("#nightEventPopup").data('scroll',$('#mainPopwrap1').scrollTop());
                $("#nightEventPopup").hide();
        	}
        	
        }
      	
      //설날 공지 팝업 (2021)
        function layerPopup9(division) {
    	  
        	var todayDate = new Date();
            var documentResult = "";
            if(division == "open") {
                
	                documentResult += '	<div class="popWrap1901" style="position:fixed;top:-21px;right:10px;z-index:20;"> ';
	                documentResult += '		<div class="popwrap main_banner position1 newyears-pop" style="position:relative;">';
	                documentResult += '        	<div class="pop_cnt" style="position:relative;">';
	                documentResult += '				<img src="http://cdn.thehandsome.com/pc/notice/pc_newyear_ko_220120.jpg" alt="설 연휴 배송 안내">';
	                documentResult += '        		<a href="/resources/ko/svcenter/notice" style="display:block;overflow:hidden;text-indent:-999em;position:absolute;left:50%;transform:translate3d(-50%,0,0);bottom:5%;width:140px;height:35px;">자세히보기</a>';
	                documentResult += '        	</div>';
	                documentResult += '        	<div class="chkbox_cls" style="background:#363636;">';
	                documentResult += '        		<input type="checkbox" id="cls" onclick="layerPopup9(\'close\')"> <label for="cls"> 1일 동안 열지 않음</label>';
	                documentResult += '			</div>';
	                documentResult += '			<a href="javascript:;" class="btn_close" onclick="layerPopup9(\'close\')">닫기</a>';
	                documentResult += '		</div>';
                	documentResult += '	</div>';
                

                $("#mainPopwrap1").html(documentResult);
            } else if(division == "close") {
                
                if($('#cls').is(":checked")) {
                    var todayDate = new Date(); 
                    setCookie("newYearPopup2022",todayDate.getDate(),1);
                }
                $("#mainPopwrap1").data('scroll',$('#mainPopwrap1').scrollTop());
                $("#mainPopwrap1").hide();
            }
        }

        //추석 공지 팝업 (2021)
        function layerPopup11(division) {
            
            var todayDate = new Date();
            var documentResult = "";
            if(division == "open") {
                
                    documentResult += ' <div class="popWrap1901" style="position:fixed;top:78px;right:10px;z-index:20;"> ';
                    documentResult += '     <div class="popwrap main_banner position1 newyears-pop" style="position:relative;">';
                    documentResult += '         <div class="pop_cnt" style="position:relative;">';
                    documentResult += '             <img src="http://cdn.thehandsome.com/pc/notice/pc_thanksgiving_ko_210914.jpg" alt="추석 연휴 배송 안내">';
                    documentResult += '             <a href="/resources/ko/svcenter/notice" style="display:block;overflow:hidden;text-indent:-999em;position:absolute;left:50%;transform:translate3d(-50%,0,0);bottom:5%;width:140px;height:35px;">자세히보기</a>';
                    documentResult += '         </div>';
                    documentResult += '         <div class="chkbox_cls" style="background:#363636;">';
                    documentResult += '             <input type="checkbox" id="cls" onclick="layerPopup11(\'close\')"> <label for="cls"> 1일 동안 열지 않음</label>';
                    documentResult += '         </div>';
                    documentResult += '         <a href="javascript:;" class="btn_close" onclick="layerPopup11(\'close\')">닫기</a>';
                    documentResult += '     </div>';
                    documentResult += ' </div>';
                

                $("#mainPopwrap1").html(documentResult);
            } else if(division == "close") {
                
                if($('#cls').is(":checked")) {
                    var todayDate = new Date(); 
                    setCookie("chuseokPopup2021",todayDate.getDate(),1);
                }
                $("#mainPopwrap1").data('scroll',$('#mainPopwrap1').scrollTop());
                $("#mainPopwrap1").hide();
            }
        }
        
      //통합 멤버십 약관 제정 안내 팝업(21/03/01 00시~ 03/07 23:59:59)
        function layerPopup10(division) {
    	  
        	var todayDate = new Date();
            var documentResult = "";
            if(division == "open") {
                
					//layerPopup 생성
	                documentResult += '	<div class="layerArea"> ';
	                documentResult += ' 	<div class="layerBg" style="display:block;"></div>';
	                documentResult += '     <div class="popwrap notipop_20190813 images-event-popup wd-atuo integration-pop" style="display:block;" tabindex="-1">';
	                documentResult += '			<div class="in-box">';
	                documentResult += '     		<div class="in-ab" style="width:420px; height:421px;">';
	                documentResult += '					<div class="event-img-zone">';
	                documentResult += '						<img src="http://cdn.thehandsome.com/pc/notice/main-popup-integration-img.jpg" alt="한섬 통합 멤버십 이용 약관 제정 안내">';
	                documentResult += '						<a href="http://www.thehandsome.com/ko/svcenter/notice?subject=한섬 통합 멤버십 이용 약관 제정 안내" class="link-btn"><span class="blind">자세한 내용 보기</span></a>';
	                documentResult += '					</div>';
	                documentResult += '					<div class="grayCloseCheckBox190821 black">';
	                documentResult += '						<input type="checkbox" id="eventpop_check" name="eventpop_check" onclick="layerPopup10(\'close\')"><label for="eventpop_check">7일 동안 열지 않음</label>';
	                documentResult += '					</div>';
	                documentResult += '					<a href="javascript:void(0)" class="btn_close" onclick="layerPopup10(\'close\')"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png"></a>';
	                documentResult += '				</div>';
	                documentResult += '			</div>';
	                documentResult += '		</div>';
	                documentResult += '	</div>';

                
                //layerPopup 삽입
                $("#membershipInfoMainWrap").html(documentResult);
            } else if(division == "close") {
                if($('#eventpop_check').is(":checked")) {
                	//쿠키생성 유효기간 쿠키생성일부터 7일 
                    var todayDate = new Date(); 
                    setCookie("membershipInfoMain",todayDate.getDate(),7);
               	}
                $("#membershipInfoMainWrap").data('scroll',$('#membershipInfoMainWrap').scrollTop());
                //popup hide
                $("#membershipInfoMainWrap").hide();
            }
        }
      
    //#1240 recopick 추가
    function goDetailPagebyRecommend(productCode, clickUrl){
        var url = '/ko/p' + "/" + productCode;
        var host = "http://"+ $(location).attr('host') + url +"?type=recommendProd";
        var tempUrl = clickUrl + "&url=" + encodeURI(host);
        window.location.href=tempUrl;
    }
    
    function mainSlider1903() {
        $('.big_banner_inner').each(function(){
            if($(this).hasClass('init')){
                $(this).removeClass('init');
            }
        });
        
        /* 슬라이드 갯수에 따른 loop추가 및 제거(20210222) */
        var bannerIndex1 = $('#mainSlider1903_0 .swiper-slide').length;
        var bannerIndex2 = $('#mainSlider1903_1 .swiper-slide').length;
        var bannerIndex3 = $('#mainSlider1903_2 .swiper-slide').length;
        
        var interleaveOffset = 1;
        var swiperOptions0 = {
            initialSlide:0,
            loop: bannerIndex1 === 1 ? false:true,
            autoplay: {
                delay: 4000,
                autoplayDisableOnInteraction: true,// 쓸어 넘기거나 버튼 클릭 시 자동 슬라이드 정지.
                disableOnInteraction: false,//180911 스와이핑 후에도 자동 롤링 되도록 추가
            },
            loopAdditionalSlides: 6,
            speed: 1000,
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
             	// 20200914 페이징 퍼이를 위한 주석처리
                /* type: 'progressbar', */
            },
            navigation: {
                nextEl: '.swiper-button-next.bigb',
                prevEl: '.swiper-button-prev.bigb',
            },
            simulateTouch:false,
            parallax: true,
            grabCursor: true,
            watchSlidesProgress: true,
            slidesPerView: 'auto',
            centeredSlides:true,
            on: {
                progress: function(){
                    var swiper = this;
                    for (var i = 0; i < swiper.slides.length; i++) {
                        var slideProgress = swiper.slides[i].progress,
                                innerOffset = swiper.width * interleaveOffset,
                                innerTranslate = slideProgress * innerOffset;
                        swiper.slides[i].querySelector(".slide-bgimg").style.transform =
                            "translate3d(" + innerTranslate + "px, 0, 0)";
                    }
                },
                touchStart: function() {
                    var swiper = this;
                    for (var i = 0; i < swiper.slides.length; i++) {
                        swiper.slides[i].style.transition = "";
                    }
                },
                setTransition: function(speed) {
                    var swiper = this;
                    for (var i = 0; i < swiper.slides.length; i++) {
                        swiper.slides[i].style.transition = speed + "ms";
                        swiper.slides[i].querySelector(".slide-bgimg").style.transition =
                            speed + "ms";
                    }
                }
            }
        }
            var swiperOptions1 = {
                initialSlide:1,
                loop: bannerIndex2 === 1 ? false:true,
                autoplay: {
                    delay: 4000,
                    autoplayDisableOnInteraction: true,// 쓸어 넘기거나 버튼 클릭 시 자동 슬라이드 정지.
                    disableOnInteraction: false,//180911 스와이핑 후에도 자동 롤링 되도록 추가
                },
                loopAdditionalSlides: 6,
                speed: 1000,
                navigation: {
                    nextEl: '.swiper-button-next.bigb',
                    prevEl: '.swiper-button-prev.bigb',
                },
                parallax: true,
                grabCursor: true,
                watchSlidesProgress: true,
                slidesPerView: 'auto',
                centeredSlides:true,
                on: {
                    progress: function(){
                        var swiper = this;
                        for (var i = 0; i < swiper.slides.length; i++) {
                            var slideProgress = swiper.slides[i].progress,
                                    innerOffset = swiper.width * interleaveOffset,
                                    innerTranslate = slideProgress * innerOffset;
                            swiper.slides[i].querySelector(".slide-bgimg").style.transform =
                                "translate3d(" + innerTranslate + "px, 0, 0)";
                        }
                    },
                    touchStart: function() {
                        var swiper = this;
                        for (var i = 0; i < swiper.slides.length; i++) {
                            swiper.slides[i].style.transition = "";
                        }
                    },
                    setTransition: function(speed) {
                        var swiper = this;
                        for (var i = 0; i < swiper.slides.length; i++) {
                            swiper.slides[i].style.transition = speed + "ms";
                            swiper.slides[i].querySelector(".slide-bgimg").style.transition =
                                speed + "ms";
                        }
                    }
                }
            }
        var swiper2length = $("#mainSlider1903_2 > ul > li").length;
        if(swiper2length > 0){
            swiper2length -= 1;
        }
                var swiperOptions2 = {
                    initialSlide: swiper2length ,
                    loop: bannerIndex3 === 1 ? false:true,
                    autoplay: {
                        delay: 4000,
                        autoplayDisableOnInteraction: true,// 쓸어 넘기거나 버튼 클릭 시 자동 슬라이드 정지.
                        disableOnInteraction: false,//180911 스와이핑 후에도 자동 롤링 되도록 추가
                    },
                    loopAdditionalSlides: 6,
                    speed: 1000,
                    navigation: {
                        nextEl: '.swiper-button-next.bigb',
                        prevEl: '.swiper-button-prev.bigb',
                    },
                    parallax: true,
                    grabCursor: true,
                    watchSlidesProgress: true,
                    slidesPerView: 'auto',
                    centeredSlides:true,
                    on: {
                        progress: function(){
                            var swiper = this;
                            for (var i = 0; i < swiper.slides.length; i++) {
                                var slideProgress = swiper.slides[i].progress,
                                        innerOffset = swiper.width * interleaveOffset,
                                        innerTranslate = slideProgress * innerOffset;
                                swiper.slides[i].querySelector(".slide-bgimg").style.transform =
                                    "translate3d(" + innerTranslate + "px, 0, 0)";
                            }
                        },
                        touchStart: function() {
                            var swiper = this;
                            for (var i = 0; i < swiper.slides.length; i++) {
                                swiper.slides[i].style.transition = "";
                            }
                        },
                        setTransition: function(speed) {
                            var swiper = this;
                            for (var i = 0; i < swiper.slides.length; i++) {
                                swiper.slides[i].style.transition = speed + "ms";
                                swiper.slides[i].querySelector(".slide-bgimg").style.transition =
                                    speed + "ms";
                            }
                        }
                    }
        };
        
        $("#mainSlider1903_1").find("div.a_txt_wrap").hide();
        $("#mainSlider1903_2").find("div.a_txt_wrap").hide();
        var swiper01 = new Swiper("#mainSlider1903_0", swiperOptions0);
        var swiper02 = new Swiper("#mainSlider1903_1", swiperOptions1);
        var swiper03 = new Swiper("#mainSlider1903_2", swiperOptions2);
    }
    
    
    function edtSlider1903(){//기획전 슬라이더
        $('.edt_banner_wrap1903 .edt_list1903').each(function(idx){
            var swiper1903 = new Swiper('#edtSlider1903_'+idx, {
                    slidesPerView: 3,
                    freeMode: false,
                    spaceBetween: 11,
                    simulateTouch:true,
                    /* scrollbar: {
                        el: '.swiper-scrollbar.bar'+idx,
                        hide: false,
                    }, */
                    pagination: {
						el: '.edt-swiper-pagination',
					},
                    navigation: {
                        nextEl: '.swiper-button-next.btn'+idx,
                        prevEl: '.swiper-button-prev.btn'+idx,
                    }
            });
            
            if($(this).find('.swiper-slide').length < 4){
                $(this).find('.swiper-button-next, .swiper-button-prev').hide();
            }
        });
    }
    
    function newProductListSlider1903(){//신상품 슬라이더
        var swiper1903 = new Swiper('#newListSlider', {
                slidesPerView: 'auto',
                freeMode: false,
//                 spaceBetween: 7,
                simulateTouch:false,
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                }
        });
    }
    function bestProductListSlider1903(){//베스트 슬라이더
        var swiper1903 = new Swiper('.product_list1903 .nbe_cnt.best .nbe_cnt_inner', {
                slidesPerView: 'auto',
                freeMode: false,
//                 spaceBetween: 7,
                simulateTouch:false,
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                }
        });
    }
    function tabNew(){
        var $newMenu = $('.product_list1903 .nbe_cnt.new .product_left_menu');
        var $newProd = $('.product_list1903 .nbe_cnt.new .nbe_cnt_inner');
        $newMenu.find('a').on('click',function(){
            $newMenu.find('li').removeClass('on');
            $(this).closest('li').addClass('on');
        });
    }
    function tabBest(){
        var $bestMenu = $('.product_list1903 .nbe_cnt.best .product_left_menu');
        var $bestProd = $('.product_list1903 .nbe_cnt.best .nbe_cnt_inner');
        $bestMenu.find('a').on('click',function(){
            $bestMenu.find('li').removeClass('on');
            $(this).closest('li').addClass('on');
        });
    }
    function magazinSlider1903(){
        var swiper1903 = new Swiper('#magazinSlider1903', {
               slidesPerView: 3,
               freeMode: false,
               spaceBetween: 20,
               navigation: {
                   nextEl: '.themagazine_arrow.next',
                   prevEl: '.themagazine_arrow.prev',
               }
        });
        
        $(".the_magazine_wrap1903 .themagazine_arrow.prev").css("opacity", "1");
        $(".the_magazine_wrap1903 .themagazine_arrow.next").css("opacity", "1");
        $(".the_magazine_wrap1903 .magazine_slider1903 ul").css("opacity", "1");
    }//더매거진 슬라이더
    function videoWidth(){
        var target = $('.video_area1903').attr('id');
        var idx = 0;
        var width = $("#"+ target +" div:eq("+idx+")").width();
        var height = $("#"+ target +"  div:eq("+idx+")").height();
        $('#'+target).find('video').css({'width':width+'px','height':height+'px'});
        $('#'+target).css({'width':width+'px','height':height+'px'});
    }
    function videoPlay1903(){
	    $('.video_area1903').children('a').on('click',function(){
	        $(this).find('.video_main').next('video').show();
	        $(this).find('.video_main').hide();
	        $('#video')[0].play();
	    });
    }
    function videoEnded(target, idx){
	    $("#"+ target +" video").hide();
	    $("#"+ target +" div:eq("+idx+")").show();
    }

    function pickForSlider1903(){
        var position = 0;
        var movesize = 206;
        var activeSlide = 3;
        var viewTotalWidth = $("#pickForSlider1903 ul li").size();
        var $slideId = $('#pickForSlider1903 ul');
        //$slideId.width((movesize * viewTotalWidth)+88);
        $slideId.css('left',position);
        for(var i=0;i<2;i++){
            $slideId.find('li:last-child').prependTo("#pickForSlider1903 ul");
        }
        $slideId.find('li:nth-child('+activeSlide+')').addClass('slide_active');
        $('#pickforControls > a').click(function(event){
	        var $target=$(event.target);
	        if($target.is('#pickforControls > .next')){
	            if(position==-movesize){
	                $slideId.css('left',0);
	                $slideId.find('li:first-child').appendTo("#pickForSlider1903 ul");
	                position = 0;
	            }
	            position-=movesize;
	            $slideId.stop().animate({left:position}, 'fast', 'swing',function(){
	                if(position==-movesize){
	                 $slideId.css('left',0);
	                 $slideId.find('li:first-child').appendTo("#pickForSlider1903 ul");
	                 position=0;
	                }
	                activeSlide = 3;
	                $slideId.find('li').removeClass('slide_active');
	                $slideId.find('li:nth-child('+activeSlide+')').addClass('slide_active');
	            });
	
	        }else if($target.is('#pickforControls > .prev')){
	            if(position==0){
	                     $slideId.css('left',-movesize);
	                     $slideId.find('li:last-child').prependTo("#pickForSlider1903 ul");
	                     position=-movesize;
	            }
	            position+=movesize;
	            $slideId.stop().animate({left:position}, 'fast',function(){
	                if(position==0){
	                 $slideId.css('left',-movesize);
	                 $slideId.find('li:last-child').prependTo("#pickForSlider1903 ul");
	                 position=-movesize;
	                }
	                activeSlide = 4;
	             $slideId.find('li').removeClass('slide_active');
	             $slideId.find('li:nth-child('+activeSlide+')').addClass('slide_active');
	            });
	
	        }
		});
        
        $(".pickfor_wrap1903 .controls .prev").css("opacity", "1");
        $(".pickfor_wrap1903 .controls .next").css("opacity", "1");
        $(".pickfor_wrap1903 .pick_for ul").css("opacity", "1");
     }//당신만을 위 추천 슬라이더

     function instagramSlider1903(){
         var swiper1903 = new Swiper('#instaContents', {
                 slidesPerView: 'auto',
                 paginationClickable: false,
                 simulateTouch:false,
                 freeMode: false,
                 loopedSlides: accountCount,
                 spaceBetween: 20,
                 centeredSlides:true,
                 loop:true,
                 speed:600,
                 navigation: {
                     nextEl: '.instagram_arrow.next',
                     prevEl: '.instagram_arrow.prev'
                 }
         });
     }
     
     function instaImgHover(){//인스타 이미지 hover
 		$(".instagram_wrap1903 #instaContents li a > div.insta_pic_info, #instaContents li a > div.insta_pic_info_txt").hide();
 		$(".instagram_wrap1903 #instaContents li > a").hover(function(){
 			$(this).find(".insta_pic_info").stop().fadeIn("easeOutQuart");
 			$(this).find(".insta_pic_info_txt").stop().fadeIn("easeOutQuart");
 			$(this).children('img').addClass('active');
 		},function(){
 			$(this).find(".insta_pic_info, .insta_pic_info_txt").stop().fadeOut("300");
 			$(this).children('img').removeClass('active');
 		});
 	}
     
     function rouletteEvtPopClose(type) {
    	    if(type == "close") {
    	        $('#popRouletteEvt').hide();
    	    }else {
    	    	var date;
    	    	
    	    	$.ajax({
    	    	type : "GET",
    	    	cache: false,
    	    	async: false,
    	    	url: location.href,
    	    	complete: function (req, textStatus){
    	    		var dateString = req.getResponseHeader('Date');
    	    		if(dateString.indexOf('GMT')===-1){
    	    			dateString +=' GMT';
    	    		}
    	    		date = new Date(dateString);
    	    		
    	    		}
    	    	});
    	    	
    	        var todayDate = new Date(date);
    	        setCookie("rouletteEventPopup",todayDate.getDate(),1);
    	        $('#popRouletteEvt').hide();
    	    }
    	}


    	function goRouletteEvent(){
    	    location.href='/ko/magazine/events/8799828694912';
    	}
    	
    	//11월 한섬스타일 이벤트 랜딩
    	function goHandsomeStyleEvent(){
    	    location.href='/ko/magazine/events/8799959734144';
    	}
    	//이벤트 유도팝업 닫기
    	function popClose1904(){ //팝업 닫기
    		$('#playHandsomeStyle').remove();
    	}
    	function popClose1911(){ //팝업 닫기
    		$('#joinEventPopup').remove();
    	}
    	
    	function GA_main(action,e){
    		var index;
    		var label;
    		var eventAction;
    		if(action == "banner"){
    			label = escape(e.find('.title').text());
    			index = parseInt(e.parent().attr('data-swiper-slide-index')) + 1;
    			eventAction = "배너_"+index;
    			
    		} else if (action == "eventBanner"){
    			eventAction = "이벤트_배너";
    			label = escape(e.find('.s_title').text());
    			
    		} else if (action == "exhibitionBanner"){
    			eventAction = "기획전_배너";
    			label = escape(e.find('.s_title').text());
    			
    		} else if (action == "exhibitionListImage0"){
    			eventAction = "기획전_리스트";
    			label = escape(e.parents().find('.edt_banner_inner1 .s_title').text())+"_"+escape(e.parent().find('.title').html());
    			
    		} else if (action == "exhibitionList0"){
    			eventAction = "기획전_리스트";
    			label = escape(e.parents().find('.edt_banner_inner1 .s_title').text())+"_"+escape(e.find('.title').html());
    			
    		} else if (action == "exhibitionListImage1"){
    			eventAction = "기획전_리스트";
    			label = escape(e.parents().find('.edt_banner_inner3 .s_title').text())+"_"+escape(e.parent().find('.title').html());
    			
    		} else if (action == "exhibitionList1"){
    			eventAction = "기획전_리스트";
    			label = escape(e.parents().find('.edt_banner_inner3 .s_title').text())+"_"+escape(e.find('.title').html());
    			
    		} else if (action == "newImg") {
    			eventAction = "신상품";
    			label = escape(e.parents().find('.nbe_cnt.new li.on').text())+"_"+escape(e.find('img').attr('name'));
    			
    		} else if (action == "new") {
    			eventAction = "신상품";
    			label = escape(e.parents().find('.nbe_cnt.new li.on').text())+"_"+escape(e.parent().find('img').attr('name'));
    			
    		} else if (action == "bestImg") {
    			eventAction = "베스트";
    			label = escape(e.parents().find('.nbe_cnt.best li.on').text())+"_"+escape(e.attr('name'));
    			
    		} else if (action == "best") {
    			eventAction = "베스트";
    			label = escape(e.parents().find('.nbe_cnt.best li.on').text())+"_"+escape(e.parent().find('img').attr('name'));
    			
    		} else if (action == "exhibitionVideo"){    		
    			eventAction = "기획영상";
    			label = escape(e.parents().find('.video_main_wrap p.tit').text());
    			
    		} else if (action.indexOf("theMagazine") > -1){
    			action.split("the");
    			index =parseInt(action[0])+1;
    			eventAction = "더매거진";
    			label = index+"_"+ escape(e.parent().find('p.tit').text());
    		} else if (action == "recommend"){
    			eventAction = "당신만을위한추천";
    			label = escape(e.parent().find('.title').text());
    		} else if (action == "moment"){
    			eventAction = "한섬모먼트";
    			label = e.find('.account p').text().substring(1);
    		}
    	
    		
    		GA_Event("메인", eventAction,label);
    	}
    	
		
    	//CMS 컴포넌트 처리용 GA 전자상거래 메인데이터
    	function setEcommerceDataCompnt(productCode, brandName, productName, location){
    	    var listNm = "";
    	    var position;
    	    if(location == "0"){
    	        listNm = "메인_기획전";
    	        position = 1;
    	    }else if(location == "1"){
                listNm = "메인_기획전_하단";
                position = 2;
            }
    	    
            dataLayer.push({
	                'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
	                'ecommerce': {
	                'currencyCode': 'KRW', //통화
	                'click': {
	                'actionField': { 'list': listNm }, //상품 리스트명
	                'products':
		                [{
			                "id": productCode.indexOf("_") > -1 ? productCode.split("_")[0] : productCode, //상품코드
			                "name": productName.replace(/\&#039;/gi,"'"), //상품명
			                "brand": brandName.replace(/\&#039;/gi,"'"), //상품 브랜드
			                "category": "", //상품 카테고리
			                "position": position //상품 위치
		                }]
	                }
                }
            });
            /* Ecommerce data 초기화
            dataLayer에 남아 있는 경우에는 전자상거래 단계만을 위해 사용하는
            필드들이 세팅되어 있으므로 undefined를 통해 초기화합니다. */
            dataLayer.push({
	            'layerCategory' : undefined,
	            'layerAction' : undefined,
	            'nonInteraction' : false,
	            'ecommerce' : undefined
            });
        }
    	
    	//기본 GA 전자상거래 메인데이터
    	function setEcommerceData(idx, type, categoryCode){
    	    var listNm = "";
    	    var position;
    	    var prodList;
    	    
    	    if(type == "NEW"){
    	        prodList = JSON.parse(window.sessionStorage.getItem('main_new_ecommerceDataList'));
    	        if(categoryCode == "WE"){
                    listNm += "메인_신상품_여성";
                    position = 3;
                }else if(categoryCode == "ME"){
                    listNm += "메인_신상품_남성";
                    position = 4;
                }
    	    }else if(type == "BEST"){
    	        prodList = JSON.parse(window.sessionStorage.getItem('main_best_ecommerceDataList'));
    	        if(categoryCode == "WE"){
                    listNm += "메인_베스트_여성";
                    position = 5;
                }else if(categoryCode == "ME"){
                    listNm += "메인_베스트_남성";
                    position = 6;
                }
            }else if(type == "RECOMMEND"){
                
                prodList = JSON.parse(window.sessionStorage.getItem('main_recommend_ecommerceDataList'));
                listNm += "메인_개인화 추천";
                position = 7;
                
    	    }
    	    
    	    if(prodList != null && typeof prodList != undefined){
                if(prodList.length > 0){
                    var prodInfo = prodList[idx];
                    
                    if(listNm != ""){
			    	    dataLayer.push({
					        'event': 'ga_event', 'layerCategory' : 'Ecommerce', 'layerAction' : 'Click','layerLabel' : undefined,
					        'ecommerce': {
					        'currencyCode': 'KRW', //통화
					        'click': {
						        'actionField': { 'list': listNm }, //상품 리스트명
						        'products':
							        [{
		                                'id': prodInfo.baseProductCode.indexOf("_") > -1 ? prodInfo.baseProductCode.split("_")[0] : prodInfo.baseProductCode,  //상품코드
		                                'name': prodInfo.productName, //상품명
		                                'brand': prodInfo.brandName, //상품 브랜드
		                                'category': '', //상품 카테고리
		                                'position': position //상품 위치
		                            }]
						        }
					        }
				        });
			    	    /* Ecommerce data 초기화
			            dataLayer에 남아 있는 경우에는 전자상거래 단계만을 위해 사용하는
			            필드들이 세팅되어 있으므로 undefined를 통해 초기화합니다. */
				        dataLayer.push({
					        'layerCategory' : undefined,
					        'layerAction' : undefined,
					        'nonInteraction' : false,
					        'ecommerce' : undefined
				        });
                    }
                    
                    if(type == "RECOMMEND"){
                        brazeLogCustomEvent(type, idx);
                    }
                }
    	    }
    	}
    	
		function getExchangeRate() {
			$.ajax({
				type : "get",
				url : "/resources/ko/intro/getExchageRate",
				dataType : "json",
				async : false,
				success : function( result ) {
					if(result.length > 0) {
						for(var i=0; i < result.length; i++) {
							if(result[i].currencyCode == "USD") {
								rate_en = result[i].exchangeRate;
								symbol_en = result[i].symbol;
							} else {
								rate_zh = result[i].exchangeRate;
								symbol_zh = result[i].symbol;
							}
						}
					}
				}
			});
		}
		
		function getExchangePrice(price) {
			var exchangePrice = "";
			
					exchangePrice = "₩" + addComma(parseInt(price));
				
			
			return exchangePrice;
		}
        
        // 마케팅수신동의 팝업 닫기
        function maketingAgreeClose() {
            $("#marketingAgreeLayer").hide();
            
        }
        
        // 마케팅수신동의얼럿
        function maketingAgreeAlert() {
        	
        	 
        	 
        	 if ( !$('#emailchk').is(':checked') && !$('#smschk').is(':checked') ) {
                 var lc = new layerConfirm('고객님께서는 마케팅수신 재동의하지 않으셨습니다. 이대로 진행할 경우, 더한섬닷컴에서 진행하는 마케팅 및 이벤트 소식을 받아보실수 없습니다. 진행하시겠습니까?', '확인', '취소');
                 lc.confirmAction = function() {
                     maketingAgreeProcess('N','N');
                 };
             } else if ( $('#emailchk').is(':checked') && !$('#smschk').is(':checked') ) { 
                 var lc = new layerConfirm('고객님께서는 SMS 수신은 동의하지 않으셨습니다. 이대로 진행할 경우, 더한섬닷컴에서 진행하는 마케팅 및 이벤트 소식을 SMS로 받아보실수 없습니다. 진행하시겠습니까?', '확인', '취소');
                 lc.confirmAction = function() {
                     maketingAgreeProcess('Y','N');
                 };
             } else if ( !$('#emailchk').is(':checked') && $('#smschk').is(':checked') ) {
                 var lc = new layerConfirm('고객님께서는 이메일 수신은 동의하지 않으셨습니다. 이대로 진행할 경우, 더한섬닷컴에서 진행하는 마케팅 및 이벤트 소식을 이메일로 받아보실수 없습니다. 진행하시겠습니까?', '확인', '취소');
                 lc.confirmAction = function() {
                     maketingAgreeProcess('N','Y');
                 };
             } else {
                 maketingAgreeProcess('Y','Y');
             }
        	 
        	 
        }
        
        // 마케팅수신동의처리
        function maketingAgreeProcess(emailChkYn, smsChkYn) {
            $.ajax({
                type:"POST",
                url:"/resources/ko/appDownloadSMS/maketingAgree",
                data:{"emailChkYn" : emailChkYn, "smsChkYn" : smsChkYn, "CSRFToken" : "ef80554f-35d8-49d0-9154-b186d4566a0c"},
                error:function(e){
                    console.log(e);
                }
            });
            maketingAgreeClose();
        }
        
        //8월 올빼미 이벤트 팝업 닫기
        function nightEvtPopLayerClose(){
        	$("#nightEvtPop").hide();
	    }
        
        function brazeLogCustomEvent(type, idx){
            var currentActionTime = new Date().format("yyyyMMddHHmmss");
            var prodList;
            
            if(type == "ENTER"){
                appboy.logCustomEvent(
                    "LCE_viewMain",
                    {
                        "accessDate"  : currentActionTime
                    }
                );
            }
            else{ //RECOMMEND
                prodList = JSON.parse(window.sessionStorage.getItem('main_recommend_ecommerceDataList'));
            
                if(prodList != null && typeof prodList != undefined){
                    if(prodList.length > 0){
                        var prodInfo = prodList[idx];
                        //20201222 상품코드 세분화 작업
                        var baseCd  = "";
                        var styleCd = "";
                        var sizeCd  = "";
                        if(prodInfo.baseProductCode.indexOf("_") > -1){
                            var tmp = prodInfo.baseProductCode.split("_");
                            if(tmp.length == 3){ // size
                                baseCd  = tmp[0];
                                styleCd = tmp[1];
                                sizeCd  = tmp[2];
                            }else if(tmp.length == 2){ // color
                                baseCd  = tmp[0];
                                styleCd = tmp[1];
                            }
                        }else{ // base
                            baseCd = prodInfo.baseProductCode;
                        }
                        var productCateKoName = setCategoryNameInKO(prodInfo.productCategoryCode, prodInfo.productCategoryName);
                        appboy.logCustomEvent(
                            "LCE_recommendAreaClick",
                            {
                                "productName" : prodInfo.productName
                               ,"productCode" : baseCd
                               ,"colorCode"   : styleCd
                               ,"sizeCode"    : sizeCd
                               ,"accessDate"  : currentActionTime
                               ,"productCategoryCode" : prodInfo.productCategoryCode
                               ,"productCategoryName" : productCateKoName
                            }
                        );
                    }
                }
            }
        }
	</script>

    <!-- bodyWrap -->
<div id="bodyWrap" style="padding-bottom:0;">
        <!-- layer pop-->
        <div class="notice_pop" id="mainNoticeWrap"></div>
        <div id="mainPopwrap1"></div>
        <div id="mainPopwrap2"></div>
        <div id="nightEventPopup"></div>
        <div id="membershipInfoMainWrap"></div>
        <!-- //layer pop -->
        <!-- main_container-->
        <div class="big_banner1903">
            <div class="swiper-container big_banner_inner" id="mainSlider1903_0">
                <div class="big_banner_frame"></div>
                <ul class="slides swiper-wrapper">
                   <li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220429-pc-main-A-02.jpg?context=bWFzdGVyfGltYWdlc3wyOTM0OTV8aW1hZ2UvanBlZ3xpbWFnZXMvaDQwL2hiNy85Mjk1NjMyNjk1MzI2LmpwZ3xmMGRmZjMxMGFjZDc1M2JiOWJmZWJmMmE3Yzk3N2VjZDM2YmJlMTJhNjQ2OTI0ZjdlYWM0NzdlMGQ3OGQ2MzRk);"></div>
            <a href="/resources/ko/magazine/editorials/8806021781576"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">일상을 빛내는 작가</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">자신의 세계를 시각적으로 그려내는<br>아티스트 켈리박과의 대화</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220429-pc-main-A-02.jpg?context=bWFzdGVyfGltYWdlc3wyOTM0OTV8aW1hZ2UvanBlZ3xpbWFnZXMvaDQwL2hiNy85Mjk1NjMyNjk1MzI2LmpwZ3xmMGRmZjMxMGFjZDc1M2JiOWJmZWJmMmE3Yzk3N2VjZDM2YmJlMTJhNjQ2OTI0ZjdlYWM0NzdlMGQ3OGQ2MzRk" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812575610552"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">The TIMEing</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">자신만의 '포에틱 시퀀스'를 찾아가는<br>타임의 무한한 여정이 펼쳐집니다</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx);"></div>
            <a href="/resources/ko/magazine/editorials/8805989013576"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">타임옴므가 꿈꾸는 여름</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">데님과 파스텔 컬러가 조화로운<br>타임옴므 온라인 전용 컬렉션</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812608542392"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">HOLIDAY GIFT</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">고마운 마음을 전하는 계절<br>특별한 선물로 마음을 표현하세요</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812640917176"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PANTS FIT GUIDE</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">핏가이드로 똑똑하게 쇼핑하는 법<br>더한섬닷컴 X 와이즐리 사은품 EVENT</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0);"></div>
            <a href="/resources/ko/magazine/events/8803957397376"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">5월의 신규가입 Event</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">첫 구매하신 고객님께 드리는<br>산뜻한 음료 기프티콘 혜택</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">이벤트 자세히 보기</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812510435000"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PUMA X GARFIELD</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">퓨마의 새로운 콜라보레이션<br>가필드와 함께한 재치있는 스트릿 웨어</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220427-A-thecashmerekids-01.jpg?context=bWFzdGVyfGltYWdlc3w1ODg0NHxpbWFnZS9qcGVnfGltYWdlcy9oNDcvaDYzLzkyOTQ2MjczMDc1NTAuanBnfDEyYmFlMjNjNjVmZmM5NGQ5N2VhMGVlNjljYjIzYzM0YzYyMDQyM2EzNWJkOTVlMTNiNjQ3NTMxODFjNjYwOWY);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812575676088"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">HAPPY KIDS DAY!</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">가정의 달 5월, 선물하기 좋은<br>더캐시미어의 키즈 아이템</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220427-A-thecashmerekids-01.jpg?context=bWFzdGVyfGltYWdlc3w1ODg0NHxpbWFnZS9qcGVnfGltYWdlcy9oNDcvaDYzLzkyOTQ2MjczMDc1NTAuanBnfDEyYmFlMjNjNjVmZmM5NGQ5N2VhMGVlNjljYjIzYzM0YzYyMDQyM2EzNWJkOTVlMTNiNjQ3NTMxODFjNjYwOWY" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg);"></div>
            <a href="/resources/ko/magazine/editorials/8805989046344"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">WOMEN'S T-SHIRTS</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">디자인별 여성 티셔츠 스타일<br>더한섬닷컴 PICK 티셔츠 추천</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
</ul>
            <div class="swiper-pagination"></div>
            </div>
            <div class="swiper-container big_banner_inner init" id="mainSlider1903_1" style="margin-top:-480px;left:1035px;">
                <div class="big_banner_frame"></div>
                <ul class="slides swiper-wrapper">
                   <li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220429-pc-main-A-02.jpg?context=bWFzdGVyfGltYWdlc3wyOTM0OTV8aW1hZ2UvanBlZ3xpbWFnZXMvaDQwL2hiNy85Mjk1NjMyNjk1MzI2LmpwZ3xmMGRmZjMxMGFjZDc1M2JiOWJmZWJmMmE3Yzk3N2VjZDM2YmJlMTJhNjQ2OTI0ZjdlYWM0NzdlMGQ3OGQ2MzRk);"></div>
            <a href="/resources/ko/magazine/editorials/8806021781576"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">일상을 빛내는 작가</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">자신의 세계를 시각적으로 그려내는<br>아티스트 켈리박과의 대화</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220429-pc-main-A-02.jpg?context=bWFzdGVyfGltYWdlc3wyOTM0OTV8aW1hZ2UvanBlZ3xpbWFnZXMvaDQwL2hiNy85Mjk1NjMyNjk1MzI2LmpwZ3xmMGRmZjMxMGFjZDc1M2JiOWJmZWJmMmE3Yzk3N2VjZDM2YmJlMTJhNjQ2OTI0ZjdlYWM0NzdlMGQ3OGQ2MzRk" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812575610552"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">The TIMEing</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">자신만의 '포에틱 시퀀스'를 찾아가는<br>타임의 무한한 여정이 펼쳐집니다</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx);"></div>
            <a href="/resources/ko/magazine/editorials/8805989013576"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">타임옴므가 꿈꾸는 여름</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">데님과 파스텔 컬러가 조화로운<br>타임옴므 온라인 전용 컬렉션</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812608542392"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">HOLIDAY GIFT</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">고마운 마음을 전하는 계절<br>특별한 선물로 마음을 표현하세요</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812640917176"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PANTS FIT GUIDE</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">핏가이드로 똑똑하게 쇼핑하는 법<br>더한섬닷컴 X 와이즐리 사은품 EVENT</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0);"></div>
            <a href="/resources/ko/magazine/events/8803957397376"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">5월의 신규가입 Event</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">첫 구매하신 고객님께 드리는<br>산뜻한 음료 기프티콘 혜택</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">이벤트 자세히 보기</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812510435000"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PUMA X GARFIELD</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">퓨마의 새로운 콜라보레이션<br>가필드와 함께한 재치있는 스트릿 웨어</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220427-A-thecashmerekids-01.jpg?context=bWFzdGVyfGltYWdlc3w1ODg0NHxpbWFnZS9qcGVnfGltYWdlcy9oNDcvaDYzLzkyOTQ2MjczMDc1NTAuanBnfDEyYmFlMjNjNjVmZmM5NGQ5N2VhMGVlNjljYjIzYzM0YzYyMDQyM2EzNWJkOTVlMTNiNjQ3NTMxODFjNjYwOWY);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812575676088"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">HAPPY KIDS DAY!</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">가정의 달 5월, 선물하기 좋은<br>더캐시미어의 키즈 아이템</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220427-A-thecashmerekids-01.jpg?context=bWFzdGVyfGltYWdlc3w1ODg0NHxpbWFnZS9qcGVnfGltYWdlcy9oNDcvaDYzLzkyOTQ2MjczMDc1NTAuanBnfDEyYmFlMjNjNjVmZmM5NGQ5N2VhMGVlNjljYjIzYzM0YzYyMDQyM2EzNWJkOTVlMTNiNjQ3NTMxODFjNjYwOWY" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg);"></div>
            <a href="/resources/ko/magazine/editorials/8805989046344"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">WOMEN'S T-SHIRTS</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">디자인별 여성 티셔츠 스타일<br>더한섬닷컴 PICK 티셔츠 추천</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
</ul>                
            </div>
            <div class="swiper-container big_banner_inner init" id="mainSlider1903_2" style="margin-top:-480px;left:-1035px;">
                <div class="big_banner_frame"></div>
                <ul class="slides swiper-wrapper">
                   <li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220429-pc-main-A-02.jpg?context=bWFzdGVyfGltYWdlc3wyOTM0OTV8aW1hZ2UvanBlZ3xpbWFnZXMvaDQwL2hiNy85Mjk1NjMyNjk1MzI2LmpwZ3xmMGRmZjMxMGFjZDc1M2JiOWJmZWJmMmE3Yzk3N2VjZDM2YmJlMTJhNjQ2OTI0ZjdlYWM0NzdlMGQ3OGQ2MzRk);"></div>
            <a href="/resources/ko/magazine/editorials/8806021781576"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">일상을 빛내는 작가</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">자신의 세계를 시각적으로 그려내는<br>아티스트 켈리박과의 대화</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220429-pc-main-A-02.jpg?context=bWFzdGVyfGltYWdlc3wyOTM0OTV8aW1hZ2UvanBlZ3xpbWFnZXMvaDQwL2hiNy85Mjk1NjMyNjk1MzI2LmpwZ3xmMGRmZjMxMGFjZDc1M2JiOWJmZWJmMmE3Yzk3N2VjZDM2YmJlMTJhNjQ2OTI0ZjdlYWM0NzdlMGQ3OGQ2MzRk" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812575610552"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">The TIMEing</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">자신만의 '포에틱 시퀀스'를 찾아가는<br>타임의 무한한 여정이 펼쳐집니다</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-time-01-pc.jpg?context=bWFzdGVyfGltYWdlc3wyNjE0MTN8aW1hZ2UvanBlZ3xpbWFnZXMvaGJhL2g4ZC85Mjk1NDMwMzIwMTU4LmpwZ3xiNmVmZTAxYWQwM2ZjODJlZDNmNWFjYWFkNWM2MjA2MTVjYWJmMzFhNzQxZDRjZjQ0NjIyZjU1YTk3NTA3NDA4" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx);"></div>
            <a href="/resources/ko/magazine/editorials/8805989013576"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">타임옴므가 꿈꾸는 여름</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">데님과 파스텔 컬러가 조화로운<br>타임옴므 온라인 전용 컬렉션</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-timehomme-02.jpg?context=bWFzdGVyfGltYWdlc3wxMzgxMTF8aW1hZ2UvanBlZ3xpbWFnZXMvaDY1L2hkZi85Mjk1NDM4MjE3MjQ2LmpwZ3w0NmQzMzI4YTk3NmI2YWZjOWE3N2E4M2FjNDYzMmQ4YzdlYzdiMmRiODlhNjE1NTllNDUwOTdmMGIwZmRjNTcx" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812608542392"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">HOLIDAY GIFT</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">고마운 마음을 전하는 계절<br>특별한 선물로 마음을 표현하세요</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-brand-01.jpg?context=bWFzdGVyfGltYWdlc3w4NjU3MXxpbWFnZS9qcGVnfGltYWdlcy9oMjYvaDBkLzkyOTUyMjI3MzQ4NzguanBnfDA5ZDNkMjk5MmU1NThmZTYzODE4YmZhZjY5MmYxY2ZlOGYyOTkxMjM5YTc5NmI4ODExZTE0OTU5NWQwOWM0NWM" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812640917176"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PANTS FIT GUIDE</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">핏가이드로 똑똑하게 쇼핑하는 법<br>더한섬닷컴 X 와이즐리 사은품 EVENT</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220429-A-fitguide-01.jpg?context=bWFzdGVyfGltYWdlc3wxMDExMDV8aW1hZ2UvanBlZ3xpbWFnZXMvaGNhL2hmZC85Mjk1NTQ0ODQ0MzE4LmpwZ3w3YjcwYzEyYzIwMTczNTk4ZGViNmRhYzY1NzcxZTk0Nzk5ZjVmYTBjNGI2MDg4NGUwOGNlNDY4OTIyM2VjYjRj" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0);"></div>
            <a href="/resources/ko/magazine/events/8803957397376"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">5월의 신규가입 Event</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">첫 구매하신 고객님께 드리는<br>산뜻한 음료 기프티콘 혜택</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">이벤트 자세히 보기</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220427-A-5new-03.jpg?context=bWFzdGVyfGltYWdlc3wxMjg1NTh8aW1hZ2UvanBlZ3xpbWFnZXMvaDI5L2hkZS85Mjk1ODEyNjU3MTgyLmpwZ3w5NDE4MDg5MDVkMWNiNjU3NTMxZGE0ZjY5NWRiMjFiM2RlOWVjY2VhMTJhZTI2OGMxZjMyYjYxODA2ZTQ0ZTE0" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812510435000"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#FFFFFF">PUMA X GARFIELD</font>
                                <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
                                <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#FFFFFF">퓨마의 새로운 콜라보레이션<br>가필드와 함께한 재치있는 스트릿 웨어</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#FFFFFF;color:#FFFFFF">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220428-A-puma-02.jpg?context=bWFzdGVyfGltYWdlc3wxODg0NzV8aW1hZ2UvanBlZ3xpbWFnZXMvaGY0L2hlMy85Mjk1MjQwODIyODE0LmpwZ3xmNzdiMTMzMzVjMGM4MGM2MjQ2NzNkMTBmMjYzMzVlMGNkNjExMDI5NTkzYjFkYWY5MGFmMzI2YzYxODE3N2Q0" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220427-A-thecashmerekids-01.jpg?context=bWFzdGVyfGltYWdlc3w1ODg0NHxpbWFnZS9qcGVnfGltYWdlcy9oNDcvaDYzLzkyOTQ2MjczMDc1NTAuanBnfDEyYmFlMjNjNjVmZmM5NGQ5N2VhMGVlNjljYjIzYzM0YzYyMDQyM2EzNWJkOTVlMTNiNjQ3NTMxODFjNjYwOWY);"></div>
            <a href="/resources/ko/magazine/exhibitions/8812575676088"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap left">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">HAPPY KIDS DAY!</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">가정의 달 5월, 선물하기 좋은<br>더캐시미어의 키즈 아이템</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Shop Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220427-A-thecashmerekids-01.jpg?context=bWFzdGVyfGltYWdlc3w1ODg0NHxpbWFnZS9qcGVnfGltYWdlcy9oNDcvaDYzLzkyOTQ2MjczMDc1NTAuanBnfDEyYmFlMjNjNjVmZmM5NGQ5N2VhMGVlNjljYjIzYzM0YzYyMDQyM2EzNWJkOTVlMTNiNjQ3NTMxODFjNjYwOWY" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
<li class="swiper-slide">
            <div class="slide-bgimg" style="background-image:url(http://www.thehandsome.com/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg);"></div>
            <a href="/resources/ko/magazine/editorials/8805989046344"  onclick="GA_main('banner',$(this));">
                <div class="a_txt_wrap ">
                    <p class="title">
                    	<span class="bar-in">
                            <font color="#000000">WOMEN'S T-SHIRTS</font>
                                <span class="ab-bar left" style="background-color:#000000;"></span>
                                <span class="ab-bar right" style="background-color:#000000;"></span>
                            </span>
                    </p>
                    <p class="s_title">
                    	<font color="#000000">디자인별 여성 티셔츠 스타일<br>더한섬닷컴 PICK 티셔츠 추천</font>
                    </p>
                    <div class="shop_now_btn" style="border-color:#000000;color:#000000">Check Out Now</div>
                    </div>
                <div class="v_img">
                    <img src="/resources/medias/220429-A-weeklypick-03.jpg?context=bWFzdGVyfGltYWdlc3w2NzU3OXxpbWFnZS9qcGVnfGltYWdlcy9oYzcvaGM4LzkyOTU1NTEyOTk2MTQuanBnfDU2M2YzZmE5NDlmMDg3MDQ3NDBhNThkNjg2NjFiNjQ5ZTk4MDQ0ODNjMDg1NzIwMWE4Zjg4MGRiZWFkYWU2NTg" alt="" class="entity-img"/resources/>
                </div>
            </a>
                </li>
</ul>                
            </div>
            <div class="swiper-button-prev bigb"></div>
            <div class="swiper-button-next bigb"></div>
        </div>
        <div class="main_container">
            <div class="mid_banner" style="display:none;">
                <div class="banner1 banner1_N" style="display:none;">
			        <a href="/resources/ko/c/we09v/#1_0_0_0_0_14_0_0_0"  onclick="GA_main('eventBanner',$(this));" >
			            <img src="/resources/medias/220428-2-1-mine-01.jpg?context=bWFzdGVyfGltYWdlc3wxMjI4MnxpbWFnZS9qcGVnfGltYWdlcy9oZjYvaDRkLzkyOTUyMjEwNjM3MTAuanBnfGE4Yzc1YTZjNjEzYjA5MTIwYjZiZDE2MGE5N2FjN2I4YzY5NDNkNGI4YjFjYjA3MjUyNDU3YWI1NGMzYjVjMTQ" alt="banner image" />
		                <div class="ban_txt_wrap">
		                    <p class="title">CODE MINE : E</p>
		                    <p class="s_title">마인식으로 새롭게 정의한 아웃도어</p>
		                </div>
			        </a>
			    </div>
			 <div class="banner1 banner1_N" style="display:none;">
			        <a href="/resources/ko/magazine/exhibitions/8812444309176"  onclick="GA_main('eventBanner',$(this));" >
			            <img src="/resources/medias/220421-2-1-tom-01.jpg?context=bWFzdGVyfGltYWdlc3wxNzAyMXxpbWFnZS9qcGVnfGltYWdlcy9oM2YvaDEwLzkyOTMzMzQ5NzAzOTguanBnfDkyMzFkNmU1N2E5MGYxOTdmNTdkMTZkM2ExZTBjZjk1ZTE0NDFhMjQ4MGY3OWMxYTNiY2I4ZGIyODJkYjVhZmQ" alt="banner image" />
		                <div class="ban_txt_wrap">
		                    <p class="title"><font color=white>TOM LIFESTYLE</font></p>
		                    <p class="s_title"><font color=white>봄의 에너지를 담은 테이블웨어</font></p>
		                </div>
			        </a>
			    </div>
			 <div class="banner2 banner2_N" style="display:none;">
			        <a href="/resources/ko/c/we094/#1_0_0_0_0_14_0_0_0"  onclick="GA_main('eventBanner',$(this));" >
			            <img src="/resources/medias/220429-2-2-sjsj-01.jpg?context=bWFzdGVyfGltYWdlc3wxNDQyNHxpbWFnZS9qcGVnfGltYWdlcy9oNmUvaGIxLzkyOTU1NDQ5NzUzOTAuanBnfDBmMjlkODM4YmEyNGNhZjY1ZTBjNjZhZjliMGFmMmM0NTM1ZjBhNjFmMTY0YTU4ODQyZmNjMTgxNDJlMDY5NGM" alt="banner image" />
		                <div class="ban_txt_wrap">
		                    <p class="title"><font color=white>Scent in Tales</font> </p>
		                    <p class="s_title"><font color=white>향을 품은 SJSJ의 캡슐 컬렉션</font></p>
		                </div>
			        </a>
			    </div>
			 </div>
            <div class="edt_banner_wrap1903">
              <h4 class="tit">기획전</h4>
              <div class="edt_banner_inner1">
 <div class="edt_banner">
       <a href="/resources/ko/magazine/exhibitions/8812510271160"  onclick="GA_main('exhibitionBanner',$(this));">
           <img src="/resources/medias/220428-B-obzee.jpg?context=bWFzdGVyfGltYWdlc3w4NTQwM3xpbWFnZS9qcGVnfGltYWdlcy9oNzAvaDNiLzkyOTUyMjE2ODYzMDIuanBnfGRkYTRiNWJmY2IxYTBlNTFjNTZiODM2MTQ2MWZhODhiYmNhNDRiYTRjY2EzYTY1YjgzMWM1ZWExMTc2YTcwYTM" alt="기획전 배너">
           <div class="ban_txt_wrap">
               <span class="sticker" style="background:#99a5d7;">style guide</span>
               <p class="s_title">
                   <font color="#FFFFFF">써머 리조트룩을 재해석한 뉴 컬렉션</font>
               </p>
               <p class="title">
                   <span class="bar-in">
                       <font color="#FFFFFF">YACHTIE OBZÉÉ</font>
                       <span class="ab-bar left" style="background-color:#FFFFFF;"></span>
					   <span class="ab-bar right" style="background-color:#FFFFFF;"></span>
                   </span>
               </p>
           </div>
       </a>
   </div>
   <div class="edt_list1903">
       <div class="edt_list_inner swiper-container" id="edtSlider1903_0">
           <p class="tit">OBZÉÉ SUMMER</p>
           <ul class="swiper-wrapper">
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/OB2C4WOP536W_BL" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WOP536W_BL','OBZEE','[YACHTIE] 프린팅 노트 플리츠 드레스', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WOP536W_BL_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/OB2C4WOP536W_BL" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WOP536W_BL','OBZEE','[YACHTIE] 프린팅 노트 플리츠 드레스', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 프린팅 노트 플리츠 드레스</span>
                           <span class="price">745000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/OB2C4WVT049W_LB" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WVT049W_LB','OBZEE','[YACHTIE] 세일러 칼라 체인 베스트', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WVT049W_LB_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/OB2C4WVT049W_LB" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WVT049W_LB','OBZEE','[YACHTIE] 세일러 칼라 체인 베스트', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 세일러 칼라 체인 베스트</span>
                           <span class="price">995000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/OB2C4WPC324W_CR" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WPC324W_CR','OBZEE','[YACHTIE] 린넨 블렌드 핀턱 와이드 팬츠', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WPC324W_CR_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/OB2C4WPC324W_CR" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WPC324W_CR','OBZEE','[YACHTIE] 린넨 블렌드 핀턱 와이드 팬츠', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 린넨 블렌드 핀턱 와이드 팬츠</span>
                           <span class="price">425000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/OB2C4WOP530W_AB" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WOP530W_AB','OBZEE','[YACHTIE] 벌룬 슬리브 프릴 칼라 드레스', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WOP530W_AB_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/OB2C4WOP530W_AB" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WOP530W_AB','OBZEE','[YACHTIE] 벌룬 슬리브 프릴 칼라 드레스', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 벌룬 슬리브 프릴 칼라 드레스</span>
                           <span class="price">695000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/OB2C4WJC047W_YN" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WJC047W_YN','OBZEE','[YACHTIE] 린넨 블렌드 벨티드 싱글 재킷', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WJC047W_YN_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/OB2C4WJC047W_YN" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WJC047W_YN','OBZEE','[YACHTIE] 린넨 블렌드 벨티드 싱글 재킷', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 린넨 블렌드 벨티드 싱글 재킷</span>
                           <span class="price">645000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/OB2C4WPC338W_BK" class="item_info1" onclick="GA_main('exhibitionListImage0',$(this));setEcommerceDataCompnt('OB2C4WPC338W_BK','OBZEE','[YACHTIE] 핀턱 와이드 쇼츠', '0');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WPC338W_BK_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/OB2C4WPC338W_BK" class="item_info2" onclick="GA_main('exhibitionList0',$(this));setEcommerceDataCompnt('OB2C4WPC338W_BK','OBZEE','[YACHTIE] 핀턱 와이드 쇼츠', '0');">
                           <span class="brand">OBZEE</span>
                           <span class="title">[YACHTIE] 핀턱 와이드 쇼츠</span>
                           <span class="price">395000.0</span>
                       </a>
                   </div>
               </li>
               </ul>
           <div class="edt-swiper-pagination"></div>
       </div>
       <div class="swiper-button-next btn0"></div>
       <div class="swiper-button-prev btn0"></div>
    </div>
</div>
<div class="edt_banner_inner2">
   <div class="edt_banner">
      <ul>
 <li>
            <a href="/resources/ko/magazine/exhibitions/8812509845176"  target="_blank" onclick="GA_main('exhibitionBanner',$(this));">
                <img src="/resources/medias/220428-C-fourm.jpg?context=bWFzdGVyfGltYWdlc3w1Njk0NXxpbWFnZS9qcGVnfGltYWdlcy9oNzcvaGI0LzkyOTUyMjE4ODI5MTAuanBnfDFmN2VlMjFmYTc1N2UwYWY5MDg0MTk0MDgzZDljNDhmYWI0MzE2OWVjZjE2ZDhjOWQ1NDNlYTdjZjg1NWU5YWM" alt="기획전 배너">
                <div class="ban_txt_wrap">
                   <span class="sticker" style="background:#86B404">exclusive</span>
                   <p class="s_title"><font color="#FFFFFF">봄과 여름 사이, 폼더스토어의 새로운 팔레트</font></p>
                   <p class="title"><font color="#FFFFFF">NEW PALETTE</font></p>
               </div>
            </a>
        </li>
<li>
            <a href="/resources/ko/magazine/exhibitions/8812477109944"  onclick="GA_main('exhibitionBanner',$(this));">
                <img src="/resources/medias/220428-C-phillip.jpg?context=bWFzdGVyfGltYWdlc3wxMDk1ODR8aW1hZ2UvanBlZ3xpbWFnZXMvaDI0L2gwMy85Mjk1MjIyMDEzOTgyLmpwZ3xhN2E1MjAzOWE3NWJkNmU0ZTYyYWE3NmNjNjFhODc3MmQ2NDQzZDkwNjg4N2NiNmZhMTBjOWRiNWZkNWUyNjA4" alt="기획전 배너">
                <div class="ban_txt_wrap">
                   <span class="sticker" style="background:#e16a6a;">new</span>
                   <p class="s_title"><font color="#ffffff">현대인을 위한 필립림의 쿨 이지웨어</font></p>
                   <p class="title"><font color="#ffffff">LIVE FREE</font></p>
               </div>
            </a>
        </li>
<li>
            <a href="/resources/ko/magazine/exhibitions/8812477601464"  onclick="GA_main('exhibitionBanner',$(this));">
                <img src="/resources/medias/220428-C-brand.jpg?context=bWFzdGVyfGltYWdlc3w2NTk4NnxpbWFnZS9qcGVnfGltYWdlcy9oNDYvaDQ1LzkyOTUyMjIyMTA1OTAuanBnfGE4NjE3YjVkYjM0OWJiNjFiMDNjZjhiMTZlNmZjNjExNzgzYWIxNjJhZWFkZjE2NjQ5MGZhMzVlZjkxYjVhZjc" alt="기획전 배너">
                <div class="ban_txt_wrap">
                   <span class="sticker" style="background:#e99143;">we love</span>
                   <p class="s_title"><font color="#FFFFFF">발리의 새로운 아이코닉 라인 #CABANA</font></p>
                   <p class="title"><font color="#FFFFFF">BALLY CABANA</font></p>
               </div>
            </a>
        </li>
</ul>
    </div>
</div>
<div class="edt_banner_inner3">
<div class="edt_banner">
       <a href="/resources/ko/magazine/exhibitions/8812182394552"  onclick="GA_main('exhibitionBanner',$(this));">
           <img src="/resources/medias/220428-B-clubmonaco.jpg?context=bWFzdGVyfGltYWdlc3w1OTU2NnxpbWFnZS9qcGVnfGltYWdlcy9oZWYvaDMxLzkyOTUyMjIyNzYxMjYuanBnfDg0Yzg0ZDhkOTYzYzdmMGRkMDE4ODE4Nzk1YjJkODhiN2ViODRmMmNiMDgyMDAwZjRmOGY2YWRlYWQ2NWZhNDA" alt="기획전 배너">
           <div class="ban_txt_wrap">
               <span class="sticker" style="background:#e16a6a;">new</span>
               <p class="s_title">
                   <font color="#ffffff">클럽모나코 22SS 티셔츠 컬렉션</font>
               </p>
               <p class="title">
                   <span class="bar-in">
                       <font color="#ffffff">MODERN & MINIMAL</font>
                       <span class="ab-bar left" style="background-color:#ffffff;"></span>
					   <span class="ab-bar right" style="background-color:#ffffff;"></span>
                   </span>
               </p>
           </div>
       </a>
   </div>
   <div class="edt_list1903">
       <div class="edt_list_inner swiper-container" id="edtSlider1903_1">
           <p class="tit">CLUB MONACO</p>
           <ul class="swiper-wrapper">
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/MM2C3TTS025H4A_MB" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS025H4A_MB','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS025H4A_MB_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/MM2C3TTS025H4A_MB" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS025H4A_MB','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">오픈 칼라 티셔츠</span>
                           <span class="price">158000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/MM2C3TTS022H4A_BL" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS022H4A_BL','CLUB MONACO','컬러 라인 피케 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS022H4A_BL_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/MM2C3TTS022H4A_BL" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS022H4A_BL','CLUB MONACO','컬러 라인 피케 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">컬러 라인 피케 티셔츠</span>
                           <span class="price">128000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/MM2C3TTS035H5A_MB" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS035H5A_MB','CLUB MONACO','히든 버튼 칼라 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS035H5A_MB_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/MM2C3TTS035H5A_MB" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS035H5A_MB','CLUB MONACO','히든 버튼 칼라 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">히든 버튼 칼라 티셔츠</span>
                           <span class="price">158000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/MM2C3TTS025H4E_MT" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS025H4E_MT','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS025H4E_MT_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/MM2C3TTS025H4E_MT" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS025H4E_MT','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">오픈 칼라 티셔츠</span>
                           <span class="price">158000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/MM2C4WTO605MP_BK" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C4WTO605MP_BK','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C4WTO605MP_BK_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/MM2C4WTO605MP_BK" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C4WTO605MP_BK','CLUB MONACO','오픈 칼라 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">오픈 칼라 티셔츠</span>
                           <span class="price">198000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/MM2C3TTS023H4A_WT" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3TTS023H4A_WT','CLUB MONACO','일러스트 프린팅 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3TTS023H4A_WT_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/MM2C3TTS023H4A_WT" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3TTS023H4A_WT','CLUB MONACO','일러스트 프린팅 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">일러스트 프린팅 티셔츠</span>
                           <span class="price">118000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/MM2C4TTO606M_NY" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C4TTO606M_NY','CLUB MONACO','스트라이프 버튼 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C4TTO606M_NY_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/MM2C4TTO606M_NY" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C4TTO606M_NY','CLUB MONACO','스트라이프 버튼 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">스트라이프 버튼 티셔츠</span>
                           <span class="price">258000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/MM2C3KTS042H6E_DG" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3KTS042H6E_DG','CLUB MONACO','라운드넥 니트 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3KTS042H6E_DG_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/MM2C3KTS042H6E_DG" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3KTS042H6E_DG','CLUB MONACO','라운드넥 니트 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">라운드넥 니트 티셔츠</span>
                           <span class="price">258000.0</span>
                       </a>
                   </div>
               </li>
               <li class="swiper-slide">
                   <div class="item_box">
                       <a href="/resources/ko/p/MM2C3KTS012H6E_CR" class="item_info1" onclick="GA_main('exhibitionListImage1',$(this));setEcommerceDataCompnt('MM2C3KTS012H6E_CR','CLUB MONACO','라운드넥 니트 티셔츠', '1');">
                           <span class="item_img">
                                <img src="http://newmedia.thehandsome.com/MM/2C/SS/MM2C3KTS012H6E_CR_T01.jpg/dims/resize/180x272" alt="" class="respon_image">
                           </span>
                       </a>
                       <a href="/resources/ko/p/MM2C3KTS012H6E_CR" class="item_info2" onclick="GA_main('exhibitionList1',$(this));setEcommerceDataCompnt('MM2C3KTS012H6E_CR','CLUB MONACO','라운드넥 니트 티셔츠', '1');">
                           <span class="brand">CLUB MONACO</span>
                           <span class="title">라운드넥 니트 티셔츠</span>
                           <span class="price">238000.0</span>
                       </a>
                   </div>
               </li>
               </ul>
           <div class="edt-swiper-pagination"></div>
       </div>
       <div class="swiper-button-next btn1"></div>
       <div class="swiper-button-prev btn1"></div>
    </div>
</div>
</div>
             
             
            <!-- new & best -->
            <div class="product_list1903">
            <div class="nbe_cnt new">
                <div class="product_left_menu">
                    <h4 class="tit">신상품</h4>
                    <ul><li class="on">   <a href="javascript:getNewProductList('WE')" onclick="GA_Event('메인', '신상품', '여성');">여성</a></li><li>   <a href="javascript:getNewProductList('ME')" onclick="GA_Event('메인', '신상품', '남성');">남성</a></li><li>   <a href="javascript:getNewProductList('WE03')" onclick="GA_Event('메인', '신상품', '포인트 ACC.');">포인트 ACC.</a></li><li>   <a href="javascript:getNewProductList('WE01')" onclick="GA_Event('메인', '신상품', '셀렉티드');">셀렉티드</a></li></ul>
                </div>
                <div class="nbe_cnt_inner_wrap"><div class="nbe_cnt_inner swiper-container swiper-container-horizontal swiper-container-wp8-horizontal" id="newListSlider">   <ul class="items_list swiper-wrapper" style="transform: translate3d(0px, 0px, 0px);">      <li class="swiper-slide swiper-slide-active">         <div class="item_box">            <a href="/ko/p/CM2C5WPC279W_TN" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(0, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CM/2C/SS/CM2C5WPC279W_TN_W01.jpg/dims/resize/234x353" alt="" name="밴딩 와이드 팬츠" class="respon_image">               </span>            </a>            <a href="/ko/p/CM2C5WPC279W_TN" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(0, 'NEW', 'WE');">               <span class="brand">the CASHMERE</span>               <span class="price">₩395,000</span>            </a>         </div>      </li>      <li class="swiper-slide swiper-slide-next">         <div class="item_box">            <a href="/ko/p/MW2C4TTO509W_LE" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(1, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/MW/2C/SS/MW2C4TTO509W_LE_W01.jpg/dims/resize/234x353" alt="" name="테리 캡 슬리브 탑" class="respon_image">               </span>            </a>            <a href="/ko/p/MW2C4TTO509W_LE" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(1, 'NEW', 'WE');">               <span class="brand">CLUB MONACO</span>               <span class="price">₩218,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/SY2C3WSH366WM1_PB" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(2, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/SY/2C/SS/SY2C3WSH366WM1_PB_W01.jpg/dims/resize/234x353" alt="" name="자수 포켓 언밸런스 헴 셔츠" class="respon_image">               </span>            </a>            <a href="/ko/p/SY2C3WSH366WM1_PB" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(2, 'NEW', 'WE');">               <span class="brand">SYSTEM</span>               <span class="price">₩295,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/OB2C4WTO124W_IV" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(3, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/OB/2C/SS/OB2C4WTO124W_IV_W01.jpg/dims/resize/234x353" alt="" name="텍스처 블록 집업 탑" class="respon_image">               </span>            </a>            <a href="/ko/p/OB2C4WTO124W_IV" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(3, 'NEW', 'WE');">               <span class="brand">OBZEE</span>               <span class="price">₩595,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/MN2C3KOT941W_IV" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(4, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/MN/2C/SS/MN2C3KOT941W_IV_W01.jpg/dims/resize/234x353" alt="" name="칼라 니트 가디건" class="respon_image">               </span>            </a>            <a href="/ko/p/MN2C3KOT941W_IV" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(4, 'NEW', 'WE');">               <span class="brand">MINE</span>               <span class="price">₩595,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/LC2C4WSC766W_MB" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(5, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/LC/2C/SS/LC2C4WSC766W_MB_W01.jpg/dims/resize/234x353" alt="" name="크링클 레이스 밴딩 스커트" class="respon_image">               </span>            </a>            <a href="/ko/p/LC2C4WSC766W_MB" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(5, 'NEW', 'WE');">               <span class="brand">LANVIN COLLECTION</span>               <span class="price">₩895,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/CM2C5KOP460W_DB" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(6, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CM/2C/SS/CM2C5KOP460W_DB_W01.jpg/dims/resize/234x353" alt="" name="컬러 블록 세일러 칼라 니트 드레스" class="respon_image">               </span>            </a>            <a href="/ko/p/CM2C5KOP460W_DB" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(6, 'NEW', 'WE');">               <span class="brand">the CASHMERE</span>               <span class="price">₩545,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/TM2C5WJC781W_SG" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(7, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/TM/2C/SS/TM2C5WJC781W_SG_W01.jpg/dims/resize/234x353" alt="" name="패디드 린넨 재킷" class="respon_image">               </span>            </a>            <a href="/ko/p/TM2C5WJC781W_SG" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(7, 'NEW', 'WE');">               <span class="brand">TIME</span>               <span class="price">₩695,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/O22C5WSH393W_WT" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(8, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/O2/2C/SS/O22C5WSH393W_WT_W01.jpg/dims/resize/234x353" alt="" name="오프 숄더 프릴 셔츠" class="respon_image">               </span>            </a>            <a href="/ko/p/O22C5WSH393W_WT" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(8, 'NEW', 'WE');">               <span class="brand">O'2nd</span>               <span class="price">₩298,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/CM2C4WOT127W_WT" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(9, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CM/2C/SS/CM2C4WOT127W_WT_W01.jpg/dims/resize/234x353" alt="" name="백 인버티드 플리츠 후드 점퍼" class="respon_image">               </span>            </a>            <a href="/ko/p/CM2C4WOT127W_WT" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(9, 'NEW', 'WE');">               <span class="brand">the CASHMERE</span>               <span class="price">₩545,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/CN2C3KDR042N_BG" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(10, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CN/2C/SS/CN2C3KDR042N_BG_W01.jpg/dims/resize/234x353" alt="" name="[RE:STUDIO] 드로우스트링 니트 드레스" class="respon_image">               </span>            </a>            <a href="/ko/p/CN2C3KDR042N_BG" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(10, 'NEW', 'WE');">               <span class="brand">FOURM STUDIO</span>               <span class="price">₩395,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/SY2C4TTO046W_DN" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(11, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/SY/2C/SS/SY2C4TTO046W_DN_W01.jpg/dims/resize/234x353" alt="" name="레터링 자수 티셔츠" class="respon_image">               </span>            </a>            <a href="/ko/p/SY2C4TTO046W_DN" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(11, 'NEW', 'WE');">               <span class="brand">SYSTEM</span>               <span class="price">₩235,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/IL2C4WSH931WS_WT" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(12, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/IL/2C/SS/IL2C4WSH931WS_WT_W01.jpg/dims/resize/234x353" alt="" name="[AVN] 오버사이즈 번아웃 도트 셔츠" class="respon_image">               </span>            </a>            <a href="/ko/p/IL2C4WSH931WS_WT" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(12, 'NEW', 'WE');">               <span class="brand">LÄTT</span>               <span class="price">₩595,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/CN2C3WJC117N_LK" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(13, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CN/2C/SS/CN2C3WJC117N_LK_W01.jpg/dims/resize/234x353" alt="" name="[RE:STUDIO] 린넨 블렌드 하프 슬리브 재킷" class="respon_image">               </span>            </a>            <a href="/ko/p/CN2C3WJC117N_LK" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(13, 'NEW', 'WE');">               <span class="brand">FOURM STUDIO</span>               <span class="price">₩295,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/MN2C4WSH266W_WT" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(14, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/MN/2C/SS/MN2C4WSH266W_WT_W01.jpg/dims/resize/234x353" alt="" name="크링클 크롭 셔츠" class="respon_image">               </span>            </a>            <a href="/ko/p/MN2C4WSH266W_WT" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(14, 'NEW', 'WE');">               <span class="brand">MINE</span>               <span class="price">₩375,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/TM2C1WSC624WM3_BK" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(15, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/TM/2C/SS/TM2C1WSC624WM3_BK_W01.jpg/dims/resize/234x353" alt="" name="백 밴딩 인버티드 플리츠 스커트" class="respon_image">               </span>            </a>            <a href="/ko/p/TM2C1WSC624WM3_BK" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(15, 'NEW', 'WE');">               <span class="brand">TIME</span>               <span class="price">₩595,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/O22C4KTO155W_BK" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(16, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/O2/2C/SS/O22C4KTO155W_BK_W01.jpg/dims/resize/234x353" alt="" name="텍스처 블록 퍼프 니트 탑" class="respon_image">               </span>            </a>            <a href="/ko/p/O22C4KTO155W_BK" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(16, 'NEW', 'WE');">               <span class="brand">O'2nd</span>               <span class="price">₩298,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/YN2C0WSC715N_EC" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(17, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/YN/2C/SS/YN2C0WSC715N_EC_W01.jpg/dims/resize/234x353" alt="" name="[palette] 밴딩 플레어 스커트" class="respon_image">               </span>            </a>            <a href="/ko/p/YN2C0WSC715N_EC" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(17, 'NEW', 'WE');">               <span class="brand">FOURM THE STORE</span>               <span class="price">₩118,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/O22C3KTO134W_LN" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(18, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/O2/2C/SS/O22C3KTO134W_LN_W01.jpg/dims/resize/234x353" alt="" name="노트 헴 패널 니트 탑" class="respon_image">               </span>            </a>            <a href="/ko/p/O22C3KTO134W_LN" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(18, 'NEW', 'WE');">               <span class="brand">O'2nd</span>               <span class="price">₩338,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/CM2C4WOP223W_PR" class="item_info1" onclick="javascript:GA_main('newImg',$(this));setEcommerceData(19, 'NEW', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CM/2C/SS/CM2C4WOP223W_PR_W01.jpg/dims/resize/234x353" alt="" name="사이드 드로우스트링 드레스" class="respon_image">               </span>            </a>            <a href="/ko/p/CM2C4WOP223W_PR" class="item_info2" onclick="javascript:GA_main('new',$(this));setEcommerceData(19, 'NEW', 'WE');">               <span class="brand">the CASHMERE</span>               <span class="price">₩545,000</span>            </a>         </div>      </li>   </ul><div class="swiper-button-next"></div><div class="swiper-button-prev swiper-button-disabled"></div></div></div>
            </div>
            <div class="nbe_cnt best">
                <div class="product_left_menu">
                    <h4 class="tit">베스트</h4>
                    <ul><li class="on">   <a href="javascript:getBestProductList('WE')" onclick="GA_Event('메인', '베스트', '여성');">여성</a></li><li>   <a href="javascript:getBestProductList('ME')" onclick="GA_Event('메인', '베스트', '남성');">남성</a></li></ul>
                </div>
                <div class="nbe_cnt_inner_wrap"><div class="nbe_cnt_inner swiper-container swiper-container-horizontal swiper-container-wp8-horizontal" id="bestListSlider">   <ul class="items_list swiper-wrapper" style="transform: translate3d(0px, 0px, 0px);">      <li class="swiper-slide swiper-slide-active">         <div class="item_box">            <a href="/ko/p/CM2C3WPC260W_BK" class="item_info1" onclick="javascript:setEcommerceData(0, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CM/2C/SS/CM2C3WPC260W_BK_W01.jpg/dims/resize/234x353" alt="" name="백 밴딩 원턱 팬츠" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/CM2C3WPC260W_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(0, 'BEST', 'WE');">               <span class="brand">the CASHMERE</span>               <span class="price">₩425,000</span>            </a>         </div>      </li>      <li class="swiper-slide swiper-slide-next">         <div class="item_box">            <a href="/ko/p/YN2C3WSC720N_BK" class="item_info1" onclick="javascript:setEcommerceData(1, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/YN/2C/SS/YN2C3WSC720N_BK_W01.jpg/dims/resize/234x353" alt="" name="[palette] 백 밴딩 셔링 스커트" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/YN2C3WSC720N_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(1, 'BEST', 'WE');">               <span class="brand">FOURM THE STORE</span>               <span class="price">₩158,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/TM2C4KCD164W_BK" class="item_info1" onclick="javascript:setEcommerceData(2, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/TM/2C/SS/TM2C4KCD164W_BK_W01.jpg/dims/resize/234x353" alt="" name="컬러 라인 크로셰 니트 가디건" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/TM2C4KCD164W_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(2, 'BEST', 'WE');">               <span class="brand">TIME</span>               <span class="price">₩495,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/YN2C3TTO613N_BK" class="item_info1" onclick="javascript:setEcommerceData(3, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/YN/2C/SS/YN2C3TTO613N_BK_W01.jpg/dims/resize/234x353" alt="" name="[palette] 스퀘어넥 슬리브리스 탑" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/YN2C3TTO613N_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(3, 'BEST', 'WE');">               <span class="brand">FOURM THE STORE</span>               <span class="price">₩68,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/TM2C4KTOS63W_BK" class="item_info1" onclick="javascript:setEcommerceData(4, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/TM/2C/SS/TM2C4KTOS63W_BK_W01.jpg/dims/resize/234x353" alt="" name="슬리브리스 니트 탑" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/TM2C4KTOS63W_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(4, 'BEST', 'WE');">               <span class="brand">TIME</span>               <span class="price">₩345,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/YN2C3TSH618N_BK" class="item_info1" onclick="javascript:setEcommerceData(5, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/YN/2C/SS/YN2C3TSH618N_BK_W01.jpg/dims/resize/234x353" alt="" name="[palette] 린넨 블렌드 아일렛 가디건" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/YN2C3TSH618N_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(5, 'BEST', 'WE');">               <span class="brand">FOURM THE STORE</span>               <span class="price">₩108,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/CM2C3TTO341NM1_CA" class="item_info1" onclick="javascript:setEcommerceData(6, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CM/2C/SS/CM2C3TTO341NM1_CA_W01.jpg/dims/resize/234x353" alt="" name="[EXCLUSIVE] 라운드넥 자수 티셔츠" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/CM2C3TTO341NM1_CA" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(6, 'BEST', 'WE');">               <span class="brand">the CASHMERE</span>               <span class="price">₩195,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/SY2C4TTO041W_CR" class="item_info1" onclick="javascript:setEcommerceData(7, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/SY/2C/SS/SY2C4TTO041W_CR_W01.jpg/dims/resize/234x353" alt="" name="컬러 라인 레터링 프린팅 탑" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/SY2C4TTO041W_CR" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(7, 'BEST', 'WE');">               <span class="brand">SYSTEM</span>               <span class="price">₩195,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/CM2C4WOP221W_OT" class="item_info1" onclick="javascript:setEcommerceData(8, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CM/2C/SS/CM2C4WOP221W_OT_W01.jpg/dims/resize/234x353" alt="" name="스티치 셔츠 드레스" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/CM2C4WOP221W_OT" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(8, 'BEST', 'WE');">               <span class="brand">the CASHMERE</span>               <span class="price">₩495,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/YS2C1TTO093WZS_LB" class="item_info1" onclick="javascript:setEcommerceData(9, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/YS/2C/SS/YS2C1TTO093WZS_LB_W01.jpg/dims/resize/234x353" alt="" name="[SAINT JAMES] 레반트 18 티셔츠" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/YS2C1TTO093WZS_LB" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(9, 'BEST', 'WE');">               <span class="brand">FOURM THE STORE</span>               <span class="price">₩88,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/LC2C4WPC664W_BG" class="item_info1" onclick="javascript:setEcommerceData(10, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/LC/2C/SS/LC2C4WPC664W_BG_W01.jpg/dims/resize/234x353" alt="" name="셔링 퀼로트 밴딩 팬츠" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/LC2C4WPC664W_BG" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(10, 'BEST', 'WE');">               <span class="brand">LANVIN COLLECTION</span>               <span class="price">₩495,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/YN2C3TSH645N_BK" class="item_info1" onclick="javascript:setEcommerceData(11, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/YN/2C/SS/YN2C3TSH645N_BK_W01.jpg/dims/resize/234x353" alt="" name="[palette] 린넨 블렌드 퍼프 슬리브 가디건" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/YN2C3TSH645N_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(11, 'BEST', 'WE');">               <span class="brand">FOURM THE STORE</span>               <span class="price">₩108,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/TM2C4NPCH61WP1_DM" class="item_info1" onclick="javascript:setEcommerceData(12, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/TM/2C/SS/TM2C4NPCH61WP1_DM_W01.jpg/dims/resize/234x353" alt="" name="디스트로이드 데님 팬츠" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/TM2C4NPCH61WP1_DM" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(12, 'BEST', 'WE');">               <span class="brand">TIME</span>               <span class="price">₩395,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/SJ2C3NPC458W_MB" class="item_info1" onclick="javascript:setEcommerceData(13, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/SJ/2C/SS/SJ2C3NPC458W_MB_W01.jpg/dims/resize/234x353" alt="" name="와이드 크롭 데님 팬츠" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/SJ2C3NPC458W_MB" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(13, 'BEST', 'WE');">               <span class="brand">SJSJ</span>               <span class="price">₩255,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/CM2C4KTO527W_BK" class="item_info1" onclick="javascript:setEcommerceData(14, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/CM/2C/SS/CM2C4KTO527W_BK_W01.jpg/dims/resize/234x353" alt="" name="실크 블렌드 스트라이프 니트 탑" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/CM2C4KTO527W_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(14, 'BEST', 'WE');">               <span class="brand">the CASHMERE</span>               <span class="price">₩345,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/SJ2C3WSC493W_DN" class="item_info1" onclick="javascript:setEcommerceData(15, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/SJ/2C/SS/SJ2C3WSC493W_DN_W01.jpg/dims/resize/234x353" alt="" name="언밸런스 슬릿 플레어 스커트" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/SJ2C3WSC493W_DN" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(15, 'BEST', 'WE');">               <span class="brand">SJSJ</span>               <span class="price">₩255,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/LC2C1WTO236WM2_BK" class="item_info1" onclick="javascript:setEcommerceData(16, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/LC/2C/SS/LC2C1WTO236WM2_BK_W01.jpg/dims/resize/234x353" alt="" name="비딩 레터링 탑" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/LC2C1WTO236WM2_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(16, 'BEST', 'WE');">               <span class="brand">LANVIN COLLECTION</span>               <span class="price">₩585,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/YN2C3TDR455N_BK" class="item_info1" onclick="javascript:setEcommerceData(17, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/YN/2C/SS/YN2C3TDR455N_BK_W01.jpg/dims/resize/234x353" alt="" name="[palette] 퍼프 슬리브 스트라이프 드레스" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/YN2C3TDR455N_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(17, 'BEST', 'WE');">               <span class="brand">FOURM THE STORE</span>               <span class="price">₩198,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/TM2C1TTOS21W_BK" class="item_info1" onclick="javascript:setEcommerceData(18, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/TM/2C/SS/TM2C1TTOS21W_BK_W01.jpg/dims/resize/234x353" alt="" name="[시그니처] 컬러 라인 머플러 티셔츠" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/TM2C1TTOS21W_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(18, 'BEST', 'WE');">               <span class="brand">TIME</span>               <span class="price">₩425,000</span>            </a>         </div>      </li>      <li class="swiper-slide">         <div class="item_box">            <a href="/ko/p/SJ2C4WJC248W_BK" class="item_info1" onclick="javascript:setEcommerceData(19, 'BEST', 'WE');">               <span class="item_img">                  <img src="http://newmedia.thehandsome.com/SJ/2C/SS/SJ2C4WJC248W_BK_W01.jpg/dims/resize/234x353" alt="" name="칼라리스 버튼 재킷" class="respon_image" onclick="GA_main('bestImg',$(this))">               </span>            </a>            <a href="/ko/p/SJ2C4WJC248W_BK" class="item_info2" onclick="javascript:GA_main('best',$(this));setEcommerceData(19, 'BEST', 'WE');">               <span class="brand">SJSJ</span>               <span class="price">₩375,000</span>            </a>         </div>      </li>   </ul><div class="swiper-button-next"></div><div class="swiper-button-prev swiper-button-disabled"></div></div></div>
            </div>
        </div>
        <!-- new & best -->
        </div>
        <!-- //main_container-->
        <!-- video_main_wrap-->
        <div class="video_main_wrap">
            <h4 class="tit"><spring:theme code="main.video.title"></spring:theme></h4>
            <div class="video_area1903" id="videoDiv1903">
               <a href="javascript:void(0);" onclick="GA_main('exhibitionVideo',$(this));">
                  <div class="video_main" style="display: block;">
                     <span class="play_btn"></span>
                     <img src="/resources/medias/220428-D-lanvin-05.jpg?context=bWFzdGVyfGltYWdlc3w2NDY2OHxpbWFnZS9qcGVnfGltYWdlcy9oZWEvaDZlLzkyOTUyMjI2NjkzNDIuanBnfGQyZWVlMmMxMjQxNjAwZTA4YzAyZWQ5ZTBjODJhODA0MjEyYWJkMTAzNzJhYzk3ZTJmM2Y3ZDk3NzYzN2NjYWE" alt="poster">
                  </div>
                  <video id="video" class="video-js" controls="auto" preload="auto" style="display: none; width:884px; height:auto;" onended="videoEnded('videoDiv1903',0)" width="884" height="auto">
                     <source src="http://s3.ap-northeast-2.amazonaws.com/cdn.thehandsome.com-kr/pc/0_main_video/220427_lanvin/lanvin%20collection_22SS.mp4" type="video/mp4">
                  </video>
               </a>
            </div>
            <div class="txt">
               <p class="tit">JOIE VIVE LANVIN<br>SYNDROME</p>
               <p class="s_t">초현실적인 공간에서 만난 랑방컬렉션의<br>명화 같은 2022 SS COLLECTION</p>
            </div>
         </div>
      <!--// video_main_wrap-->
     <!-- main_container-->
     <div class="main_container">
         <!-- the_magazine_wrap1903-->
         <div class="the_magazine_wrap1903">
             <h4 class="tit">THE 매거진</h4>
             <div class="magazine_slider1903 swiper-container swiper-container-horizontal swiper-container-wp8-horizontal" id="magazinSlider1903">
                 <ul class="swiper-wrapper" style="opacity: 1; transform: translate3d(0px, 0px, 0px);"><li class="swiper-slide swiper-slide-active" style="width: 348px; margin-right: 20px;">   <a href="/ko/magazine/editorials/8805956278344" class="img_wrap" onclick="GA_main('0theMagazine',$(this));">          <video autoplay="" muted="" playsinline="" loop="" preload="auto" style="width:100%; max-height:352px; auto;outline:none;" poster="">          <source src="http://cdn.thehandsome.com/mobile/editorial/list/banner/20220426_37524156540121467_ko.mp4" type="video/mp4">          </video>   </a>   <div class="txt_wrap">      <p class="magazine_tit">스타일 가이드</p>      <p class="tit">셔츠라는 이름으로</p>      <p class="s_t">지금부터 주야장천 입고 싶은 셔츠 여섯 가지</p>      <a href="/ko/magazine/editorials/8805956278344" class="detail" onclick="GA_main('0theMagazine',$(this));">자세히 보기</a>   </div></li><li class="swiper-slide swiper-slide-next" style="width: 348px; margin-right: 20px;">   <a href="/ko/magazine/editorials/8805956245576" class="img_wrap" onclick="GA_main('1theMagazine',$(this));">       <img src="http://cdn.thehandsome.com/mobile/editorial/list/banner/20220425_37432381523122232_ko.jpg/dims/resize/348x352" alt="매거진이미지">   </a>   <div class="txt_wrap">      <p class="magazine_tit">스타일 가이드</p>      <p class="tit">행복이 가득한 시간</p>      <p class="s_t">Hello Spring!</p>      <a href="/ko/magazine/editorials/8805956245576" class="detail" onclick="GA_main('1theMagazine',$(this));">자세히 보기</a>   </div></li><li class="swiper-slide" style="width: 348px; margin-right: 20px;">   <a href="/ko/magazine/editorials/8805923477576" class="img_wrap" onclick="GA_main('2theMagazine',$(this));">       <img src="http://cdn.thehandsome.com/pc/editorial/detail/image/20220421_37101894732414733_ko.jpg/dims/resize/348x352" alt="매거진이미지">   </a>   <div class="txt_wrap">      <p class="magazine_tit">위클리 픽</p>      <p class="tit">MEN'S T-SHIRTS</p>      <p class="s_t">4월의 네 번째 위클리 픽</p>      <a href="/ko/magazine/editorials/8805923477576" class="detail" onclick="GA_main('2theMagazine',$(this));">자세히 보기</a>   </div></li><li class="swiper-slide" style="width: 348px; margin-right: 20px;">   <a href="/ko/magazine/editorials/8805890775112" class="img_wrap" onclick="GA_main('3theMagazine',$(this));">       <img src="http://cdn.thehandsome.com/mobile/editorial/list/banner/20220419_36918146632712174_ko.jpg/dims/resize/348x352" alt="매거진이미지">   </a>   <div class="txt_wrap">      <p class="magazine_tit">#SOME</p>      <p class="tit">아나운서 허송연의 <br> 슬기로운 라이프</p>      <p class="s_t">#SONGYEON's CLOSET</p>      <a href="/ko/magazine/editorials/8805890775112" class="detail" onclick="GA_main('3theMagazine',$(this));">자세히 보기</a>   </div></li><li class="swiper-slide" style="width: 348px; margin-right: 20px;">   <a href="/ko/magazine/editorials/8805890742344" class="img_wrap" onclick="GA_main('4theMagazine',$(this));">       <img src="http://cdn.thehandsome.com/mobile/editorial/list/banner/20220415_36571991275663038_ko.gif/dims/resize/348x352" alt="매거진이미지">   </a>   <div class="txt_wrap">      <p class="magazine_tit">셀렉션</p>      <p class="tit">짧을수록 매력적인 <br> 크롭트 &amp; 미니</p>      <p class="s_t">Cropped &amp; Mini Style</p>      <a href="/ko/magazine/editorials/8805890742344" class="detail" onclick="GA_main('4theMagazine',$(this));">자세히 보기</a>   </div></li><li class="swiper-slide" style="width: 348px; margin-right: 20px;">   <a href="/ko/magazine/editorials/8805890709576" class="img_wrap" onclick="GA_main('5theMagazine',$(this));">       <img src="http://cdn.thehandsome.com/pc/editorial/detail/image/20220414_36505332233899612_ko.jpg/dims/resize/348x352" alt="매거진이미지">   </a>   <div class="txt_wrap">      <p class="magazine_tit">위클리 픽</p>      <p class="tit">MINI SKIRT STYLE</p>      <p class="s_t">4월의 세 번째 위클리 픽</p>      <a href="/ko/magazine/editorials/8805890709576" class="detail" onclick="GA_main('5theMagazine',$(this));">자세히 보기</a>   </div></li></ul>
             </div>
             <!--add arrow -->
             <div class="themagazine_arrow next" style="opacity: 1;">다음</div>
             <div class="themagazine_arrow prev swiper-button-disabled" style="opacity: 1;">이전</div>
         </div>
         <!-- //the_magazine_wrap1903-->
         <!--배너영역 -->
         <!--//배너영역 -->
          
        <!-- pick_for-->
        <div class="pickfor_wrap1903">
            <h4 class="tit"><span>당신</span>만을 위한 특별한 추천</h4>
                <div class="pick_for" id="pickForSlider1903">
                <ul class="slides" style="left: 0px; opacity: 1;"><li>   <a href="javascript:goDetailPagebyRecommend('TM2C4WJCH65WP1','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=TM2C4WJCH65WP1&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(18, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/TM/2C/SS/TM2C4WJCH65WP1_BK_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR01">TIME</span> 
         <span class="title">엠블럼 자수 싱글 재킷</span> 
     <span class="price">₩865,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('TM2C1WJCS21WP4','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=TM2C1WJCS21WP4&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(19, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/TM/2C/SS/TM2C1WJCS21WP4_DN_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR01">TIME</span> 
         <span class="title">턴업 재킷 &amp; 스트라이프 머플러</span> 
     <span class="price">₩1,050,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li class="slide_active">   <a href="javascript:goDetailPagebyRecommend('FL2B1HBA007LRL','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2B1HBA007LRL&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(0, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2B/SS/FL2B1HBA007LRL_BR_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[FERM LIVING] 배스 매트</span> 
     <span class="price">₩88,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2B1HTY006LRL','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2B1HTY006LRL&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(1, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2B/SS/FL2B1HTY006LRL_NL_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[FERM LIVING] 우드 트레이 XS</span> 
     <span class="price">₩108,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2B7HBA016LMD','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2B7HBA016LMD&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(2, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2B/FW/FL2B7HBA016LMD_GY_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[METTE DITMER] 쉐이드 칫솔 홀더</span> 
     <span class="price">₩43,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2B7HBA019LMD','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2B7HBA019LMD&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(3, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2B/FW/FL2B7HBA019LMD_LG_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[METTE DITMER] 바이 핸드 솝 홀더</span> 
     <span class="price">₩62,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2B7HBA020LMD','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2B7HBA020LMD&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(4, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2B/FW/FL2B7HBA020LMD_LG_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[METTE DITMER] 바이 핸드 트레이</span> 
     <span class="price">₩110,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('TH2C1NPC673N','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=TH2C1NPC673N&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(5, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/TH/2C/SS/TH2C1NPC673N_DN_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR06">TIME HOMME</span> 
         <span class="title">투턱 데님 팬츠</span> 
     <span class="price">₩275,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2C3HPP010L4X','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2C3HPP010L4X&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(6, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2C/SS/FL2C3HPP010L4X_BK_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[SERAX] 팟마리 모자이크 화분</span> 
     <span class="price">₩40,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2C1HFT009LGT','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2C1HFT009LGT&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(7, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2C/SS/FL2C1HFT009LGT_OL_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[GARDEN TRADING] 트레이 테이블</span> 
     <span class="price">₩85,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2C1HLV013LGT','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2C1HLV013LGT&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(8, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2C/SS/FL2C1HLV013LGT_BK_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[GARDEN TRADING] 페이퍼 빈</span> 
     <span class="price">₩65,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2C1HBA004LGT','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2C1HBA004LGT&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(9, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2C/SS/FL2C1HBA004LGT_WT_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[GARDEN TRADING] 솝 디쉬</span> 
     <span class="price">₩21,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2C1HLV017LGT','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2C1HLV017LGT&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(10, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2C/SS/FL2C1HLV017LGT_SV_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[GARDEN TRADING] 스태킹 스토리지 박스</span> 
     <span class="price">₩103,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2C3HLV002LRL','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2C3HLV002LRL&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(11, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2C/SS/FL2C3HLV002LRL_BK_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[FERM LIVING] 플랜트 스탠드</span> 
     <span class="price">₩55,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('FL2C3HPP014LRL','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=FL2C3HPP014LRL&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(12, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/FL/2C/SS/FL2C3HPP014LRL_GD_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR08">the CASHMERE</span> 
         <span class="title">[FERM LIVING] 헥타곤 팟</span> 
     <span class="price">₩86,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('TH2C1KVT011M','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=TH2C1KVT011M&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(13, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/TH/2C/SS/TH2C1KVT011M_NY_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR06">TIME HOMME</span> 
         <span class="title">스트랩 니트 베스트</span> 
     <span class="price">₩355,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('TH2C4KTN019M','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=TH2C4KTN019M&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(14, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/TH/2C/SS/TH2C4KTN019M_BR_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR06">TIME HOMME</span> 
         <span class="title">실크 블렌드 오픈 칼라 니트 탑</span> 
     <span class="price">₩295,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('TH2C4WJM320M','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=TH2C4WJM320M&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(15, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/TH/2C/SS/TH2C4WJM320M_DG_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR06">TIME HOMME</span> 
         <span class="title">린넨 블렌드 멀티 포켓 점퍼</span> 
     <span class="price">₩830,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('SH2C3KTN031M','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=SH2C3KTN031M&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(16, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/SH/2C/SS/SH2C3KTN031M_BR_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR07">SYSTEM HOMME</span> 
         <span class="title">텍스처 블록 오픈 칼라 니트 탑</span> 
     <span class="price">₩265,000</span> 
 </span> 
 <span class="flag"></span> 
</li><li>   <a href="javascript:goDetailPagebyRecommend('TM2C4KOPS65W','https://lc.recopick.com/1/banner/1919/pick?uid=99132980.1651191215009&amp;source=&amp;pick=TM2C4KOPS65W&amp;method=25&amp;channel=main&amp;reco_type=user-item&amp;product_type=R&amp;reco_list=%5B%22FL2C1HBA004LGT%22%2C%22TM2C5WJC781WP1%22%2C%22TH2C3TRN644N%22%2C%22FL2B7HBA016LMD%22%2C%22TM2C5WOP984W%22%2C%22TH2C3TTN639N%22%2C%22TM2C5WTO381W%22%2C%22TH2C1WSH719MM1%22%2C%22TM2C4KTOS64W%22%2C%22TH2C5KCD033M%22%2C%22FL2B7HBA019LMD%22%2C%22TM2C4WOPH64W%22%2C%22FL2C3HPP010L4X%22%2C%22TM2C4WJCH65WP1%22%2C%22FL2B7HBA020LMD%22%2C%22TH2C4KRN036M%22%2C%22TH2C1WPC574MM1%22%2C%22FL2B1HBA007LRL%22%2C%22TH2C5WPC656M%22%2C%22TM2C5WPC884W%22%2C%22TH2C3WPC658M%22%2C%22TM2C3WSH542WP4%22%2C%22TH2C4KTN019M%22%2C%22SH2C5NPC544M%22%2C%22FL2C3HPP014LRL%22%2C%22FL2C3HLV002LRL%22%2C%22TH2C4WJM320M%22%2C%22FL2B1HTY006LRL%22%2C%22TM2C4KOPS65W%22%2C%22FL2C1HLV013LGT%22%2C%22TH2C4WSH714M%22%2C%22FL2C1HFT009LGT%22%2C%22TM2C1WJCS21WP4%22%2C%22TH2C1NPC673N%22%2C%22FL2C1HBF001LFG%22%2C%22TM2C4WSC665W%22%2C%22TH2C1KVT011M%22%2C%22SH2C3KTN031M%22%2C%22FL2C1HLV017LGT%22%2C%22LC2C4WJC561W%22%5D&amp;tag=D')" class="item_info1" onclick="javascript:GA_main('recommend',$(this));setEcommerceData(17, 'RECOMMEND', '');">        <img src="http://newmedia.thehandsome.com/TM/2C/SS/TM2C4KOPS65W_BK_S01.jpg/dims/resize/289x289"> 
 </a>    <span class="item_info2">            <span class="brand BR01">TIME</span> 
         <span class="title">언밸런스 헴 스퀘어넥 니트 드레스</span> 
     <span class="price">₩625,000</span> 
 </span> 
 <span class="flag"></span> 
</li></ul>
            </div>
            <div class="controls" id="pickforControls">
                <a href="#;" class="prev" style="opacity: 1;"></a>
                <a href="#;" class="next" style="opacity: 1;"></a>
            </div>
        </div>
        <!--// pick_for-->
        </div>
        <!-- //main_container-->
        <!-- instagram -->
        <div class="instagram_wrap1903" style="display:none">
            <div class="txt_wrap">
                <h4 class="tit"># THE HANDSOME MOMENT</h4>
                <p class="s_title">한섬 브랜드 공식 인스타그램 속 사진을 감상하세요.</p>
            </div>
            <div class="pic_wrap swiper-container" id="instaContents">
                <ul class="swiper-wrapper">
                </ul>
                <div class="instagram_arrow next">다음</div>
                <div class="instagram_arrow prev">이전</div>
            </div>
            <a href="/resources/ko/magazine/instagram" class="insta_view_more">전체보기</a>
        </div>
        <!-- //instagram -->
        </div>
    
    <!-- //bodyWrap -->
    <div class="layerArea" id="hpMemberLayer" style="display:none;">
        <div class="layerBg" style="display:block;" tabindex="-1"></div> 
        <div class="popwrap w_type_8" id="" style="position: absolute; z-index: 201; display: block;top:50%;margin-top:-283px;" tabindex="-1">
            <!-- Title1 -->
            <div class="pop_tltwrap3">
                <h3>현대백화점 통합회원 가입 안내</h3>
            </div>
            <!-- //Title1 -->
            <div class="pop_cnt">
                <div class="hpoint">
                    <p class="txt">현대백화점 통합회원으로 가입 시<br />현대백화점그룹의 관계사 사이트를 동시에 이용하실 수 있으며,<br />각종 혜택을 누리실 수 있습니다.</p>
                    <p class="img"><img src="/resources/_ui/desktop/common/images/popup/main_popup_hpoint.jpg" style="vertical-align:top" alt="" /></p>
                    <div class="noticeTxt">
                        <p>동의하실 경우 다음의 정보가 공유됩니다.</p>
                        <p>- 제공받는자 : (주)현대백화점</p>
                        <p>- 목적 : 회원가입 시 필수정보 입력, 기 가입여부, 타인과의 아이디 중복여부 확인</p>
                        <p>- 항목 : 성명, 아이디, 생년월일, 전화번호, 이메일</p>
                    </div>
                    <div class="btnwrap mt30">
                        <input class="btn gray" value="동의하고 회원가입 진행" type="button" style="width:200px" onclick="hpoinJoin();" />
                        <input class="btn wt" value="쇼핑 계속하기" type="button" style="width:200px" onclick="layerPopup3('close');" />
                    </div>
                </div>
            </div>
            <div class="grayBox">
                <input type="checkbox" id="memPop" name="memPop" onclick="layerPopup3('close');" /><label for="chk1">다시보지않기</label>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <input type="checkbox" id="oweek" name="oweek"  onclick="layerPopup3('oneweek');" /><label for="chk2">1주일동안 열지 않음</label>
            </div>
            <!-- btn_close -->
            <a href="#" class="btn_close" id="closeLayerPop" onclick="layerPopup3('close');"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png"></a>
            <!-- //btn_close -->
        </div>
    </div>
<!--  criteo 메인 페이지 트래커 START -->
<script type="text/javascript" src="/resources//static.criteo.net/js/ld/ld.js" async="true"></script>
<script type="text/javascript">


    var banner1 = $(".banner1");
    var banner2 = $(".banner2");
    var leftCnt = 0;
    var rightCnt = 0;
    if(banner1.length > 1){
        $.each($(".banner1"), function(i) {
            if($(this).hasClass("banner1_Y")){
                $(this).show();
                leftCnt++;
                return false;
            }
        });
    }
    if(leftCnt == 0){
        $(".banner1").eq(0).show();
    }
    if(banner2.length > 1){
        $.each($(".banner2"), function(i) {
            if($(this).hasClass("banner2_Y")){
                $(this).show();
                rightCnt++;
                return false;
            }
        });
    }
    if(rightCnt == 0){
        $(".banner2").eq(0).show();
    }
    $(".mid_banner").show();


window.criteo_q = window.criteo_q || [];
window.criteo_q.push(
        { event: "setAccount", account: 24596 },
        
        { event: "setSiteType", type: "d" },
        //{ event: "viewHome", requiresDOM: "yes"}
        { event: "viewHome"}
);

if ( 'true' == 'false' ) {
    window.onload = function() {
        NetFunnel_Complete();
    };
}
</script>
<!--  criteo 메인 페이지 트래커 END -->

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
                        H.Point통합회원 정보로 더한섬닷컴에 회원가입이 가능합니다.<br />
                        단, 더한섬닷컴 가입확인을 위해 아래의 정보로 조회가 진행됩니다.<br />
                        동의하시면 회원가입 해주세요.<br />
                        <span>※ 조회정보 : 이름, 생년월일, 휴대폰번호</span>
                    </p>
                    <div class="btnwrap mt30">
                        <input class="btn gray" value="더한섬닷컴 가입" type="button" style="width:200px" onclick="simpJoin();" />
                    </div>
                </div>
            </div>
            <a href="#" class="btn_close" id="closeLayerPop" onclick="layerPopup4('close');"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png" ></a>
        </div>
    </div>
    
<!-- 마케팅 수신 팝업 : s -->
<div class="layerArea" id="marketingAgreeLayer" style="display:none;">
    <div class="layerBg" style="display:block;"></div>
        <div class="popwrap w_type_8" style="outline:none;top:50%;margin-top:-235px;" tabindex="-1">
            <!-- Title1 -->
            <div class="pop_tltwrap3">
                <h3>마케팅 수신 재동의 안내</h3>
            </div>
            <!-- //Title1 -->
            <div class="pop_cnt">
                <div class="hpoint">
                    <p class="txt">고객님께서는 마케팅 수신 재동의 대상입니다.<br>더한섬닷컴에서 제공되는 서비스에 대한 수신동의 여부를<br>다시 한번 확인해주세요.<br>선택 하시면 더한섬닷컴에서 진행하는 마케팅 및 이벤트소식을<br>받아보실 수 있습니다.</p>
                    <div class="marketing_rcv_box" style="overflow:hidden;text-align:center;">
                        <!-- marketing_rcv_con -->
                        <div class="marketing_rcv_con" style="display:inline-block;margin:0 20px;">
                            <input type="checkbox" id="emailchk" name="agree_marketing" />
                            <label for="emailchk">이메일(Email)</label>
                        </div>
                        <!-- // marketing_rcv_con -->
                        <!-- marketing_rcv_con -->
                        <div class="marketing_rcv_con" style="display:inline-block;margin:0 20px;">
                            <input type="checkbox" id="smschk" name="agree_marketing" />
                            <label for="smschk">SMS</label>
                        </div>
                        <!-- // marketing_rcv_con -->
                        </div>
                    <div class="noticeTxt">
                        <p>단, 가입 및 주문/결제와 재입고 알림 등에 관련된 이메일과 SMS는 동의와 상관없이 발송됩니다.</p>
                    </div>
                    <div class="btnwrap mt30">
                        <input class="btn gray" value="확인하기" type="button" onclick="maketingAgreeAlert();" />
                    </div>
                </div>
            </div>
            <!-- btn_close -->
            <a href="#" class="btn_close" id="closeLayerPop" onclick="maketingAgreeClose();"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png"></a>
            <!-- //btn_close -->
    </div>
</div>
<!-- 마케팅 수신 팝업 : e -->

    <form id="simpJoinForm" method="post" action="" target="simpStart_window">
        <input type="hidden" name="prtnrId" value="D080" /> 
        <input type="hidden" name="chnnlId" value="1705" />
        <input type="hidden" name="ssoMcustNo" id="ssoMcustNo" value="" />
        <input type="hidden" name="ptcoReqnMdaInf" id="ptcoReqnMdaInf" />
    </form>

    <form id="userHiddenForm" method="post" target="transMember">
        <input type="hidden" name="prtnrReqGb" value="03" />
        <input type="hidden" name="prtnrId" id="prtnrId" value="" />
        <input type="hidden" name="chnnlId" id="chnnlId" value="" />
        <input type="hidden" name="custNm" id="custNm" value="" />
        <input type="hidden" name="birthDt" id="birthDt" value="" />
        <input type="hidden" name="mophNo" id="mophNo" value="" />
        <input type="hidden" name="chId" id="chId" value="" />  
        <input type="hidden" name="custUniqKey" id="custUniqKey" value="" />
        <input type="hidden" name="email" id="email" value="" />
        <input type="hidden" name="sexGbCd" id="sexGbCd" value="" />
        <input type="hidden" name="ci" id="ci" value="" /> 
        <input type="hidden" name="ptcoReqnMdaInf"  id="ptcoReqnMdaInf" value="" />      
    </form>
    <script type="application/ld+json">
    {
     "@context": "http://schema.org",
     "@type": "Organization",
     "name": "thehandsome",
     "url": "http://www.thehandsome.com",
     "sameAs": [
       "https://www.instagram.com/thehandsome_official/",
       "https://www.youtube.com/c/%EB%8D%94%ED%95%9C%EC%84%AC%EB%8B%B7%EC%BB%B4HANDSOME",
       "https://play.google.com/store/apps/details?id=com.handsome.thehandsome",
       "https://apps.apple.com/kr/app/itunes-connect/id1072288949"
     ]
    }
    </script>

<%@include file="include/footer.jsp" %>