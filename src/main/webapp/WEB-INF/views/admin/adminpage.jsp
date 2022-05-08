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
			<h4><a href="/admin/adminpage">마이페이지<!-- 마이페이지 --></a></h4>
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
    
    $("#menuTitle").text("마이페이지");
    
    dateData();
   
        
});

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
			location.href="/admin/adminpage";
		},
		error: function(request, status, error){
			
			alert('주문에 실패했습니다.');
		}
	})
}
</script>
  
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

<%@include file= "admin_footer.jsp" %>