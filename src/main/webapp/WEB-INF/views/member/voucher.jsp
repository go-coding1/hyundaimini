<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
<c:when test="${empty sessionScope.user}">
<script>
location.href ='/member/login';
</script>
</c:when>
</c:choose>

<%@include file="member_header.jsp" %>
<div class="gnbwarp new201608 clearfix">
        <h1 class="logo logo1903">
            <a href="/ko/main" onclick="GA_Event('공통', '로고', '상단');">thehandsome.com</a>
        </h1>
        <!-- 첫번째 c:if -->

    
    <div id="transparent_mask"></div>
    <!-- 201803 util menu -->
    <div class="util_menu util_menu1803">
        <ul class="clearfix">
            <li><a href="javascript:void(0);"><span class="ico_sh">search</span></a></li>
            <li><a href="/ko/mypage/myWish" onclick="GA_Event('공통','유틸_메뉴','위시리스트');"><span class="ico wishlist">wish list</span> <span class="count">(<span id="wishlistCount">0</span>)</span></a></li>
            <li><a href="/ko/shoppingbag" onclick="GA_Event('공통','유틸_메뉴','쇼핑백');"><span class="ico cart">장바구니</span> <span class="count">(<span id="cartCount">3</span>)</span></a></li>
            </ul>
    </div>
  </div>  
    <!-- //201803 util menu -->
    </div>
		</div>
		<!-- //headerWrap -->
		
		<div id="bodyWrap">
	<h3 class="cnts_title">
		<span id="menuTitle">나의 쿠폰</span>
	</h3>
	<div class="sub_container">
		<!-- lnb -->
		<div class="lnb_wrap">
			<h4><a href="/ko/mypage">마이페이지<!-- 마이페이지 --></a></h4>
			<div class="lnb">
						<dl>
							<dt>주문조회</dt>
							<dd><a href="/ko/mypage/order/myorders" onclick="GA_Event('마이페이지','LNB','주문/배송/반품/취소');">주문/배송/반품/취소</a></dd>
							</dl>
						<dl>
							<dt>혜택관리</dt>
							<dd><a href="/ko/mypage/myGradeInfo" onclick="GA_Event('마이페이지','LNB','나의 회원 등급');">나의 회원 등급</a></dd>
							<dd><a href="/ko/mypage/voucher" onclick="GA_Event('마이페이지','LNB','나의 쿠폰');">나의 쿠폰<!-- 쿠폰함 --></a></dd>
							<dd><a href="/ko/mypage/mypoint" onclick="GA_Event('마이페이지','LNB','나의 한섬마일리지');">나의 한섬마일리지</a></dd>
							<dd><a href="/ko/mypage/myEGiftCard" onclick="GA_Event('마이페이지','LNB','E-GIFT CARD');">e-Gift Card</a></dd>
</dl>
						<dl>
							<dt>나의 상품관리</dt>
							<dd><a href="/ko/mypage/myWish" onclick="GA_Event('마이페이지','LNB','위시리스트');">위시리스트<!-- 위시리스트 --></a></dd>
							<dd><a href="/ko/mypage/rsalarm" onclick="GA_Event('마이페이지','LNB','재입고 알림');">재입고 알림<!-- 재입고알림 --></a></dd>
							</dl>
						<dl>
							<dt>나의 정보관리</dt>
							<dd><a href="/ko/mypage/personInfomationChangePWCheck" onclick="GA_Event('마이페이지','LNB','개인정보 변경/탈퇴');">개인정보 변경/탈퇴</a></dd>
							<dd><a href="/ko/mypage/shoppingAddressPWCheck" onclick="GA_Event('마이페이지','LNB','배송지 관리');">배송지 관리</a></dd>
							<dd><a href="/ko/mypage/oneClick" onclick="GA_Event('마이페이지','LNB','원클릭 결제 관리');">원클릭 결제 관리</a></dd>
							<dd><a href="/ko/mypage/mergeCustomerInfo" onclick="GA_Event('마이페이지','LNB','한섬 멤버십 통합');">한섬 멤버십 통합</a></dd>
							</dl>
						<dl>
							<dt>나의 활동관리</dt>
							<!-- <dd><a href="#">회원등급</a></dd> -->
							<dd><a href="/ko/mypage/myreview" onclick="GA_Event('마이페이지','LNB','내 상품평');">내 상품평</a></dd>
							<dd><a href="/ko/mypage/myqna" onclick="GA_Event('마이페이지','LNB','상품 Q&amp;A');">상품 Q&amp;A</a></dd>
							<dd><a href="/ko/mypage/mymantomaninquiry" onclick="GA_Event('마이페이지','LNB','1:1 문의');">1:1 문의</a></dd>
							<!-- <dd><a href="#">이벤트 참여현황</a></dd> -->
						</dl>
						</div>
					<!-- ph_guide -->
					<div class="ph_guide">
						<p class="tlt">고객센터 운영 안내</p>
						<p class="phone">1800-5700<span style="color:#c69c6d;" class="txt">(유료)</span></p>
						<p class="txt">평일(월~금)<br>am 09:00 ~ pm 18:00<span>토/일, 공휴일 휴무</span></p>
						<a href="mailto:shophelp@thehandsome.com">shophelp<br>@thehandsome.com</a>
					</div>
					<!-- //ph_guide -->
				</div>
		<!-- //lnb -->
		<!-- cnts -->
		<div class="sub_cnts">
			
			
			<script type="text/javascript">

$(document).ready(function(){

	$("#menuTitle").text("나의 쿠폰");
	/*
	var voucherList = new BoardListController('searchForm', '#listBody', '.paging', 20); //폼아이디, 리스트공간 셀렉터, 페이징공간 셀렉터, 페이지당 리스트개수
    
    var loadingHtml  = "";
        loadingHtml += '<div class="layerLoading_bar" id="loadingBarDiv" style="width: 100%;height: 100%;top:0;">';
        loadingHtml += '    <img src="http://cdn.thehandsome.com/pc/order/loading_spinner_007s_190827.gif" alt="loading" style="margin-left: -40px;">';
        loadingHtml += '</div>';
        
    $("body").append(loadingHtml);
        
	var id = $('#id_sel').val();
	
	if(id != 'N'){
	    $(".txt_line").text("쿠폰 사용 및 유효 기간 만료 후 6개월 간 내역입니다.");
	}

	voucherList.setRowHtml = function(results){
       var rows = "";
           
       if(results.length == 0){
			var listTag = 	"<tr>";	
			listTag +=			'<td colspan="6" class="no_data">';
			listTag +=				"내역이 없습니다.";
			listTag +=			"</td>";
			listTag +=		"</tr>";
			
			rows +=listTag;
		} else {

			$.each(results, function(){

				var listTag = '<tr class="al_middle">';
				listTag += '	<td class="frt" style="word-break:keep-all;">' + this.name + '</td>';
				listTag += '	<td>' + this.vouchercode + '</td>';
				listTag += '	<td class="al_left">';
				listTag += '		<ul class="bul_sty01_li">';
				listTag += '			<li>' + this.description + '</li>';
				listTag += '		</ul>';
				listTag += '	</td>';
				
				if(this.value == 0) {
					listTag += '	<td></td>';
				} else {
					if(this.currency == null){
						listTag += '	<td>' + this.value + ' % </td>';
					} else {
						listTag += '	<td>'+ this.currency + ' ' + addComma(this.value) + '</td>';
					}
				}
				
				listTag += '	<td>' + this.startdate + ' ~<br />' + this.enddate + '</td>';
				
				if(this.usedate == null || $('#id_sel option:selected').val() == 'N'){
					listTag += '	<td>' + $('#id_sel option:selected').text(); + '</td>';
				} else {
					listTag += '	<td>' + this.usedate + '</td>';
				}
				
				listTag += '</tr>';
				
				rows +=listTag;
			});
		}
        $(".layerLoading_bar").remove(); // 로딩 이후 로딩바 제거 
        return rows;
	};
	voucherList.doWork();
	*/
	$('#id_sel').change(function(){
		
	    $("#searchForm").attr("action", "/member/voucher");
		$("#searchForm").submit();

	});
		
});

</script>

	<form id="searchForm" action="/ko/mypage/voucherOnline">
	<div class="title_wrap mt30 clearfix">
		<h4 class="float_left"><label for="id_sel">온라인 쿠폰 목록<!-- 온라인 쿠폰 목록 --></label></h4>
		<p class="txt_line"></p>
		<div class="btn_wrap">
			<select id="id_sel" name="id_sel" style="width:150px">
				<option value="N" selected="">미사용<!-- 미사용 --></option>
				<option value="Y">사용<!-- 사용 --></option>
				<option value="P">기간만료<!-- 기간만료 --></option>
			</select>
		</div>
	</div>
	</form>
	<!-- Table -->
	<div class="tblwrap">
		<table class="tbl_ltype">
			<caption>온라인 쿠폰 목록<!-- 온라인 쿠폰 목록 --></caption>
			<colgroup>
				<col style="width:115px">
				<col style="width:131px">
				<col>
				<col style="width:87px">
				<col style="width:107px">
				<col style="width:115px">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">종류<!-- 종류 --></th>
					<th scope="col">쿠폰번호<!-- 쿠폰번호 --></th>
					<th scope="col">내용<!-- 내용 --></th>
					<th scope="col">할인<!-- 할인 --></th>
					<th scope="col">유효기간<!-- 유효기간 --></th>
					<th scope="col">쿠폰사용일자<!-- 쿠폰사용일자 --></th>
				</tr>
			</thead>
			<tbody id="listBody">
			<tr class="al_middle" >	
				<td class="frt" style="word-break:keep-all;">신규회원 무료 반품 쿠폰</td>	
				<td>RT2-022-042-9F1-TT</td>	
				<td class="al_left">		
				<ul class="bul_sty01_li">			
				<li>반품 시 배송비 무료</li>
				</ul>
				</td>
				<td>
				</td>	
				<td>2022-04-29 ~<br>2022-07-31</td>	
				<td>미사용</td>
			</tr>
			</tbody>
		</table>
	</div>
	<!-- //Table -->

	<!--paging-->
	<div class="paging"><a class="prev2" href="javascript:void(0);">처음 페이지로 이동</a><a href="javascript:void(0);" class="prev">이전 페이지로 이동</a><span class="num"><a href="javascript:void(0);" class="pageBtn  on  " pagenum="1">1</a></span><a href="javascript:void(0);" class="next">다음 페이지로 이동</a><a href="javascript:void(0);" class="next2">마지막 페이지로 이동</a></div>
	<!--//paging-->


	<!-- Guide Table -->
	<div class="gd_wrap mt50">
		<dl class="gd_list com pl0 svc_gd_list">
			<dt>쿠폰 안내<!-- 쿠폰 안내 --></dt>
			<dd>
				<ul class="bul_sty01_li">
					<li>온라인쿠폰 : 상품 주문 시 ‘주문&amp;배송정보입력’ 화면에서 쿠폰을 적용하면 할인된 금액으로 상품을 구입하실 수 있습니다.</li><li>반품쿠폰 : 반품 시 반품 비용 없이 무료로 구입하신 상품을 반품 하실 수 있습니다.</li><li>일부 상품은 쿠폰할인 적용이 불가능합니다.</li><li>유효기간이 지난 쿠폰은 자동 소멸 됩니다.</li><li>주문취소 시 사용한 쿠폰은 유효기간이 만료된 경우 재발급되지 않습니다.</li></ul>
			</dd>
		</dl>
	</div>
	<div class="gd_wrap">
		<dl class="gd_list com pl0 svc_gd_list">
			<dt>회원혜택<!-- 회원 혜택 --></dt>
			<dd>
				<ul class="bul_sty01_li">
					<li>생일축하 한섬마일리지 : 생일을 맞은 회원님께 생일축하 2만 한섬마일리지를 드립니다.(온/오프라인 합하여, 구매이력 있는 고객)</li><li>신규회원 온라인 할인쿠폰 : 한섬 온라인에 가입한 즉시 발급되며, 1개월 이내 사용 하셔야 합니다.<br>할인 금액의 제한은 없습니다.</li><li>한섬 우수고객 혜택 (2019년) : 연간 구매금액 1,000만원 이상 회원 대상으로 다음 해 연간 구매 혜택, 서비스, 기프트를 증정합니다.</li><li>향후 회원 혜택은 사전공지 후 변경될 수 있습니다.</li></ul>
			</dd>
		</dl>
	</div>
	<!-- //Guide Table -->

</div>
		<!-- //cnts -->
	</div>
</div>

<script type="text/javascript">
var fileIdx = 1;
var reviewRate_en = "";
var reviewSymbol_en = "";
var reviewRate_zh = "";
var reviewSymbol_zh = "";
var isCosmetic = false;
var isPerfume = false;

$(document).ready(function(){
	
	getReviewExchangeRate();	
	
	if("false"){
		
		//파일 체크
	    $(document).on('change', 'input[type=file]', function() {
	        var file = null;
	        var fileName = "";
	        var fileSize = "";
	        var maxSize = 10 * 1024 * 1024;
	
	        if ($.browser.msie) {
	            if($(this).val() == null || $(this).val() == ""){
	                $("input[name=fileText]").val("");
	                return;
	            }
	            fileSize = 10; 
	            fileName = $(this).val().split(".");
	        }else{
	            
	            file = $(this)[0].files[0];
	            if(file == null){   
	                $("input[name=fileText]").val("");
	                return;
	            }
	            
	            fileName = $(this)[0].files[0].name.split(".");
	            fileSize = $(this)[0].files[0].size;    
	        }
	        
	        var fileExtension = fileName[parseInt(fileName.length-1)].toUpperCase();
	        
	        if(fileExtension == 'JPG'|| fileExtension == 'JPEG' || fileExtension == 'GIF'|| fileExtension == 'PNG'){
	                
	        }else{
	            $(this).val('');
	            $("input[name=fileText]").val('');
	            var la = new layerAlert('파일 확장자를 확인해 주세요.');
	            return;
	        }
	        
	        if(fileSize > maxSize){
	            $(this).val('');
	            $("input[name=fileText]").val('');
	            var la = new layerAlert('10MB 미만의 jpg,gif,png 파일만 첨부하실 수 있습니다.');
	            return;
	        }
	        
	        
	        if($(this).attr("id").indexOf("reviewFile") > -1){
	        	var liLen = $('form[name=reviewForm] .file_image_wrap2003 li').length;
	        	
	        	if(liLen < 5){
	        		var fileLen = $('form[name=reviewForm] input[type=file]').length;
		        	var html = '';
		        	
			        	html += '<input type="file" name="reviewFile" id="reviewFile'+fileIdx+'" class="btn add_s" title="파일찾기">';
			        	html += '<label for="reviewFile'+fileIdx+'">';
			        	html += '<span id="uploadFile1" class="img_upload">파일찾기</span>';        	
			        	html += '</label>';
		        	
		        	$('form[name=reviewForm] .upload_btn label').eq(fileLen-1).hide();
		        	$('form[name=reviewForm] .upload_btn input[type=file]').eq(fileLen-1).hide();
		        	$("form[name=reviewForm] .upload_btn").append(html);
		        	
					var html = '';
					
						html += '<li class="file_image">';
			        	html += '<span>'+$(this)[0].files[0].name+'</span>';
			        	html += '<a href="javascript:void(0);" class="file_del" onclick="deleteReviewFile($(this),'+fileIdx+');">파일삭제</a>';
			        	html += '</li>';
		        	$("form[name=reviewForm] .file_image_wrap2003").append(html);
		        	
		        	fileIdx++;
	        	} else {
	        		$(this).val("");
	        		layerAlert("사진 등록은 5개까지 가능합니다.");
	        	}
	        } else {
	        	$("input[name=fileText]").val($(this).val());
	        }
	        
	        $("#thFile").css("color", "black");
	        $("#thFile").css("font-weight","normal");
	    });
		
	}
});

function hideProductLayer() {
	$('.layerArea').remove();
}

function viewPopup(v){
	var obj=$("#"+v.split("#")[1]);
	var lp=($(window).width()-740)/2;
	var tp=$(window).scrollTop();
	
	if(lp < 0) lp=0;
	if(tp < 0) tp=0;
	
	obj.css("top", tp).css("left", lp).css("position", "absolute").css("z-index", 101);
	obj.show();
	
	return false;
}

function showProductLayer() {
	$("#productLayer").show();
}

function starCnt() {//상품평 별점 선택
	$('.btn_star_score li a').on('click',function() {
		var idx=$(this).parent('li').index()+1;
		for(var i=1;i<6;i++){
			$('.write_star_score1807 .cmt_star .cmt_per').removeClass('star'+i);
		}
		$('.write_star_score1807 .cmt_star .cmt_per').addClass('star'+idx);
	});
}

function checkCategoryType(code) {
    
    if(isCosmetic) {
        return "cosmetic";
    }else if(isPerfume) {
        return "perfume";
    }
    
	var rtnValue = "";
	var topType = "SZ01,SZ02,SZ03,SZ04,SZ05,SZ06,SZ07,SZ08".split(",");
	var bottomsType = "SZ09,SZ10,SZ11".split(",");
	var loop = true;
	
	for(var i=0; i < topType.length; i++) {
		if(code == topType[i]) {
			rtnValue = "top";
			loop = false;
			break;
		}
	}
	
	if(loop) {
		for(var i=0; i < bottomsType.length; i++) {
			if(code == bottomsType[i]) {
				rtnValue = "bottoms";
				loop = false;
				break;
			}
		}
	}
	
	return rtnValue;
}

function reviewReset(){
	//색상 초기화
	$("#customerReviewWriteDiv .color_chip li > a").each(function(){
	     $(this).removeClass("on");
	});
	$("#customerReviewWriteDiv #colorNameContent").html("");
	
	//사이즈 초기화
	$("#customerReviewWriteDiv .size_chip li > a").each(function(){
	     $(this).removeClass("on");
	});
	
	//연령
	$("#customerReviewWriteDiv input[name=age]").prop("checked",false);
	
	//체형
	$("#customerReviewWriteDiv input[name=bodyType]").prop("checked",false);
	
	//키
	$("#customerReviewWriteDiv #height").val("");
	
	//평소 사이즈
	$("#customerReviewWriteDiv #enjoySize").val("");
	
	//실착용
	$("#customerReviewWriteDiv input[name=realWearSize]").prop("checked",false);
	
	//실 제품 색상
	$("#customerReviewWriteDiv input[name=realProductColor]").prop("checked",false);
	
	//상품평
	$("#customerReviewWriteDiv #reviewHeadline").val("");
	
	//사진등록
	$("#customerReviewWriteDiv #textReviewFile").val("");
	
	//평점
	$("#customerReviewWriteDiv .btn_star_score li:eq(4) > a").click();
	
	//파일리스트 초기화
	var labelLeng = $('#customerReviewWriteDiv .upload_btn label').length-1;
    $('#customerReviewWriteDiv .upload_btn label').each(function(i){
    	if(i != labelLeng){
    		$('#customerReviewWriteDiv .upload_btn label').eq(0).remove();
    		$('#customerReviewWriteDiv .upload_btn input[type=file]').eq(0).remove();
    	}
    });
    
	//올린파일
	$("#customerReviewWriteDiv #uploadedFiles").hide();
	$("#customerReviewWriteDiv .file_image_wrap2003 li").remove();
	
	//상품 매장 구매여부
	$("#packopt").prop("checked",false);
	
	$(".slct_opt").remove();
	
	$("#realWearSizeTR").empty();
	
	$("#realColorTR").empty();
	
	$("#thFile").css("color", "black");
	$("#thFile").css("font-weight","normal");
}

function uploadFilesubmit(writeType, returnType) {
	var url = "";
	if(writeType == "write") {
		url = "/ko/mypage/reviewWrite";
	} else {
		url = "/ko/mypage/modifyCustomerReview";
	}
	
	if ($('#packopt').is(':checked')) {
		$("#purchaseProdYN").val("Y");
	}else {
		$("#purchaseProdYN").val("N");
	};
	
	$("#reviewHeadline").val(encodeText($("#reviewHeadline").val()));
	
	
	$('input[name="realWearSize"]').each(function(index){
		if ($(this).is(':checked')) {
			$("#realWearSize").val($(this).val());
		}
	});
	$('input[name="realProductColor"]').each(function(index){
		if ($(this).is(':checked')) {
			$("#realProductColor").val($(this).val());
		}
	});
		
	
	var liSize = $('form[name=reviewForm] .file_image_wrap2003 li').size();
    var fileSize = $('form[name=reviewForm] .upload_btn input[type=file]').size();
    //사진 전체 삭제여부 체크
    if(liSize == 0){
		$("#fileDeleteYN").val("Y");
	}
	
	if ( fileSize <= 1 ) {
		var param = $('form[name=reviewForm]').serialize();
		
		$.ajax({
			url	 : url + '?CSRFToken=79b50ea1-85a7-4580-a655-059958ce5f30',
			type	: 'POST',
			dataType: 'json',
			data	: param,
			success : function(data) {
				if(data.rsltCd == "F") {
					var la = new layerAlert(data.rsltMsg);
					return;
				} else {
					var la;
					if(data == "F_PHOTO") {
						la = new layerAlert("최초 포토상품평 작성으로 마일리지 지급이<br/>완료 된 상품평 입니다.<br /><br/>사진을 첨부해서 상품평을 수정해 주세요.");
						la.confirmAction = function() {
							$("#thFile").css("color", "#ff0000");
							$("#thFile").css("font-weight","normal");
							$("#textReviewFile").focus();
						};
						return;
					} else if(data == "No Match") {
						la = new layerAlert("잘못된 접근입니다.");
						return;
					} else if(data == "FAIL") {
						la = new layerAlert("예상치 못한 오류가 발생하였습니다.</br>다시 시도해 주시기 바랍니다.");
						return;
					} else {
						if(writeType == "write") {
							la = new layerAlert("상품평이 등록되었습니다.");
						} else if(writeType == "modify") {
							la = new layerAlert("상품평이 수정되었습니다.");
						}
						la.confirmAction = function() {
							hideProductLayer();
							$(".popwrap").remove();
							if(returnType == "review") {
								location.href = '/ko/mypage/myreview?returnType=write';
							} else if(returnType == "order") {
								location.href = '/ko/mypage/order/myorders';
							} else if(returnType == "myMain") {
								location.href = '/ko/mypage';
							} else {
								location.href = '/ko/mypage/myreview?returnType=write';
							}
						};
					}
				}
			},
			error   : function(xhr, Status, error) {
				alert(error);
			}
		});
	} else {
		
		var labelLeng = $('form[name=reviewForm] .upload_btn label').length - 1;
    	$('form[name=reviewForm] .upload_btn label').each(function(i){
    		if(i != labelLeng){
    	    	$('form[name=reviewForm] .upload_btn input[type=file]').eq(i).attr("name", "reviewFile"+(i==0?"":i));
    		} else {
    			$('form[name=reviewForm] .upload_btn input[type=file]').eq(i).attr("disabled",true);
    		}
        });
    	
		
		
		$('form[name=reviewForm]').ajaxSubmit({
			url	 : url + '?CSRFToken=79b50ea1-85a7-4580-a655-059958ce5f30',
			type	: 'POST',
			async   : false,
			success : function(data) {
				if(data.rsltCd == "F") {
					var la = new layerAlert(data.rsltMsg);
					return;
				} else {
					var la;
					if(writeType == "write") {
						la = new layerAlert("상품평이 등록되었습니다.");
					} else if(writeType == "modify") {
						la = new layerAlert("상품평이 수정되었습니다.");
					}
					la.confirmAction = function() {
						hideProductLayer();
						$(".popwrap").remove();
						if(returnType == "review") {
							location.href = '/ko/mypage/myreview?returnType=write';
						} else if(returnType == "order") {
							location.href = '/ko/mypage/order/myorders';
						} else if(returnType == "myMain") {
							location.href = '/ko/mypage';
						} else {
							location.href = '/ko/mypage/myreview?returnType=write';
						}
					};
				}
			},
			error   : function(xhr, Status, error) {
				alert(error);
			}
		}); 
	}
}

function openPopupReview(code, orderNumber, color, pPrice, imageUrl, bName, pName, categoryCode, returnType) {
	// 상품평 초기화
	reviewReset();
	
	$.ajax({
		url     : '/ko/mypage/reviewWriteBeforeVerify',
		type    : 'GET',
		datatype: 'json',
		data : {
				"productCode" : code,
				"orderNumber" : orderNumber
		},
		success : function(data) {
		    isCosmetic = data.isCosmetic;
		    isPerfume = data.isPerfume;
			reviewWriteHtml(categoryCode, returnType);
			
			$("#height").val(data.height);
			$("#enjoySize").val(data.enjoySize);
			if(data.bodyType != null && data.bodyType != ""){
				$('input[name="bodyType"]').each(function(index){
					if(data.bodyType == $(this).val()){
						$(this).attr('checked', true);
					}else {
						$(this).attr('checked', false);
					}
				});
			}
			
			var codeArray = code.split('_');
			var style = codeArray[1];
			var size = codeArray[2];
			
			$('#photoAccumulationRightYn').val(data.photoAccumulationRightYn);
			if ( data.orderProductReviewList.length > 0 ) {
				$('.select_options_wrap').hide(); // 색상, 사이즈 박스
				var productOptions = '' ;
				$.each(data.orderProductReviewList, function(idx, productOption) {
					if(orderNumber == productOption[1] && style == productOption[3] && size == productOption[5]) {
						productOptions += '<span class="slct_opt">더한섬닷컴  /  COLOR : ' + productOption[4] + '  /  SIZE : ' + productOption[5] + '</span>';
						$('#orderNumber').val(productOption[1]);
						$('#purchaseColor').val(productOption[3]);
						$('#purchaseColorName').val(productOption[4]);
						$('#purchaseSize').val(productOption[5]);
					}
				});
				$('.slct_opt').remove();
				$("#productOption").after(productOptions);
				$("#purchased_color_size").show();
			} else {
				$('#purchaseProdYN').val('Y');
				$('#packopt').prop('checked', true);
				$('#packopt').prop('readonly', true);
				$('#packopt').on('click', function(e) {
					e.preventDefault();
					return;
				});
			}
			
			$("#reviewFile").val("");
			$("#textReviewFile").val("");
			$("#reviewHeadline").val("");
			
			var prodCode = code;
			var prodSize = "";
			if(prodCode.indexOf('_') > -1){
				var tmpPnt = prodCode.lastIndexOf('_');
				prodSize = prodCode.substring(tmpPnt+1,prodCode.length);
				prodCode = prodCode.substring(0,tmpPnt);
				if(prodCode.indexOf('_') > -1){
					$("#review_color_name").text(color);
					$("#review_size").text(prodSize);
					if('' == 'review'){ // 주문조회에서 왔을 경우 미표시
						$(".options_change").css("display", "none");    
					}
				} else {
					$(".review_header_wrapper").css("margin-top","16px");
				}
			}
			
			var review_color_name = $("#colorName").val();
			$("#review_color_name").text(review_color_name);
			
			var price = getReviewExchangePrice(pPrice);
			
			$("#productCode").val(code);
			$("#categoryCode").val(categoryCode);
			//$("#orderNumber").val(orderNumber);
			$("#reviewWriteProductImg").attr('src',imageUrl);
			$("#reviewWriteProductPrice").text(price);
			$("#reviewWriteProductBrandName").text(unescape(bName));
			$("#reviewWriteProductName").text(pName);
			$('#closeWriteChk').val('Y');
			
			
		},
		error   : function() {
			var la = new layerAlert("[Error] " + error);
			return;
		}
	});
}
function deleteReviewFile(li,idx){
   
	li.parent().remove();
	
    idx -= 1
    
    if(idx == 0) { idx = "";}
    $('.upload_btn label[for=reviewFile'+idx+']').remove();
	$('.upload_btn #reviewFile'+idx).remove();
	if ( $('#productId').val() != '' && $('#productId').val() != null ) {
		if(li.attr("id") != "" && li.attr("id") != null){	
			$("#reviewFileCd"+(li.attr("id")=="0"?"":li.attr("id"))).val('');
		}
	}
}

function reviewWriteHtml(categoryCode, returnType) {
	var reqd = "";
	if(checkCategoryType(categoryCode) == "top" || checkCategoryType(categoryCode) == "bottoms" || checkCategoryType(categoryCode) == "cosmetic" || checkCategoryType(categoryCode) == "perfume") {
		reqd = "<strong class='reqd'>*</strong>";
	}
	var reviewhtml="";
	reviewhtml = '<div class="layerArea">';
	reviewhtml +='<div class="layerBg"></div> ';
	reviewhtml +='<form id="reviewForm" style="width:780px;" method="post" commandName="reviewForm" name="reviewForm" enctype="multipart/form-data">';
	reviewhtml += "<div class='popwrap w_type_4' id='customerReviewWriteDiv'>";
	reviewhtml += "    <div class='pop_tltwrap2 customerreviewwritediv1807'>";
	reviewhtml += "        <h3>상품평 작성하기</h3>";
	reviewhtml += "        <p class='reqd_txt float_right'><strong class='reqd'>*</strong> 표시는 필수항목입니다.</p>";
	reviewhtml += "    </div>";
	reviewhtml += "    <div class='pop_cnt evaluation_write1905 options1811'>";
	reviewhtml += '        <input type="hidden" id="productId" name="productId">';
	reviewhtml += "        <input type='hidden' id='productCode' name='productCode'>";
	reviewhtml += "        <input type='hidden' id='productCodeType' name='productCodeType' value=''>";
	reviewhtml += "        <input type='hidden' id='orderNumber' name='orderNumber' value=''>";
	reviewhtml += "        <input type='hidden' id='purchaseColor' name='purchaseColor' value=''>";
	reviewhtml += "        <input type='hidden' id='purchaseColorName' name='purchaseColorName' value=''>";
	reviewhtml += "        <input type='hidden' id='purchaseSize' name='purchaseSize' value=''>";
	reviewhtml += "        <input type='hidden' id='purchaseProdYN' name='purchaseProdYN' value='N'>";
	reviewhtml += "        <input type='hidden' id='orderWriteChk' name='orderWriteChk' value='N'>";
	reviewhtml += "        <input type='hidden' id='selectSizeCode' name='selectSizeCode' value=''>";
	reviewhtml += "        <input type='hidden' id='categoryCode' name='categoryCode' value=''>";
	reviewhtml += "        <input type='hidden' id='shoulderWidth' name='shoulderWidth' value=''>";
	reviewhtml += "        <input type='hidden' id='chestSize' name='chestSize' value=''>";
	reviewhtml += "        <input type='hidden' id='waistSize' name='waistSize' value=''>";
	reviewhtml += "        <input type='hidden' id='buttSize' name='buttSize' value=''>";
	reviewhtml += "        <input type='hidden' id='totalSize' name='totalSize' value=''>";
	reviewhtml += "        <input type='hidden' id='realProductColor' name='realProductColor' value=''>";
	reviewhtml += "        <input type='hidden' id='photoAccumulationRightYn' name='photoAccumulationRightYn' value=''>";
	reviewhtml += "        <input type='hidden' id='offlineOrdDt' name='offlineOrdDt' value=''>";
	reviewhtml += "        <input type='hidden' id='offlineShpCd' name='offlineShpCd' value=''>";
	reviewhtml += "        <input type='hidden' id='offlineShpNm' name='offlineShpNm' value=''>";
	reviewhtml += "            <fieldset>";
	reviewhtml += "                <legend>상품평쓰기</legend>";
	reviewhtml += "                <div class='tblwrap'>";
	reviewhtml += "                    <table class='tbl_wtype1'>";
	reviewhtml += "                        <caption>상품평쓰기 입력항목</caption>";
	reviewhtml += "                        <colgroup>";
	reviewhtml += "                            <col style='width:130px'>";
	if(checkCategoryType(categoryCode) == "cosmetic" || checkCategoryType(categoryCode) == "perfume") {
	reviewhtml += "                            <col style='width:30px''>";  
	}else {
	reviewhtml += "                            <col>";
	}
	reviewhtml += "                            <col style='width:130px'>";
	reviewhtml += "                            <col>";
	reviewhtml += "                        </colgroup>";
	reviewhtml += "                        <tbody>";
	reviewhtml += "                            <tr>";
	reviewhtml += "                                <th scope='row' class='th_space'>상품명</th>";
	reviewhtml += "                                <td colspan='3' style='padding:15px;'>";
	reviewhtml += "                                    <div class='item_box' id='reviewProductDiv'>";
	reviewhtml += "                                        <div class='pt_list_all'>";
	reviewhtml += "                                            <a href='#;'><img src='' id='reviewWriteProductImg' alt='product Image'></a>";
	reviewhtml += "                                            <div class='tlt_wrap review_header_wrapper'>";
	reviewhtml += "                                                <a href='#;' class='basket_tlt'>";
	reviewhtml += "                                                    <span class='tlt' id='reviewWriteProductBrandName'></span>";
	reviewhtml += "                                                    <span class='sb_tlt' id='reviewWriteProductName'></span> / <span id='reviewWriteProductPrice'></span>";
	reviewhtml += "                                                </a>";
	reviewhtml += "                                            </div>";
	reviewhtml += "                                            <div class='select_group' id='productOption' style='display:none;'>";
	reviewhtml += "                                            </div>";
	reviewhtml += "                                            <div class='check_stl shoppurchase_check_wrap' onclick=\"$('#packopt').click();\" style='display:none;'>";
	reviewhtml += "                                                <input type='checkbox' id='packopt' name='packopt' value=''>";
	reviewhtml += "                                                <label for='shoppurchase_check' class='shoppurchase_check'>매장에서 구매한 상품입니다.</label>";
	reviewhtml += "                                            </div>";
	reviewhtml += "                                        </div>";
	reviewhtml += "                                    </div>";
	reviewhtml += "                                </td>";
	reviewhtml += "                            </tr>";
	reviewhtml += "                            <tr class='tbl_blank1807'>";
	reviewhtml += "                                <td colspan='4'>&nbsp;</td>";
	reviewhtml += "                            </tr>";
	reviewhtml += "                            <tr class='radio_btn_1905 bk'>";
	reviewhtml += "                                <th scope='row' class='th_space'>연 령</th>";
	reviewhtml += "                                <td colspan='3'>";
	reviewhtml += "                                 <input id='ageG1' type='radio' name='age' value='18세 이하'>";
	reviewhtml += "                                 <label for='ageG1'>18세 이하</label>";
	reviewhtml += "                                 <input id='ageG2' type='radio' name='age' value='20대'>";
	reviewhtml += "                                 <label for='ageG2'>20대</label>";
	reviewhtml += "                                 <input id='ageG3' type='radio' name='age' value='30대'>";
	reviewhtml += "                                 <label for='ageG3'>30대</label>";
	reviewhtml += "                                 <input id='ageG4' type='radio' name='age' value='40대'>";
	reviewhtml += "                                 <label for='ageG4'>40대</label>";
	reviewhtml += "                                 <input id='ageG5' type='radio' name='age' value='50대'>";
	reviewhtml += "                                 <label for='ageG5'>50대</label>";
	reviewhtml += "                                 <input id='ageG6' type='radio' name='age' value='60대 이상'>";
	reviewhtml += "                                 <label for='ageG6'>60대 이상</label>";
	reviewhtml += "                                </td>";
	reviewhtml += "                         </tr>";
	if(checkCategoryType(categoryCode) == "top" || checkCategoryType(categoryCode) == "bottoms") {
	reviewhtml += "                         <tr class='input_txt_1905'>";
	reviewhtml += "                             <th scope='row' class='th_space' id='thHeight'>"+reqd+"키</th>";
	reviewhtml += "                             <td><input type='text' name='height' id='height' style='width:75%amrgin-right:10px'>cm</td>";
	reviewhtml += "                             <th scope='row' class='th_space' id='thEnjoySize'>"+reqd+"평소 사이즈</th>";
	reviewhtml += "                             <td><input type='text' name='enjoySize' id='enjoySize'></td>";
	reviewhtml += "                         </tr>";
	reviewhtml += "                         <tr class='radio_btn_1905'>";
	reviewhtml += "                             <th scope='row' class='th_space' id='thBodyType'>"+reqd+"체 형</th>";
	reviewhtml += "                             <td colspan='3'>";
	reviewhtml += "                                 <input id='dark1' type='radio' name='bodyType' value='마른 체형'>";
	reviewhtml += "                                 <label for='dark1'>마른 체형</label>";
	reviewhtml += "                                 <input id='dark2' type='radio' name='bodyType' value='보통'>";
	reviewhtml += "                                 <label for='dark2'>보통</label>";
	reviewhtml += "                                 <input id='dark3' type='radio' name='bodyType' value='통통한 체형'>";
	reviewhtml += "                                 <label for='dark3'>통통한 체형</label>";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	}
	if(checkCategoryType(categoryCode) == "cosmetic" || checkCategoryType(categoryCode) == "perfume") {
	reviewhtml += "                         <tr class='radio_btn_1905'>";
	reviewhtml += "                             <th scope='row' class='th_space' id='thSkinType'>"+reqd+"피부 타입</th>";
	reviewhtml += "                             <td colspan='3'>";
	reviewhtml += "                                 <input id='skin1' type='radio' name='skinType' value='건성'>";
	reviewhtml += "                                 <label for='skin1'>건성</label>";
	reviewhtml += "                                 <input id='skin2' type='radio' name='skinType' value='지성'>";
	reviewhtml += "                                 <label for='skin2'>지성</label>";
	reviewhtml += "                                 <input id='skin3' type='radio' name='skinType' value='복합성'>";
	reviewhtml += "                                 <label for='skin3'>복합성</label>";
	reviewhtml += "                                 <input id='skin4' type='radio' name='skinType' value='민감성'>";
	reviewhtml += "                                 <label for='skin4'>민감성</label>";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	}
	reviewhtml += "                         <tr class='tbl_blank1807'>";
	reviewhtml += "                             <td colspan='4'>&nbsp;</td>";
	reviewhtml += "                         </tr>";
	reviewhtml += "                         <tr class='write_star_wrap'>";
	reviewhtml += "                             <th colspan='4'>";
	reviewhtml += "                                 <div class='write_star_score1807'>";
	reviewhtml += "                                     <span class='cmt_star'>";
	reviewhtml += "                                         <span class='cmt_per star5'>별점</span>";
	reviewhtml += "                                     </span>";
	reviewhtml += "                                     <ul class='btn_star_score'>";
	reviewhtml += "                                         <li><a href='#;' value='1'>1점</a></li>";
	reviewhtml += "                                         <li><a href='#;' value='2'>2점</a></li>";
	reviewhtml += "                                         <li><a href='#;' value='3'>3점</a></li>";
	reviewhtml += "                                         <li><a href='#;' value='4'>4점</a></li>";
	reviewhtml += "                                         <li><a href='#;' value='5'>5점</a></li>";
	reviewhtml += "                                         <input type='hidden' id='rating' name='rating' value='5'>";
	reviewhtml += "                                     </ul>";
	reviewhtml += "                                     <p>평점을 선택해 주세요.</p>";
	reviewhtml += "                                 </div>";
	reviewhtml += "                             </th>";
	reviewhtml += "                         </tr>";
	if(checkCategoryType(categoryCode) == "top" || checkCategoryType(categoryCode) == "bottoms") {
	reviewhtml += "                         <tr>";
	reviewhtml += "                             <th scope='row' class='th_space'><strong class='reqd'>*</strong>실 착용 사이즈</th>";
	reviewhtml += "                             <td colspan='3'>";
		if(checkCategoryType(categoryCode) == "top") {
	reviewhtml += "                                 <!--20190529_상품평활성화-->";
	reviewhtml += "                                 <div class='cont_detail'>";
	reviewhtml += "                                     <p class='left_txt'>어깨너비 : </p>";
	reviewhtml += "                                     <ul class='rd_box_radio_list'>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='shoulderWidth_1' type='radio' name='shoulderWidth' value='1'>";
	reviewhtml += "                                             <label for='shoulderWidth_1'>타이트함</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='shoulderWidth_2' type='radio' name='shoulderWidth' value='2'>";
	reviewhtml += "                                             <label for='shoulderWidth_2'>적당함</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='shoulderWidth_3' type='radio' name='shoulderWidth' value='3'>";
	reviewhtml += "                                             <label for='shoulderWidth_3'>여유있음</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                     </ul>";
	reviewhtml += "                                 </div>";
	reviewhtml += "                                 <div class='cont_detail'>";
	reviewhtml += "                                     <p class='left_txt'>가슴둘레 : </p>";
	reviewhtml += "                                     <ul class='rd_box_radio_list'>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='chestSize_1' type='radio' name='chestSize' value='1'>";
	reviewhtml += "                                             <label for='chestSize_1'>타이트함</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                            <input id='chestSize_2' type='radio' name='chestSize' value='2'>";
	reviewhtml += "                                            <label for='chestSize_2'>적당함</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='chestSize_3' type='radio' name='chestSize' value='3'>";
	reviewhtml += "                                             <label for='chestSize_3'>여유있음</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                     </ul>";
	reviewhtml += "                                 </div>";
		} else if(checkCategoryType(categoryCode) == "bottoms") {
	reviewhtml += "                                 <div class='cont_detail'>";
	reviewhtml += "                                     <p class='left_txt'>허리둘레 : </p>";
	reviewhtml += "                                     <ul class='rd_box_radio_list'>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='waistSize_1' type='radio' name='waistSize' value='1'>";
	reviewhtml += "                                             <label for='waistSize_1'>타이트함</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='waistSize_2' type='radio' name='waistSize' value='2'>";
	reviewhtml += "                                             <label for='waistSize_2'>적당함</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='waistSize_3' type='radio' name='waistSize' value='3'>";
	reviewhtml += "                                             <label for='waistSize_3'>여유있음</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                     </ul>";
	reviewhtml += "                                 </div>";
	reviewhtml += "                                 <div class='cont_detail'>";
	reviewhtml += "                                     <p class='left_txt'>엉덩이둘레 : </p>";
	reviewhtml += "                                     <ul class='rd_box_radio_list'>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='buttSize_1' type='radio' name='buttSize' value='1'>";
	reviewhtml += "                                             <label for='buttSize_1'>타이트함</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                            <input id='buttSize_2' type='radio' name='buttSize' value='2'>";
	reviewhtml += "                                            <label for='buttSize_2'>적당함</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='buttSize_3' type='radio' name='buttSize' value='3'>";
	reviewhtml += "                                             <label for='buttSize_3'>여유있음</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                     </ul>";
	reviewhtml += "                                 </div>";
		}
	reviewhtml += "                                 <div class='cont_detail'>";
	reviewhtml += "                                     <p class='left_txt'>총길이 : </p>";
	reviewhtml += "                                     <ul class='rd_box_radio_list'>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                             <input id='totalSize_1' type='radio' name='totalSize' value='1'>";
	reviewhtml += "                                             <label for='totalSize_1'>타이트함</label>";
	reviewhtml += "                                        </li>";
	reviewhtml += "                                        <li> ";
	reviewhtml += "                                             <input id='totalSize_2' type='radio' name='totalSize' value='2'>";
	reviewhtml += "                                             <label for='totalSize_2'>적당함</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                         <li>";
	reviewhtml += "                                            <input id='totalSize_3' type='radio' name='totalSize' value='3'> ";
	reviewhtml += "                                            <label for='totalSize_3'>긴 편</label>";
	reviewhtml += "                                         </li>";
	reviewhtml += "                                     </ul>";
	reviewhtml += "                                 </div>";
	reviewhtml += "                                 <!--//20190529_상품평활성화-->";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	reviewhtml += "                         <tr>";
	reviewhtml += "                             <th scope='row' class='th_space'><strong class='reqd'>*</strong>실 제품 색상</th>";
	reviewhtml += "                             <td colspan='3'>";
	reviewhtml += "                                 <input id='dark' type='radio' name='realProductColor' value='1'>";
	reviewhtml += "                                 <label for='dark'>어두워요</label>";
	reviewhtml += "                                 <input id='same' type='radio' name='realProductColor' class='ml20' value='2'>";
	reviewhtml += "                                 <label for='same'>화면과 같아요</label>";
	reviewhtml += "                                 <input id='light' type='radio' name='realProductColor' class='ml20' value='3'>";
	reviewhtml += "                                 <label for='light'>밝아요</label>";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	} else if (checkCategoryType(categoryCode) == "cosmetic") {
    reviewhtml += "                         <tr>";
	reviewhtml += "                             <th colspan='2' scope='row' class='th_space'><strong class='reqd'>*</strong>보습력은 어떤가요?</th>";
	reviewhtml += "                             <td colspan='2'>";
	reviewhtml += "                                 <input id='moisturize1' type='radio' name='moisturize' value='1'>";
	reviewhtml += "                                 <label for='moisturize1'>조금 건조해요</label>";
	reviewhtml += "                                 <input id='moisturize2' type='radio' name='moisturize' class='ml20' value='2'>";
	reviewhtml += "                                 <label for='moisturize2'>보통이에요</label>";
	reviewhtml += "                                 <input id='moisturize3' type='radio' name='moisturize' class='ml20' value='3'>";
	reviewhtml += "                                 <label for='moisturize3'>촉촉해요</label>";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	reviewhtml += "                         <tr>";
	reviewhtml += "                             <th colspan='2' scope='row' class='th_space'><strong class='reqd'>*</strong>발림성은 어떤가요?</th>";
	reviewhtml += "                             <td colspan='2'>";
	reviewhtml += "                                 <input id='spreadability1' type='radio' name='spreadability' value='1'>";
	reviewhtml += "                                 <label for='spreadability1'>조금 뻑뻑해요</label>";
	reviewhtml += "                                 <input id='spreadability2' type='radio' name='spreadability' class='ml20' value='2'>";
	reviewhtml += "                                 <label for='spreadability2'>보통이에요</label>";
	reviewhtml += "                                 <input id='spreadability3' type='radio' name='spreadability' class='ml20' value='3'>";
	reviewhtml += "                                 <label for='spreadability3'>부드러워요</label>";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	reviewhtml += "                         <tr>";
	reviewhtml += "                             <th colspan='2' scope='row' class='th_space'><strong class='reqd'>*</strong>향은 어떤가요?</th>";
	reviewhtml += "                             <td colspan='2'>";
	reviewhtml += "                                 <input id='scent1' type='radio' name='scent' value='1'>";
	reviewhtml += "                                 <label for='scent1'>조금 아쉬워요</label>";
	reviewhtml += "                                 <input id='scent2' type='radio' name='scent' class='ml20' value='2'>";
	reviewhtml += "                                 <label for='scent2'>보통이에요</label>";
	reviewhtml += "                                 <input id='scent3' type='radio' name='scent' class='ml20' value='3'>";
	reviewhtml += "                                 <label for='scent3'>좋아요</label>";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	}else if (checkCategoryType(categoryCode) == "perfume") {
    reviewhtml += "                         <tr>";
    reviewhtml += "                             <th colspan='2' scope='row' class='th_space'><strong class='reqd'>*</strong>향은 어떤가요?</th>";
    reviewhtml += "                             <td colspan='2'>";
    reviewhtml += "                                 <input id='scent1' type='radio' name='scent' value='1'>";
    reviewhtml += "                                 <label for='scent1'>조금 아쉬워요</label>";
    reviewhtml += "                                 <input id='scent2' type='radio' name='scent' class='ml20' value='2'>";
    reviewhtml += "                                 <label for='scent2'>보통이에요</label>";
    reviewhtml += "                                 <input id='scent3' type='radio' name='scent' class='ml20' value='3'>";
    reviewhtml += "                                 <label for='scent3'>좋아요</label>";
    reviewhtml += "                             </td>";
    reviewhtml += "                         </tr>";
    reviewhtml += "                         <tr>";
    reviewhtml += "                             <th colspan='2' scope='row' class='th_space'><strong class='reqd'>*</strong>지속성은 어떤가요?</th>";
    reviewhtml += "                             <td colspan='2'>";
    reviewhtml += "                                 <input id='persistence1' type='radio' name='persistence' value='1'>";
    reviewhtml += "                                 <label for='persistence1'>조금 짧아요</label>";
    reviewhtml += "                                 <input id='persistence2' type='radio' name='persistence' class='ml20' value='2'>";
    reviewhtml += "                                 <label for='persistence2'>보통이에요</label>";
    reviewhtml += "                                 <input id='persistence3' type='radio' name='persistence' class='ml20' value='3'>";
    reviewhtml += "                                 <label for='persistence3'>오래 유지돼요</label>";
    reviewhtml += "                             </td>";
    reviewhtml += "                         </tr>";
    }
	
	if("ko" == "ko") {
	reviewhtml += "                         <tr>";
	reviewhtml += "                             <th scope='row'>";
	reviewhtml += "                                 <strong class='reqd' style='margin-top:6px;'>*</strong>";
	reviewhtml += "                                 <label for='lb1' style='margin-top:11px;line-height:20px;'>";
	reviewhtml += "                                     상품평<br/>";
	reviewhtml += "                                     <span class='subtxt_1905'>";
	reviewhtml += "                                         (20자 이상<br/>&nbsp;200자 이하)";
	reviewhtml += "                                     </span>";
	reviewhtml += "                                 </label>";
	reviewhtml += "                             </th>";
	reviewhtml += "                             <td colspan='3'>";
	reviewhtml += "                                 <textarea id='reviewHeadline' name='headline' cols='30' rows='5' style='width:98%;height:78px' maxlength='200'></textarea>";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	} else {
	reviewhtml += "                         <tr>";
	reviewhtml += "                             <th scope='row' class='th_space'>";
										
	reviewhtml += "                                 <label for='lb1' style='margin-top:8px;line-height:20px;'>";
	reviewhtml += "                                     <strong class='reqd'>*</strong><label for='lb1'>상품평<br />(200자 이하)</label><br/>";
	reviewhtml += "                                 </label>";
											
	reviewhtml += "                             </th>";
	reviewhtml += "                             <td colspan='3'>";
	reviewhtml += "                                 <textarea id='reviewHeadline' name='headline' cols='30' rows='5' style='width:98%;height:78px' maxlength='200'></textarea>";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	}
	reviewhtml += "                         <tr>";
	reviewhtml += "                             <th scope='row' class='th_space'><label for='file'>사진등록</label></th>";
	reviewhtml += "                             <td colspan='3'>";
	reviewhtml += "                                 <div class='file_upload hs_input_file_wrap2003'>";
	reviewhtml += "                                     <div class='upload_wrap2003'>";
	reviewhtml += "                                         <input type='text' id='textReviewFile' class='text' readonly='readonly' name='fileText'>";
	reviewhtml += "                                         <div class='upload_btn'>";
	reviewhtml += "                                             <input type='file' name='reviewFile' id='reviewFile' class='btn add_s' title='파일찾기'>";
	reviewhtml += "                                             <label for='reviewFile'>";
//	reviewhtml += "	                                            <button type='button' id='uploadFile1' class='img_upload' title='파일찾기'>";
	reviewhtml += "                                             <span id='uploadFile1' class='img_upload'>파일찾기</span>";
//	reviewhtml += "                                             </button>";
	reviewhtml += "                                             </label>";
	reviewhtml += "                                          </div>";
	reviewhtml += "                                     </div>";
	reviewhtml += "                                     <ul class='file_image_wrap2003'>";
	reviewhtml += "                                     </ul>";
	reviewhtml += "                                 </div>";
	reviewhtml += "                                 <p class='txt_guide'>10MB 미만의 jpg,gif,png 파일만 첨부하실 수 있습니다.</p>";
	reviewhtml += "                             </td>";
	reviewhtml += "                         </tr>";
	reviewhtml += "                     </tbody>";
	reviewhtml += "                 </table>";
	reviewhtml += "                 <p class='txt_guide'>";
	reviewhtml += "                     <span style='color:#e46764; font-weight: bold;'>- 상품평과 무관한 내용이거나  상품 재판매, 광고, 동일 문자의 반복 및 기타 불법적인 내용은 통보 없이 삭제되며,<br/>&nbsp;&nbsp;해당 글 작성자 ID는 글쓰기 권한이 제한됩니다.</span><br/>- 반품, 취소 등의 CS관련 글은 고객센터>1:1문의로 이동될 수 있습니다.";
		
	reviewhtml += "                 </p>";
	reviewhtml += "             </div>";
	reviewhtml += "             <div class='btnwrap mt40'>";
	reviewhtml += "                 <input type='button' id='reviewCancel' value='취소하기' class='btn wt'>";
	reviewhtml += "                 <input type='button' id='reviewWriteSend' value='등록하기' class='btn gray mr0'>";
	reviewhtml += "             </div>";
	reviewhtml += "         </fieldset>";
	reviewhtml += " </div>";
	reviewhtml += "     <a href='javascript:void(0);' id='reviewCloseBtn' style='position: absolute; top: 20px; right: 20px; width: 20px; height: 20px;'><img src='/resources/_ui/desktop/common/images/popup/ico_close.png' alt='닫기'></a>";
	reviewhtml += "</div>";
	reviewhtml += "</form>";
	reviewhtml += "</div>";
	$(reviewhtml).appendTo($('body'));
	starCnt();
	viewPopup("#reviewForm");
	
	$(".btn_close").on("click", function(){
		hideProductLayer();
		$("#customerReviewWriteDiv").remove();
	});
	
	$("#reviewCancel, #reviewCloseBtn").on('click', function(){
		var lc = new customLayerConfirm("취소하시겠습니까?", "확인", "취소");
		lc.confirmAction = function(){
			$(".btn_close").trigger("click");
		};
	});
	
	$(document).on("keyup","#height",function(){
		$("#thHeight").css("color", "black");
		$("#thHeight").css("font-weight","normal");
		$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		if($("#height").val().length > 0) {
			var inputNumberchk = /^[0-9]+$/; // 숫자 체크
			if (!inputNumberchk.test($("#height").val())){
				$(this).val($(this).val().replace(/[^0-9]/gi,""));
				var la = new layerAlert("숫자만 입력 가능합니다.");
				la.confirmAction = function(){};
			}
		}
	});
	
	$(document).on("keyup","#enjoySize",function(){
		$("#thEnjoySize").css("color", "black");
		$("#thEnjoySize").css("font-weight","normal");
		$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		if ($("#enjoySize").val().length > 0) {
			var inputHangulchk = /[^ㄱ-ㅎ|ㅏ-ㅣ]+$/; // 초성(자음/모음) 체크
			if (!inputHangulchk.test($("#enjoySize").val())){
				$(this).val($(this).val().replace(/[^a-z0-9]/gi,""));
				var la = new layerAlert("영문/숫자만 입력 가능합니다.");
				la.confirmAction = function(){};
			}
		}
	});
	
	$(".btn_star_score li a").on("click", function(){
		$("#rating").val($(this).attr('value'));
	});
	
	$(document).on("keyup", "#reviewHeadline", function() {
		$(".write_star_wrap").next().next().next().find("th").css("color", "black");
		$(".write_star_wrap").next().next().next().find("th").css("font-weight","normal");
		if($(this).val().length >= 200) {
			$(this).blur();
			var la = new layerAlert('상품평 내용은 20~200자 사이입니다.');
			return false;
		}
	});
	
	$('#reviewWriteSend').click(function(){
		var inputNumberchk = /^[0-9]+$/; // 숫자 체크
		var inputHangulchk = /[^ㄱ-ㅎ|ㅏ-ㅣ]+$/; // 초성(자음/모음) 체크
		
		if($('#orderWriteChk').val() == 'Y'){ // 상품평쓰기 화면에서 색상이 보일때만 체크
			if($('.select_options_wrap .color_chip li a').hasClass('on') == false){
				var la = new layerAlert('색상을 선택해 주세요.');
				//$('.select_options_wrap .color_chip li a').focus();
				$('.select_colors p').css("color", "#ff0000");
				$('.select_colors p').css("font-weight","bold");
				return false;
			}
		}
		
		if($('#orderWriteChk').val() == 'Y'){ // 상품평쓰기 화면에서 사이즈가 보일때만 체크
			var productType = $('form[name=reviewForm] input[name=productCodeType]').val();
			if(productType != 'ApparelSizeVariantProduct'){ //ApparelStyleVariantProduct
				var la = new layerAlert('사이즈를 선택해 주세요.');
				$('.select_options .select_size p').css("color", "#ff0000");
				$('.select_options .select_size p').css("font-weight","bold");
				
				return false;
			}
		}
		
		var checkCategory = checkCategoryType(categoryCode);
		
		if(checkCategory == "top" || checkCategory == "bottoms") {
			if ($("#height").val() == null || $.trim($("#height").val()) == '') {
				$("#thHeight").css("color", "#ff0000");
				$("#thHeight").css("font-weight","normal");
				$("#height").focus();
				var la = new layerAlert('키를 입력해주세요.');
				return;
			}
			
			if ($("#enjoySize").val() == null || $.trim($("#enjoySize").val()) == '') {
				$("#thEnjoySize").css("color", "#ff0000");
				$("#thEnjoySize").css("font-weight","normal");
				$("#enjoySize").focus();
				var la = new layerAlert('평소 사이즈를 입력해주세요.');
				return;
			}
			
			if ( $('input[name=bodyType]:checked').length < 1 ) {
				$("#thBodyType").css("color", "#ff0000");
				$("#thBodyType").css("font-weight","normal");
				$("#thBodyType").focus();
				var la = new layerAlert('체형을 선택해주세요.');
				
				$('input[name=bodyType]').on('click', function() {
					$("#thBodyType").css("color", "black");
					$("#thBodyType").css("font-weight","normal");
				});
				return;
			}
			
			if(checkCategory == "top") {
				if( $("input[name=shoulderWidth]:checked").length < 1 ) {
					var la = new layerAlert('실착용 사이즈를 선택해주세요.');
					$(".write_star_wrap").next().find("th").css("color", "#ff0000");
					$(".write_star_wrap").next().find("th").css("font-weight","bold");
					
					$("input[name=shoulderWidth]").click(function() {
						$(".write_star_wrap").next().find("th").css("color", "black");
						$(".write_star_wrap").next().find("th").css("font-weight","normal");
					});
					$('#shoulderWidth_1').focus();
					return;
				}
				if( $("input[name=chestSize]:checked").length < 1 ) {
					var la = new layerAlert('실착용 사이즈를 선택해주세요.');
					$(".write_star_wrap").next().find("th").css("color", "#ff0000");
					$(".write_star_wrap").next().find("th").css("font-weight","bold");
					
					$("input[name=chestSize]").click(function() {
						$(".write_star_wrap").next().find("th").css("color", "black");
						$(".write_star_wrap").next().find("th").css("font-weight","normal");
					});
					$('#chestSize_1').focus();
					return;
				}
			}
			
			if(checkCategory == "bottoms") {
				if( $("input[name=waistSize]:checked").length < 1 ) {
					var la = new layerAlert('실착용 사이즈를 선택해주세요.');
					$(".write_star_wrap").next().find("th").css("color", "#ff0000");
					$(".write_star_wrap").next().find("th").css("font-weight","bold");
					
					$("input[name=waistSize]").click(function() {
						$(".write_star_wrap").next().find("th").css("color", "black");
						$(".write_star_wrap").next().find("th").css("font-weight","normal");
					});
					$('#waistSize_1').focus();
					return;
				}
				if( $("input[name=buttSize]:checked").length < 1 ) {
					var la = new layerAlert('실착용 사이즈를 선택해주세요.');
					$(".write_star_wrap").next().find("th").css("color", "#ff0000");
					$(".write_star_wrap").next().find("th").css("font-weight","bold");
					
					$("input[name=buttSize]").click(function() {
						$(".write_star_wrap").next().find("th").css("color", "black");
						$(".write_star_wrap").next().find("th").css("font-weight","normal");
					});
					$('#buttSize_1').focus();
					return;
				}
			}
			
			if($("input[name=totalSize]:checked").length < 1) {
				var la = new layerAlert('실착용 사이즈를 선택해주세요.');
				$(".write_star_wrap").next().find("th").css("color", "#ff0000");
				$(".write_star_wrap").next().find("th").css("font-weight","bold");
				
				$("input[name=totalSize]").click(function() {
					$(".write_star_wrap").next().find("th").css("color", "black");
					$(".write_star_wrap").next().find("th").css("font-weight","normal");
				});
				$('#totalSize_1').focus();
				return;
			}
			
			if($("input:radio[name=realProductColor]:checked").length < 1){
				var la = new layerAlert('실제품 색상을 선택해주세요.');
				$(".write_star_wrap").next().next().find("th").css("color", "#ff0000");
				$(".write_star_wrap").next().next().find("th").css("font-weight","bold");
				la.confirmAction = function(){
					$("#customerReviewWriteDiv").attr("tabindex", -1).focus();
				};
				
				$("input:radio[name=realProductColor]").click(function(){
					$(".write_star_wrap").next().next().find("th").css("color", "black");
					$(".write_star_wrap").next().next().find("th").css("font-weight","normal");
				});
				return;
			}
		}
		
		if(checkCategory == "cosmetic") {
		    if ( $('input[name=skinType]:checked').length < 1 ) {
				$("#thSkinType").css("color", "#ff0000");
				$("#thSkinType").css("font-weight","normal");
				$("#thSkinType").focus();
				var la = new layerAlert('피부 타입을 선택해주세요.');
				
				$('input[name=skinType]').on('click', function() {
					$("#thSkinType").css("color", "black");
					$("#thSkinType").css("font-weight","normal");
				});
				return;
			}
		    if( $("input[name=moisturize]:checked").length < 1 ) {
				var la = new layerAlert('보습력을 선택해주세요.');
				$(".write_star_wrap").next().find("th").css("color", "#ff0000");
				$(".write_star_wrap").next().find("th").css("font-weight","bold");
				
				$("input[name=moisturize]").click(function() {
					$(".write_star_wrap").next().find("th").css("color", "black");
					$(".write_star_wrap").next().find("th").css("font-weight","normal");
				});
				$('#moisturize1').focus();
				return;
			}
		    if( $("input[name=spreadability]:checked").length < 1 ) {
				var la = new layerAlert('발림성을 선택해주세요.');
				$(".write_star_wrap").next().next().find("th").css("color", "#ff0000");
				$(".write_star_wrap").next().next().find("th").css("font-weight","bold");
				
				$("input[name=spreadability]").click(function() {
					$(".write_star_wrap").next().next().find("th").css("color", "black");
					$(".write_star_wrap").next().next().find("th").css("font-weight","normal");
				});
				$('#spreadability1').focus();
				return;
			}
		    if( $("input[name=scent]:checked").length < 1 ) {
				var la = new layerAlert('향을 선택해주세요.');
				$(".write_star_wrap").next().next().next().find("th").css("color", "#ff0000");
				$(".write_star_wrap").next().next().next().find("th").css("font-weight","bold");
				
				$("input[name=scent]").click(function() {
					$(".write_star_wrap").next().next().next().find("th").css("color", "black");
					$(".write_star_wrap").next().next().next().find("th").css("font-weight","normal");
				});
				$('#scent1').focus();
				return;
			}
		    

			var headline = $("#reviewHeadline").val();
				
			if(headline == null || headline.trim() == ''){
				var la = new layerAlert('내용을 입력해 주세요.');
				$(".write_star_wrap").next().next().next().next().find("th").css("color", "#ff0000");
				$(".write_star_wrap").next().next().next().next().find("th").css("font-weight","bold");
				return false;
			}
				
			if(headline.trim().length < 20 || headline.trim().length > 200){
				var la = new layerAlert('상품평 내용은 20~200자 사이입니다.');
				$(".write_star_wrap").next().next().next().next().find("th").css("color", "#ff0000");
				$(".write_star_wrap").next().next().next().next().find("th").css("font-weight","bold");
				return false;
			}
		    
		} else if (checkCategory == "perfume") {
		    if ( $('input[name=skinType]:checked').length < 1 ) {
                $("#thSkinType").css("color", "#ff0000");
                $("#thSkinType").css("font-weight","normal");
                $("#thSkinType").focus();
                var la = new layerAlert('피부 타입을 선택해주세요.');
                
                $('input[name=skinType]').on('click', function() {
                    $("#thSkinType").css("color", "black");
                    $("#thSkinType").css("font-weight","normal");
                });
                return;
            }
		    
		    if( $("input[name=scent]:checked").length < 1 ) {
                var la = new layerAlert('향을 선택해주세요.');
                $(".write_star_wrap").next().find("th").css("color", "#ff0000");
                $(".write_star_wrap").next().find("th").css("font-weight","bold");
                
                $("input[name=scent]").click(function() {
                    $(".write_star_wrap").next().find("th").css("color", "black");
                    $(".write_star_wrap").next().find("th").css("font-weight","normal");
                });
                $('#scent1').focus();
                return;
            }
		    
            if( $("input[name=persistence]:checked").length < 1 ) {
                var la = new layerAlert('지속성을 선택해주세요.');
                $(".write_star_wrap").next().next().find("th").css("color", "#ff0000");
                $(".write_star_wrap").next().next().find("th").css("font-weight","bold");
                
                $("input[name=persistence]").click(function() {
                    $(".write_star_wrap").next().next().find("th").css("color", "black");
                    $(".write_star_wrap").next().next().find("th").css("font-weight","normal");
                });
                $('#persistence1').focus();
                return;
            }

            var headline = $("#reviewHeadline").val();
                
            if(headline == null || headline.trim() == ''){
                var la = new layerAlert('내용을 입력해 주세요.');
                $(".write_star_wrap").next().next().next().next().find("th").css("color", "#ff0000");
                $(".write_star_wrap").next().next().next().next().find("th").css("font-weight","bold");
                return false;
            }
                
            if(headline.trim().length < 20 || headline.trim().length > 200){
                var la = new layerAlert('상품평 내용은 20~200자 사이입니다.');
                $(".write_star_wrap").next().next().next().next().find("th").css("color", "#ff0000");
                $(".write_star_wrap").next().next().next().next().find("th").css("font-weight","bold");
                return false;
            }
		} else { // none cosmetic includes top, bottom and etc
		    var headline = $("#reviewHeadline").val();
			
			if(headline == null || headline.trim() == ''){
				var la = new layerAlert('내용을 입력해 주세요.');
				$(".write_star_wrap").next().next().next().find("th").css("color", "#ff0000");
				$(".write_star_wrap").next().next().next().find("th").css("font-weight","bold");
				return false;
			}
				
			if(headline.trim().length < 20 || headline.trim().length > 200){
				var la = new layerAlert('상품평 내용은 20~200자 사이입니다.');
				$(".write_star_wrap").next().next().next().find("th").css("color", "#ff0000");
				$(".write_star_wrap").next().next().next().find("th").css("font-weight","bold");
				return false;
			}
		}
		
			
		var lc = new customLayerConfirm("상품평을 등록하시겠습니까?", "확인", "취소"); // 상품평을 등록하시겠습니까?, 확인, 취소
		lc.confirmAction = function(){
			uploadFilesubmit('write', returnType);
			$('.pop_cls').click();
		}
	});
}

function encodeText( s ) {
	if ( !s ) {
		return "";
	}
	
	return s.replace( /['"<>&]/g, function( s ) {
		switch ( s ) {
			case "'":
				return "&#039;";
			case "\"":
				return "&#034;"
			case "\\(":
				return "&#40;";
			case "\\)":
				return "&#41;";
			case "<":
				return "&lt;";
			case ">":
				return "&gt;";
			case "&":
				return "&amp;";
		}
	});
}

function getReviewExchangeRate() {
	$.ajax({
		type : "get",
		//url : "/ko/mypage/order/getExchageRate",
		url : "/ko/intro/getExchageRate",
		dataType : "json",
		async : true,
		success : function( result ) {
			if(result.length > 0) {
				for(var i=0; i < result.length; i++) {
					if(result[i].currencyCode == "USD") {
						reviewRate_en = result[i].exchangeRate;
						reviewSymbol_en = result[i].symbol;
					} else {
						reviewRate_zh = result[i].exchangeRate;
						reviewSymbol_zh = result[i].symbol;
					}
				}
			}
		}
	});
}

function getReviewExchangePrice(price) {
	var exchangePrice = "";
	
			exchangePrice = "￦" + addComma(price);
		
	
	return exchangePrice;
}
</script>


<%@include file="../include/footer.jsp" %>