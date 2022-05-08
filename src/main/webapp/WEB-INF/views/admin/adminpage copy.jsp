<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:choose>
<c:when test="${sessionScope.user.mrole !='ROLE_ADMIN'}">
<script>
alert('관리자 계정으로 로그인해주세요.');
location.href ='/';
</script>
</c:when>
</c:choose>

<%@include file= "adminpage_header.jsp" %>

<div id="bodyWrap">
	<h3 class="cnts_title">
		<span id="menuTitle">관리자페이지</span>
	</h3>
	<div class="" style="position:relative;width:834px;height:0;display:block;left:50%;margin-left:-338px;">
		<div class="delch_box tooltip1907" id="store_delbox" style="display: none;">
			<span class="arr">위치아이콘</span>
			작성 가능한 상품평 확인하시고,<br>
			상품평 작성해서 추가 마일리지 적립하세요.
		</div>
	</div>
	<div class="sub_container">
		<!-- lnb -->
		<div class="lnb_wrap">
			<h4><a href="/ko/mypage">마이페이지<!-- 마이페이지 --></a></h4>
			<div class="lnb">
						<dl>
							<dt>주문</dt>
							<dd><a href="/admin/adminpage">주문 관리</a></dd>
						</dl>
						<dl>
							<dt>쿠폰</dt>
							<dd><a href="/admin/adminpage" onclick="GA_Event('마이페이지','LNB','나의 쿠폰');">쿠폰관리</a></dd>
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
//<![CDATA[ 
$(document).ready(function(){
    //마스킹 처리
    $(".ico_grade").html(maskingName($(".ico_grade").html()));
    
	$(".btn_close").on("click", function(){//팝업 닫기
        hideProductLayer();
        $(".popwrap").hide();
    });
	
	
	$(function(){ // 상품평 오른쪽 툴팁
		$(".point_wrap .point.review .tlt").mouseover(function(){
			 $("#store_delbox").css("display","block");
		});
		$(".point_wrap .point.review .tlt").mouseout(function(){
			 $("#store_delbox").css("display","none");
		});
	});

	$(document).on('click','.evaluation_write1905 .select_group',function(){//옵션선택박스 열기
		if(!$(this).hasClass('open')){
			$('.opt_box1905').stop().slideDown('fast');
			$(this).addClass('open');
			$(this).find('.transparent_mask1905').stop().show('fast');
		}else{
			$('.opt_box1905').stop().slideUp('fast');
			$(this).removeClass('open');
			$(this).find('.transparent_mask1905').stop().hide('fast');
		}
	});
	$(document).on('mouseenter focus','.opt_box1905 li',function(){
		$(this).addClass('active');
	});
	$(document).on('mouseleave blur','.opt_box1905 li',function(){
		$(this).removeClass('active');
	});
	
    
    $("#menuTitle").text("마이페이지");
    
    dateData();
    
    function dateData(){
        var today = new Date();
        var endDate = today.format("yyyy-MM-dd");
        $('#eterm').val(endDate);
        var startDate = today;
        startDate.setMonth(today.getMonth()-1);
        startDate = startDate.format("yyyy-MM-dd");
        $('#sterm').val(startDate);
    };
    
    var orderList = new BoardListController('orderSearchForm', '#listBody', '.paging', 5);
    orderList.setRowHtml = function(results){
        var rows = "";
        $.each(results, function(){
            var orderThis = this;
            
            var date = new Date(this.placed).format("yyyy.MM.dd");
            var listTag = '';
            
            if(orderThis.egiftCardOrderYn == true) {
                listTag = '<tr class="al_middle e-gift">';
            } else {
                listTag = '<tr class="al_middle">';
            }
            
            listTag +=  '<td rowspan="'+this.entries.length+'" class="frt"><p class="num">'+this.code+'</p>';
            
            listTag +=  '<span class="sum_date">('+this.orderCreateDate+')</span>';
            listTag +=  '<a href="/ko/mypage/order/myorderdetail?code='+this.code+'" class="btn_view" onclick="GA_Event(\'마이페이지\',\'최근주문\',\'상세보기\');">상세보기</a>'; //상세보기
            
            var i = 1;
            
            var entryTag = "";
            var addrModifyAvailYn = true;
            var entrieslength = this.entries.length;
            
            var firstEntry = 0;
            var isFirstCheck = true;
            
            var freeGiftList = this.freeGiftList;
            $.each(this.entries, function(){
                var searchDeliveryTemp = "";
                /* 2017.05.17, HSLee, 예약주문 안내문구 출력 [START] */
                var reOrderInfoPrintYn = (this.reOrderYn && (this.orderStatus.code=="PAYMENT_CAPTURED" || this.orderStatus.code=="SHIPPING_PREPARATION" || this.orderStatus.code=="DEPOSIT_WAIT")); // 예약주문관련 안내메시지 노출 여부
                var reOrderCompleteYn = (this.reOrderYn && (this.orderStatus.code=="PAYMENT_CAPTURED")); // 예약주문완료 주문상태
                var reserveSaleYn = this.reOrderYn; // 예약판매 표기용 변수 별도 생성
                
                if(this.orderStatus==null){
                    $.extend(this,{"orderStatus":{"code":""},"orderStatusName":""});
                }
                
                var productImageUrl = "";
                if(this.product.productImages!=null){
                    $.each(this.product.productImages, function(){
                        if(orderThis.egiftCardOrderYn == true) {
                            if(this.imageDivisionCode.code=='T01'){
                                productImageUrl = this.image.url;
                            }
                        } else {
                            if(this.imageDivisionCode.code=='S01'){
                                productImageUrl = this.image.url;
                            }
                        }
                    });
                }
                
                if(i++!=1){
                    entryTag += '<tr class="al_middle">';
                }
                
                entryTag += '<td>';
                entryTag += '<div class="pt_list_all">                                                                         ';
                
                if(orderThis.egiftCardOrderYn == true) {
                    entryTag += '   <a href="#;"  style="pointer-events: none;" onclick="GA_Event(\'마이페이지\',\'최근주문\',\'' +escape(this.product.name)+ '\');"><img src="'+productImageUrl+'" alt="상품 이미지"></a>    ';
                    entryTag += '   <div class="tlt_wrap">                                                                        ';
                    entryTag += '       <a href="#;"  style="pointer-events: none;" class="basket_tlt" onclick="GA_Event(\'마이페이지\',\'최근주문\',\'' +escape(this.product.name)+ '\');">                                                           ';
                } else {
                    entryTag += '   <a href="/ko/p/'+this.product.code+'" onclick="GA_Event(\'마이페이지\',\'최근주문\',\'' +escape(this.product.name)+ '\');"><img src="'+productImageUrl+'" alt="상품 이미지"></a>    ';
                    entryTag += '   <div class="tlt_wrap">                                                                        ';
                    entryTag += '       <a href="/ko/p/'+this.product.code+'" class="basket_tlt" onclick="GA_Event(\'마이페이지\',\'최근주문\',\'' +escape(this.product.name)+ '\');">                                                           ';
                    entryTag += '           <span class="tlt">['+this.product.brandName+']</span>';
                }
                
                if(reserveSaleYn){
                    entryTag += '           <span class="sb_tlt"><b>[예약판매]</b> '+this.product.name+'</span>';
                } else {
                    entryTag += '           <span class="sb_tlt">'+this.product.name+'</span>';
                }
                
                entryTag += '       </a>';
                
                var patr = "";
                if(orderThis.egiftCardOrderYn != true) {
	                var color = this.product.baseOptions[1].selected.erpColorName;
	                if(color!=null){
	                    patr +='<p class="color_op">color : '+color;
	                }
	                
	                var size = this.product.baseOptions[0].selected.variantOptionQualifiers[2].value;
	                
	                if(size!=null){
	                    if(patr==""){
	                        patr +='<p class="color_op">';
	                    }else{
	                        patr +='  <span class="and_line">/</span> ';
	                    }
	                    
	                    patr += ' size : '+size;
	                }
	                
	                if(patr!=""){
	                    patr += '</p>';
	                }
                }
                
                entryTag += patr;
                
                if (typeof freeGiftList != "undefined" && freeGiftList.length > 0 && this.freeGiftCommentYN) {
                    var commentShowYn = true;
                    
                    
                    if (this.orderStatus !=null && this.orderStatus.code == "CANCELLED") {
                        commentShowYn = false;
                    }
                    
                	if (this.returnStatus != null && this.returnStatus.code != 'RETURN_CANCEL') {
                	    commentShowYn = false;
                	}
                	
                	if (commentShowYn) {
                	    entryTag+= '<p class="guide_comment2">※ 사은품 안내 사항은 ‘주문상세’를 확인해주세요.</p>';                	    
                	}
                }
                
                if (reOrderInfoPrintYn) {
					var dpDate = this.deliveryPlanDate.split('-');
					var yyyy    = dpDate[0]; 
					var mm  = dpDate[1];
					var dd  = dpDate[2];
                 
					var deliveryplanDateMsg = '주문하신 상품은 예약상품으로 <span style="color:#e64674;">{0}년 <br />{1}월{2}일부터 순차적으로 배송</span>됩니다.';
					deliveryplanDateMsg = deliveryplanDateMsg.replace('{0}',yyyy);
                    deliveryplanDateMsg = deliveryplanDateMsg.replace('{2}',dd);
                    
                        deliveryplanDateMsg = deliveryplanDateMsg.replace('{1}',mm);
                    

                    entryTag += '   <div class="option_wrap">';
                    
	                    entryTag += '                 <p class="al_restock">';
                    
                    entryTag += 		deliveryplanDateMsg;
                    entryTag += '       <br />(입고예정일은 제작상황에 따라 변경될 수 있습니다.)';
                    entryTag += '   	</p>';
                    entryTag += '   </div>';
                }
                /* 2017.05.17, HSLee, 예약주문 안내문구 출력 [END] */
                
                
                if(orderThis.deliveryKind == "QUICK") {
                    entryTag += '   <div class="option_wrap">';
                    entryTag += '       <p class="quick_deliv stk">퀵배송</p>';
                    entryTag += '   </div>';
                }else if(orderThis.deliveryKind == "AT_HOME") {
                    entryTag += '   <div class="option_wrap">';
                    entryTag += '       <p class="athome">앳홈</p>';
                    entryTag += '   </div>';
                }else if(orderThis.deliveryKind == "FOUR_PM") {
                    entryTag += '   <div class="option_wrap">';
                    entryTag += '       <p class="fourpm">4PM</p>';
                    entryTag += '   </div>';
                }else if(orderThis.deliveryPointOfService != null || (orderThis.deliveryPointOfService != "" && typeof orderThis.deliveryPointOfService != "undefined")) {
                    entryTag += '   <div class="option_wrap">';
                    entryTag += '       <p class="store_pickup stk">매장수령</p>';
                    entryTag += '   </div>';                    
                }
                
                entryTag += '   </div>';
                entryTag += '</div>';
                
                entryTag += '</td>';
                
                entryTag += '<td>'
                if(this.partCancelYn==true) entryTag += '<del>'+this.originalQuantity+'</del>';  
                entryTag += this.quantity+'</td>';
                
                
                entryTag += '<td>₩ '+addComma(this.totalPrice.value)+'</td>';
                entryTag += '<td>';
                
                
                if(this.returnStatus!=null){
                	if(orderThis.returnRequestRejectYn) {
                		entryTag += '반품거절'
                	} else {
                    	entryTag += this.returnStatusName;
                    }
                }else{
                    if (reOrderCompleteYn) {
                        
                        entryTag += '예약주문완료'; 
                    } else {
                        entryTag += this.orderStatusName;
                    }
                }
                if(this.orderStatus.code=="DEPOSIT_WAIT"||this.orderStatus.code=="PAYMENT_CAPTURED"||this.orderStatus.code=="DELIVERY_COMPLETED"||this.orderStatus.code=="NOT_PAID_CANCEL"||this.orderStatus.code=="CANCELLED"||this.orderStatus.code=="CANCELLING"){
                	 if (reOrderInfoPrintYn) {
                		 
                	 } else if(this.returnStatus!=null){
                     	entryTag += '<span  class="sum_date">('+this.returnActionDate+')</span>';
                     } else {
                    	entryTag += '<span  class="sum_date">('+this.orderModifyDate+')</span>'; 
                	 }
                }
                
                if(this.partCancelYn==true&&this.orderStatus.code!="CANCELLED"){
                    
                    entryTag += '(부분주문취소)'; //부분주문취소
                }
                if(orderThis.deliveryKind != "AT_HOME" && orderThis.egiftCardOrderYn != true) {
                    
                    if(this.orderStatus.code=="SHIPPED"||this.orderStatus.code=="DELIVERY_COMPLETED"){
                        if(this.returnStatus==null){
                            
                                entryTag += '<br /><a href="#" class="btn wt_ss shippingInfoBtn" ocode="'+orderThis.code+'" pcode="'+this.product.code+'" >배송조회</a>' //배송조회
                            
                        }
                    }
                }
                
                
                entryTag += '</td>';
                
                var actionBtn = '';
                if(this.orderStatus.code=="DEPOSIT_WAIT") {
                    actionBtn += '<a href="/ko/mypage/order/cancelrequest?code='+orderThis.code+'&isall=Y" class="btn wt_ss">전체취소</a>'; //전체취소
                }
                else if(this.orderStatus.code=="PAYMENT_CAPTURED"){
                	if(orderThis.redVoucherOrderYn == true) {
                		actionBtn += '<a href="/ko/mypage/order/cancelrequest?code='+orderThis.code+'&isall=Y" class="btn wt_ss">전체취소</a>'; //전체취소
                	} else {
                		
                        tempCancel = '<a href="/ko/mypage/order/cancelrequest?code='+orderThis.code+'" class="btn wt_ss">주문취소</a>'; //주문취소
	                    actionBtn += '<div class="btn_wrap">'+searchDeliveryTemp+tempCancel;
	                    if(orderThis.egiftCardOrderYn == true && orderThis.egiftBuySmsReSendAvailableYn == true) {
	                        tempCancel = '<a href="javascript:eGiftBuySmsReSend(this,\''+orderThis.code+'\',\''+orderThis.egiftCardCode+'\');" id="reSendEGift" class="btn wt_ss" style="margin-top:10px;min-width:69px;">1회 재전송</a>';    
	                        actionBtn += searchDeliveryTemp+tempCancel+'</div>';  
	                    }else if(orderThis.egiftCardOrderYn == true && orderThis.egiftBuySmsReSendAvailableYn != true) {
	                        tempCancel = '<a href="javascript:void(0);" id="reSendEGift" class="btn dis_ss" style="margin-top:10px;min-width:69px;">1회 재전송</a>';    
	                        actionBtn += searchDeliveryTemp+tempCancel+'</div>';  
	                    } else {
	                        actionBtn += '</div>';  
	                    }                   
                	}
                }else{
                    if(orderThis.egiftCardOrderYn != true) {
                        actionBtn += '<div class="btn_wrap">';
                        if(this.returnAvailYn==true) {
	                        
	                        if(orderThis.deliveryKind == "AT_HOME" && (this.returnYN == true || this.returnYN == "true")) {
	                            
	                        } else {
	                        	<!-- 반품 중지 인 경우와 반품 상태가 없는 경우 반품 신청 버튼이 나옴. 반품 완료지만 수량이 남아 있을 경우 반품 신청 버튼이 나오지만 확인 후 수량이 없을 경우 다음으로 이동하지 않음 khg START-->
	                        	if(this.returnStatus != null) {
									if(this.returnStatus.code == 'RETURN_CANCEL'){
										actionBtn += '<a href="/ko/mypage/order/returnrequest?code='+orderThis.code+'" class="btn wt_ss">반품신청</a><br />'; //반품신청
									} else if(this.returnStatus.code == 'RETURN_COMPLETED'){
										actionBtn += '<a href="javascript:returnConfirm(\''+orderThis.code+'\');" class="btn wt_ss">반품신청</a><br />'; //반품신청
									} else {
										
									}
	                        	} else {
	                        		actionBtn += '<a href="/ko/mypage/order/returnrequest?code='+orderThis.code+'" class="btn wt_ss">반품신청</a><br />'; //반품신청	                        		
	                        	} 
	                        	<!-- 반품 중지 인 경우와 반품 상태가 없을 경우에만 반품 신청 버튼이 나옴 khg END-->
	                        }
	                        <!-- 20191104 글로벌 반품신청 -->
	                        
                        }
                        
                        
                        if(this.product.approvalStatus == "approved" && this.returnStatus == null) {
                        	if(this.reviewWriteYn != null) {
		                        if(this.reviewWriteYn == "Y") {
			                        var color = this.product.baseOptions[1].selected.erpColorName;
			                        var price = this.totalPrice.value;
			                        var brandName = this.product.brandName;
			                        var productName = this.product.name;
			                        var categoryCode = this.product.actualMeasurementSizeCode.code;
			                        var orderNumber = this.code;
			                        actionBtn += '<a href="javascript:openPopupReview(\''+this.product.code+'\', \''+orderThis.code+'\', \''+color+'\', \''+price+'\', \''+productImageUrl+'\', \''+escape(brandName).replace(/\'/g,"\\\'")+'\', \''+productName.replace(/\'/g,"\\\'")+'\', \''+categoryCode+'\', \'myMain\')" class="btn wt_ss">상품평 작성</a>'; //상품평쓰기
		                        }
                        	}
                        } else if(this.product.approvalStatus == "approved" && this.returnStatus != null && (this.returnStatus.code == "RETURN_CANCEL" || this.returnStatus.code == "RETURN_COMPLETED")) {
                        	if(this.reviewWriteYn != null) {
		                        if(this.reviewWriteYn == "Y") {
			                        var color = this.product.baseOptions[1].selected.erpColorName;
			                        var price = this.totalPrice.value;
			                        var brandName = this.product.brandName;
			                        var productName = this.product.name;
			                        var categoryCode = this.product.actualMeasurementSizeCode.code;
			                        var orderNumber = this.code;
			                        if(reviewReturnConfirm(orderThis.code) == "T") {
			                        	actionBtn += '<a href="javascript:openPopupReview(\''+this.product.code+'\', \''+orderThis.code+'\', \''+color+'\', \''+price+'\', \''+productImageUrl+'\', \''+escape(brandName).replace(/\'/g,"\\\'")+'\', \''+productName.replace(/\'/g,"\\\'")+'\', \''+categoryCode+'\', \'myMain\')" class="btn wt_ss">상품평 작성</a>'; //상품평쓰기
			                        }
		                        }
                        	}
                        }
                        
                        actionBtn += '</div>';
                    }
                    
                    addrModifyAvailYn = false;
                }
                if(this.orderStatus.code=="DEPOSIT_WAIT" && firstEntry == 0) {
                    entryTag += '<td rowspan="'+entrieslength+'">'+actionBtn+'</td>';
                } else if(this.orderStatus.code != "DEPOSIT_WAIT") {
                	if(orderThis.redVoucherOrderYn == true) {
                		if(firstEntry == 0) {
                			entryTag += '<td rowspan="'+entrieslength+'">'+actionBtn+'</td>';	
                		} else {
                			// skip
                		}
                	} else {
                		
                        entryTag += '<td class="pd12_resize">'+actionBtn+'</td>';
                	}
                }
            
            if(this.egiftCardOrderYn == true) {
                addrModifyAvailYn = false;
            }
            firstEntry += 1;

                if(addrModifyAvailYn){
                    if(isFirstCheck){
                    
                        var hp = ['','',''];
                        var ph = ['','',''];
                        var email = ['',''];
                        if(orderThis.cellphone !=null) hp = orderThis.cellphone.split('-');
                        if(orderThis.phone1 !=null) ph = orderThis.phone1.split('-');
                        if(orderThis.email !=null) email = orderThis.email.split('@');
                        searchDeliveryTemp +=  '<a href="javascript:void(0);" class="btn wt_ss addrModBtn" code="'+orderThis.code+'" addr1="'+orderThis.address1+'" addr2="'+orderThis.address2+'" zip="'+orderThis.zipCode+'" rcname="'+orderThis.name+'" hp1="'+hp[0]+'" hp2="'+hp[1]+'" hp3="'+hp[2]+'" ph1="'+ph[0]+'" ph2="'+ph[1]+'" ph3="'+ph[2]+'" or="'+orderThis.deliveryRequestContents+'" emailId="'+email[0]+'" emailDomain="'+email[1]+'" >배송정보수정</a>'; //배송지 수정
                    
                        isFirstCheck = false;
                    }
                }
            });
            
            listTag +='</td>';
            listTag +=entryTag;
            rows +=listTag;
        });
        return rows;
    };
    
    var $l = null;
    
    orderList.afterSetAction = function(){
        $('.addrModBtn').click(function(){
            
            
                $l = layerPopup('addrModPop');
                $l.attr('id', 'addrModPop_clone' );
                $l.find('#code').val($(this).attr('code'));
                $l.find('#zipCode').val($(this).attr('zip'));
                $l.find('#address1').val($(this).attr('addr1'));
                $l.find('#address2').val($(this).attr('addr2'));
                
                if(getByteLength($(this).attr('rcname')) > 40){
                    $l.find('#name').val(subStringBytes($(this).attr('rcname'),40,3));
                }else{
                    $l.find('#name').val($(this).attr('rcname'));
                }
                
                $l.find('#hp1').val($(this).attr('hp1'));
                $l.find('#hp2').val($(this).attr('hp2'));
                $l.find('#hp3').val($(this).attr('hp3'));
                $l.find('#ph1').val($(this).attr('ph1'));
                
                if($(this).attr('ph2') != 'undefined') {
                    $l.find('#ph2').val($(this).attr('ph2'));
                }
                if($(this).attr('ph3') != 'undefined') {
                    $l.find('#ph3').val($(this).attr('ph3'));
                }
                $l.find('#orderr').val($(this).attr('or'));
                $l.find('#emailId').val($(this).attr('emailId'));
                $l.find('#emailDomain').val($(this).attr('emailDomain'));
                
                emailTypeDomainSelectController("#addrModPop_clone #emailDomain","#addrModPop_clone #emailDomainSel");
                
                
                $l.find('#findAddrBtn').click(function(){
                    searchAddressLayer('addrModPop_clone #address1', 'addrModPop_clone #address2', 'addrModPop_clone #zipCode');
                });
                
                $("body").unbind('click');
                
                $l.find('.deliveryMsg').click(function(){
                    
                    //$l.find('#orderr').val($(this).find('a').text());
                    $l.find('#orderr').val($(this).find('a').attr("deliveryRequestMessage"));
                    $l.find('#orderr').keyup();
                    $l.find('.delivery_comt').hide();
                });
                
                $l.find('#orderr').focus(function(){
                    
                    $l.find('.delivery_comt').show();
                    $l.bind('click',function(e){
                        if($(e.target).parents("#orderrArea").size() == 0) {
                            $l.find('.delivery_comt').hide();
                            $l.unbind('click');
                        }; 
                    }); 
                });
                
                
                $l.find("[numberOnly=true]").keypress(function(event){
                    if(!isNum(event.which)) return false;
                }).keydown(function(event){
                    if(!isNum(event.which)) return false;
                });
                
                chkInputCount($l.find('#orderr'), $l.find('#textCnt'), 20);
                
                $l.find('#cancelBtn').click(function(){
                    $l.find('.btn_close').click();
                });
                
                $l.find('#applyBtn').click(function(){
                    var vc = new ValidationCheck('addrModPop_clone #addrModForm');
                    vc.checkIdList = ['zipCode','address1','address2', 'name', 'hp1', 'hp2', 'hp3'];
                    if(vc.isValid()){
                        
                        $l.find("#hp").val($l.find("#hp1").val()+"-"+$l.find("#hp2").val()+"-"+$l.find("#hp3").val());
                        $l.find("#ph").val($l.find("#ph1").val()+"-"+$l.find("#ph2").val()+"-"+$l.find("#ph3").val());
                        
                        $l.find("#email").val($l.find("#emailId").val()+"@"+$l.find("#emailDomain").val());
                        
                        addrModFn();
                        
                        $l.find('.btn_close').click();  
                    }
                });
            
            
        });
        
        $(".shippingInfoBtn").click(function(){
            var paramDatas = 'ocode='+$(this).attr('ocode')+'&pcode='+$(this).attr('pcode');
            var orderCode = $(this).attr('ocode');
            $.ajax({
                type: "get",
                url :  "/ko/mypage/order/getdelno",
                data : paramDatas,          
                dataType : "json",
                error : function( request, status, error ){     
                    alert(error);
                }, 
                success : function( result ){
                    
                        if(result.companyName=="현대택배"){
                            window.open('http://www.hydex.net/ehydex/jsp/home/distribution/tracking/tracingNView.jsp?param1='+result.trackingNumber,'배송조회', 'width=557, height=500'); //배송조회
                        }else if(result.companyName=="DHL"){
                            window.open('http://www.dhl.com/cgi-bin/tracking.pl?awb='+result.trackingNumber+'&LAN=KOR&TID=KR_KOR&LINKS=NO'  ,'배송조회'); //배송조회
                        }else if(result.companyName.indexOf("우체국") > -1){
                            window.open(result.epostUrl  ,'배송조회', 'width=700, height=713'); //배송조회
                        }else if(result.companyName=="QUICK"){
                            $.ajax({
                                type: "get",
                                url :  "/ko/mypage/order/deliveryHistory",
                                data : {"code":orderCode},          
                                dataType : "json",
                                async : false,
                                error : function( request, status, error ){     
                                    alert(error);
                                }, 
                                success : function( result ){
                                    var html = "";
                                    for(var i=0;i<result.length;i++){
                                        html += '<tr>';
                                        html += '    <td class="date">'+result[i].date+'</td>';
                                        html += '    <td class="status">'+result[i].status+'</td>';
                                        html += '</tr>';
                                    }
                                    html += '<tr>';
                                    html += '    <td colspan="2" class="last">※ 퀵배송 주문 후, 고객사유로 미수령 시 반품처리 됩니다.</td>';
                                    html += '</tr>';
                                    
                                    $("#quickDeliveryInfoBody").html(html);
                                    layerPopup("quickDeliveryInfo");
                                }
                            });
                        }else if(result.companyName.indexOf("CJ대한통운") > -1){
                            window.open(result.cjUrl  ,'배송조회', 'width=850, height=850'); //배송조회
                        }else if(result.companyName.indexOf("굿투럭") > -1){
                            window.open(result.goodsToLuckUrl  ,'배송조회', 'width=850, height=850'); //배송조회
                        }else{
                            layerAlert(result.companyName+"<br />"+result.trackingNumber);
                        }
                        
                }
            });
        });
    }
        
    orderList.doWork();
    
    
    var addrModFn = function(){
    
        
            var paramDatas = $("#addrModPop_clone #addrModForm" ).serialize();
        

        $.ajax({
            type: "post",
            url :  "/ko/mypage/order/updateorderaddr",
            data : paramDatas,          
            dataType : "json",
            error : function( request, status, error ){     
                alert(error)
            }, 
            success : function( result ){
                
                if(result=="SUCCESS"){
                    layerAlert("배송지 수정을 완료하였습니다.", true); //배송지 수정을 완료하였습니다.
                }else{
                    layerAlert("배송지 수정을 실패하였습니다."); //배송지 수정을 실패하였습니다.
                }
            }
        });
        
    };
    
    
        //통합맴버십 회원가입 요청
        $("#hpoinJoin").click(function(){
            var hdUrl = "https://www.h-point.co.kr/cu/join/start.nhd";
            window.open(hdUrl,"joinStart_window");
            
            document.getElementById("ptcoReqnMdaInf").value = "pc";
            $("#hpointHiddenForm").attr("action", hdUrl);
            $("#hpointHiddenForm").submit();
        });
        
        // 한섬 멤버십 통합 전환 여부 조회
        
        $.ajax({
            url      : '/ko/mypage/searchHpMemberList?CSRFToken=54615532-9dce-4a5b-85a2-4831f453120c',
            type     : 'POST',
            dataType : 'json',
            data     : { custNm : "황명하", custMpNo : "010-8434-2676" },
            success  : function(data) {
                if ( data != null ) {
                    var membershipCnt = data.length;
                    if(membershipCnt > 1 && getCookie("mergeInfoPopup") == '') {
                        membershipMergeInfoPopup();
                    }
                }
            }
        });
        
});

function hideProductLayer() {
    $("#productLayer .layerBg").removeClass("white");
    $("#productLayer").hide();
}

var eGiftBuySmsReSend = function(obj, orderCode, eGiftCardCode) {
    var lc = new layerConfirm("SMS 재전송은 1회 가능합니다.<br />재전송하시겠습니까?"); 
    
    lc.confirmAction = function(){

        $.ajax({
            type: 'GET',
            url: "/ko/mypage/order/eGiftBuySmsReSend",
            async: false,
            data : {"orderCode" : orderCode
                    ,"eGiftCode" : eGiftCardCode},          
            dataType : "json",
            success: function(data) {
                if (data == true) {
                    //$(obj).css("display", "none");
                    
                    $("#reSendEGift").removeClass("wt_ss");
                    $("#reSendEGift").addClass("dis_ss");
                    $("#reSendEGift").css("margin-top:10px;min-width:69px;");
                    $("#reSendEGift").attr("href","javascript:void(0);");
                    
                    layerAlert("재전송하였습니다.");
                } else {
                    layerAlert("재전송에 실패하였습니다.");
                }
            },
            error: function(xhr, status, err) {
                // var console = window.console || {log:function(){}};
                // console.log("status : " + status + "\n error : " + err);
            }
       });
        
    };
}



var returnConfirm = function(code){
	$.ajax({
		type: "get",
		url :  "/ko/mypage/order/getorderreturninfo?code="+code,
		dataType : "json",
		cache: false,
		error : function( request, status, error ){
			alert(error);
			//console.log( "code:" + request.status+"\n" + "message:" + request.responseText+"\n" + "error:" + error );
		}, 
		success : function( result ){
			
			if(result.data.entries==null){
				layerAlert("반품 신청이 가능한 수량이 없습니다.");
				return;
			}else{
				
				location.href="/mypage/order/returnrequest?code="+code;
				
			}
		}
	});
	
};

var globalCancelRequest = function(code) {
	var alertTag;
	alertTag = '<div class="layerArea" style="z-index:1110;display:none" id="layerDiv">';
	alertTag +='    <div class="layerBg"></div> ';
	alertTag +='    <div class="popwrap w_type_1" style="z-index:150;"> ';
	alertTag +='        <div class="pop_cnt">';
	alertTag +='            <p class="pop_txt_190911">mypage.order.history.list.global.cancel.message1</p>';
	alertTag +='            <p class="pop_txt_190911">mypage.order.history.list.global.cancel.message2</p>';
	if("ko" == "zh") {
		alertTag +='            <p class="pop_txt_190911">mypage.order.history.list.global.cancel.message3</p>';
	}
	alertTag +='            <div class="btnwrap">';
	alertTag +='                <input type="button" class="btn wt_s mr0" value="취소">';
	alertTag +='                <input type="button" class="btn gray_s mr0" value="text.button.ok">';
	alertTag +='            </div>';
	alertTag +='        </div>';
	alertTag +='        <a href="javascript:void(0);" class="btn_close"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>';
	alertTag +='    </div>';
	alertTag +='</div>';
	
	var la = new globalCancelLayerAlert(alertTag);
	la.confirmAction = function() {
		location.href = "/ko/mypage/order/cancelrequest?code="+code;
	};
};

var globalCancelLayerAlert = function(tag){
	var t = this;
	var scrollTopCurrent = $(window).scrollTop();
	var $alertLayer = $(tag).appendTo($("body"));
	
	this.confirmAction = function(){};
	
	$alertLayer.find('.popwrap').css('marginTop', getMarginTop2(250,scrollTopCurrent));
	$("#layerDiv").show();
	
	var existedStyle = $('body').attr('style') || '';
	if (existedStyle) {
		existedStyle += ';';
	}
	
	$('body').attr('style', existedStyle + 'overflow:hidden !important');
	$alertLayer.find('.popwrap').css('marginTop', getMarginTop($alertLayer.find('.popwrap').outerHeight()));
	$alertLayer.find('.btn.gray_s').click(function(){
		$('body').attr('style', existedStyle);
		$alertLayer.remove();
		t.confirmAction();
	});
	
	$alertLayer.find('.layerBg, .btn_close, .btn.wt_s').click(function(){
		$('body').attr('style', existedStyle);
		$alertLayer.remove();
	});
};

function reviewReturnConfirm(code) {
	var rtn;
	$.ajax({
		type: "get",
		url :  "/ko/mypage/order/getorderreturninfo?code="+code,
		dataType : "json",
		cache: false,
		async: false,
		error : function( request, status, error ){
			alert(error);
		},
		success : function( result ){
			if(result.data.entries==null){
				rtn = "F";
			}else{
				rtn = "T";
			}
		}
	});
	
	return rtn;
}

function GA_Mypage(action, e){
	var eventAction;
	var label;
	
	if(action == "wish"){
		eventAction = "위시리스트";
		label = e.find(".tlt").text();
	}
	
	GA_Event("마이페이지", eventAction, label);
}
//]]>

function getExchangeRate(price) {
	
		var currencyCode = "CNY";
		var exchangeRate = "189.51";
		var symbol = "¥";
		
		if("ko" == "en") {
			if(currencyCode == "USD") {
				return symbol + " " + addComma(Math.round(parseFloat(price) / parseFloat(exchangeRate) * 100) / 100);
			}
		} else {
			if(currencyCode == "CNY") {
				return symbol + " " + addComma(Math.round(parseFloat(price) / parseFloat(exchangeRate) * 100) / 100);
			}
		}
	
		var currencyCode = "USD";
		var exchangeRate = "1265.7";
		var symbol = "$";
		
		if("ko" == "en") {
			if(currencyCode == "USD") {
				return symbol + " " + addComma(Math.round(parseFloat(price) / parseFloat(exchangeRate) * 100) / 100);
			}
		} else {
			if(currencyCode == "CNY") {
				return symbol + " " + addComma(Math.round(parseFloat(price) / parseFloat(exchangeRate) * 100) / 100);
			}
		}
	
}

function membershipMergeInfoPopup() {
	var popupTag = '';
	popupTag += '<div class="layerArea" style="z-index:1110;display:none" id="layerDiv">';
	popupTag +='	<div class="layerBg"></div> ';
	popupTag += '	<div class="popwrap w_type_1 membership-alert" style="z-index: 150; margin-top: 220px;" tabindex="-1">';
	popupTag += '		<div class="in-pd">';
	popupTag += '			<div class="pop_cnt">';
	popupTag += '				<h3 class="pop_tlt">한섬 멤버십 통합 전환</h3>';
	popupTag += '				<p class="pop-sub-txt">';
	popupTag += '					한섬 오프라인 &amp; 온라인<br>';
	popupTag += '					(더한섬닷컴, H패션몰, EQL) 멤버십을<br>';
	popupTag += '					통합하여 사용하실 수 있습니다.<br><br>';
	popupTag += '					한섬 멤버십 통합을 진행 하실려면<br>';
	popupTag += '					‘한섬 멤버십 통합 전환 바로가기’를 선택해 주세요.';
	popupTag += '				</p>';
	popupTag += '				<div class="btnwrap">';
	popupTag += '					<input class="btn gray" value="한섬 멤버십 통합 전환 바로가기" type="button">';
	popupTag += '				</div>';
	popupTag += '			</div>';
	popupTag += '			<a href="#" class="btn_close"><img src="/resources/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>';
	popupTag += '		</div>';
	popupTag += '		<div class="day-check-zone" style="background:#f3f3f3">';
	popupTag += '			<label>';
	popupTag += '				<input type="checkbox" onclick="dayClose(\'mergeInfoPopup\', \'Y\', 1);">';
	popupTag += '				<span style="color:#555;">오늘 그만 보기</span>';
	popupTag += '			</label>';
	popupTag += '		</div>';
	popupTag += '	</div>';
	popupTag += '</div>';
	
	var la = new mergeInfoPopupLayerAlert(popupTag);
	la.confirmAction = function() {
		location.href = "/ko/mypage/mergeCustomerInfo";
	};
}

var mergeInfoPopupLayerAlert = function(tag) {
	var t = this;
	var scrollTopCurrent = $(window).scrollTop();
	var $alertLayer = $(tag).appendTo($("body"));
	
	this.confirmAction = function(){};
	
	$alertLayer.find('.popwrap').css('marginTop', getMarginTop2(250,scrollTopCurrent));
	$("#layerDiv").show();
	
	var existedStyle = $('body').attr('style') || '';
	if (existedStyle) {
		existedStyle += ';';
	}
	
	$('body').attr('style', existedStyle + 'overflow:hidden !important');
	$alertLayer.find('.popwrap').css('marginTop', getMarginTop($alertLayer.find('.popwrap').outerHeight()));
	$alertLayer.find('.btn.gray').click(function(){
		$('body').attr('style', existedStyle);
		$alertLayer.remove();
		t.confirmAction();
	});
	
	$alertLayer.find('.layerBg, .btn_close, .btn.wt_s').click(function(){
		$('body').attr('style', existedStyle);
		$alertLayer.remove();
	});
};

function dayClose(cName, cValue, cDay) {
	$("#layerDiv").hide();
	var currentDate = new Date();
	var expire = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate() + cDay, 0, 0, 0);
	cookies = cName + '=' + escape(cValue) + '; path=/ ';
	if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
	document.cookie = cookies;
}

function updateStatus(psid, oid){
	var orderItemVO ={
		'psid': psid,
		'oid' : oid
	}
	var json = JSON.stringify(orderItemVO);   
	$.ajax({
		type : 'POST',
		url : '/order/updateOrder',
		data : json,
		contentType: 'application/json; charset=utf-8',
		dataType: 'text',
		success: function(data){
			alert('배송에 성공했습니다. ');
			console.log(data);
			location.href="/admin/adminPage";
		},
		error: function(request, status, error){
			
			alert('주문에 실패했습니다.');
		}
	})
}
</script>
    <form id="hpointHiddenForm" method="post" action="" target="joinStart_window">
        <input type="hidden" name="prtnrReqGb" value="02">
        <input type="hidden" name="prtnrId" value="D080">
        <input type="hidden" name="chnnlId" value="1705">
        <input type="hidden" name="ptcoReqnMdaInf" id="ptcoReqnMdaInf" value="">
    </form>
    <form id="orderSearchForm" action="/ko/mypage/order/myorderlist">
        <input type="hidden" name="sterm" class="input_date" title="기간 입력" id="sterm" value="2022-04-05" readonly="">
        <input type="hidden" name="eterm" class="input_date" title="기간 입력" id="eterm" value="2022-05-05" readonly="">
    </form>
    <!-- 회원정보 -->
    <div class="profile_info1 clearfix review_betterment1905">
            <div class="name ">
                    <span class="ico_grade">${sessionScope.user.mname}&nbsp;<span>님</span></span>
                    <span class="grade_txt" id="grade_txt"></span>
                </div>
                <div class="pointbox_cover">
	                <div class="point_wrap">
	                    <div class="point" style="border-left:0;padding-left:0;">
	                        <p class="title">관리자계정</p>
	                    </div>
	                    </div>
                </div>
            </div>
    <!-- 회원정보 -->
    <!-- 접수된 주문(황명하) -->
    <div class="title_wrap">
        <h4 class="float_left">접수된 주문<!-- 최근주문 --></h4>
        <p class="txt_line">최근 1개월 내 주문된 내역입니다.<!-- 최근 1개월 내 주문하신 내역 입니다. --></p>
        <div class="btn_wrap">
            <a href="/ko/mypage/order/myorders" class="btn add_ss" onclick="GA_Event('마이페이지','최근주문','전체보기');">전체보기<!-- 전체보기 --></a>
        </div>
    </div>
    <!-- table -->
    <div class="tblwrap lncl1812"><!-- 클래스추가 181204 -->
        <table class="tbl_ltype review_betterment1905">
            
            <colgroup class="interval1812"><!-- 수정 181204 -->
                <col style="width:120px">
                
                <col style="">
                <col style="width:107px">
                <col style="width:200px">
                <col style="width:96px">
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">주문번호<!-- 주문번호 --></th>
                    <th scope="col">상품정보<!-- 상품정보 --></th>
                    <th scope="col" style="padding:15px 0">수량<!-- 수량 --></th><!-- 스타일추가 181204 -->
                    <th scope="col">판매가<!-- 판매가 --></th>
                    <th scope="col">주문상태<!-- 주문상태 --></th>
                </tr>
            </thead>
            <tbody id="listBody">
				<c:choose>
					<c:when test="${cartList.size()} eq 0">
						<tr>
							<td colspan="6" class="no_data">최근 한 달간 주문내역이 없습니다.<!-- 최근 한 달간 주문내역이 없습니다. --></td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="order" items="${orderList}" varStatus="status">
							<tr>
								<td scope="col"> ${order.oid}</td>
								<td scope="col"> ${order.pname}</td>
								<td scope="col"> ${order.oicount}</td>
								<td scope="col"> ₩ <fmt:formatNumber value="${order.oitotalprice}" pattern="#,###"/></td>
								<td><button type="button" class="btn" onclick='updateStatus("${order.psid}", "${order.oid}")'>배송하기</button></td>
								
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
                
            </tbody>
        </table>
    </div>
    <!-- table -->
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
	
	if("true"){
		
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
		url = "/ko/mypage/reviewWriteNew";
	} else {
		url = "/ko/mypage/modifyCustomerReview";
	}
	
	if ($('#packopt').is(':checked')) {
		$("#purchaseProdYN").val("Y");
	}else {
		$("#purchaseProdYN").val("N");
	};
	
	$("#reviewHeadline").val(encodeText($("#reviewHeadline").val()));
	
	
	var checkCategory = checkCategoryType($("#categoryCode").val());
	if(checkCategory == "top" || checkCategory == "bottoms") {
		if(checkCategory == "top") {
			$('input[name="shoulderWidth"]').each(function(index){
				if ($(this).is(':checked')) {
					$("#shoulderWidth").val($(this).val());
				}
			});
			$('input[name="chestSize"]').each(function(index){
				if ($(this).is(':checked')) {
					$("#chestSize").val($(this).val());
				}
			});
		} else if(checkCategory == "bottoms") {
			$('input[name="waistSize"]').each(function(index){
				if ($(this).is(':checked')) {
					$("#waistSize").val($(this).val());
				}
			});
			$('input[name="buttSize"]').each(function(index){
				if ($(this).is(':checked')) {
					$("#buttSize").val($(this).val());
				}
			});
		}
		$('input[name="totalSize"]').each(function(index){
			if ($(this).is(':checked')) {
				$("#totalSize").val($(this).val());
			}
		});
		$('input[name="realProductColor"]').each(function(index){
			if ($(this).is(':checked')) {
				$("#realProductColor").val($(this).val());
			}
		});
	}
	// 분기 처리 대상
		
	
	var liSize = $('form[name=reviewForm] .file_image_wrap2003 li').size();
    var fileSize = $('form[name=reviewForm] .upload_btn input[type=file]').size();
    //사진 전체 삭제여부 체크
    if(liSize == 0){
		$("#fileDeleteYN").val("Y");
	}
	
	if ( fileSize <= 1 ) {
		var param = $('form[name=reviewForm]').serialize();
		
		$.ajax({
			url	 : url + '?CSRFToken=54615532-9dce-4a5b-85a2-4831f453120c',
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
			url	 : url + '?CSRFToken=54615532-9dce-4a5b-85a2-4831f453120c',
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
										
	reviewhtml += "                                 <strong class='reqd' style='margin-top:1px;'>*</strong>";
	reviewhtml += "                                 상품평<br/>";
	reviewhtml += "                                 <label for='lb1'>";
	reviewhtml += "                                     <span class='subtxt_1905'>";
	reviewhtml += "                                         (20자 이상<br/>&nbsp;200자 이하)";
	reviewhtml += "                                     </span>";
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
		
	reviewhtml += "                     <br/>";
			
	reviewhtml += "                     <span>- 더한섬닷컴에서 구매한 상품의 상품평을 배송완료 30일 이내 작성 시, 추가 마일리지를 지급합니다.</span><br/>";
			
	reviewhtml += "                     - 마일리지 지급에 대한 상세 내용은 마이페이지>내 상품평 페이지에서 확인 부탁드립니다.<br/>";
	reviewhtml += "                     &nbsp;&nbsp;(마일리지 적립은 오프라인 구매 및 간편회원 제외)";
		
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


<%@include file= "admin_footer.jsp" %>