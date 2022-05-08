<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file= "member_header.jsp" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
<c:when test="${empty sessionScope.user}">
<script>
location.href ='/member/login';
</script>
</c:when>
</c:choose>

<div id="bodyWrap">
	<h3 class="cnts_title">
		<span id="menuTitle">마이페이지</span>
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
			<h4><a href="/member/mypage">마이페이지<!-- 마이페이지 --></a></h4>
			<div class="lnb">
						<dl>
							<dt>주문조회</dt>
							<dd><a href="/member/mypage" onclick="GA_Event('마이페이지','LNB','주문/배송/반품/취소');">주문</a></dd>
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
//<![CDATA[ 
$(document).ready(function(){
    //마스킹 처리
    $(".ico_grade").html(maskingName($(".ico_grade").html()));
    
	$(".btn_close").on("click", function(){//팝업 닫기
        hideProductLayer();
        $(".popwrap").hide();
    });
	
});

//]]>


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
	                        <p class="title">한섬마일리지</p>
	                        <a class="count" href="/ko/mypage/mypoint" onclick="GA_Event('마이페이지','회원정보','한섬마일리지');">${sessionScope.user.mmileage}&nbsp;<span>M</span></a>
	                    </div>
	                     <div class="point">
                             <p class="title">H.POINT</p>
                             <!-- 간편회원인 경우 H.POINT 조회 불가(황명하) -->
                             <c:choose>
                             <c:when test="${sessionScope.user.mlogintype != '간편회원'}">
                             <a class="count" href="https://www.h-point.co.kr/cu/myh/myPnt.shd" target="_blank" onclick="GA_Event('마이페이지','회원정보','H.POINT');">1000&nbsp;</a>
                             </c:when>
                             <c:otherwise>
                             <a class="count" href="https://www.h-point.co.kr/cu/myh/myPnt.shd" target="_blank" onclick="GA_Event('마이페이지','회원정보','H.POINT');">사용불가&nbsp;</a>
                             </c:otherwise>
                             </c:choose>
                         </div>
	                        
	                    <div class="point">
	                        <p class="title">COUPON</p>
	                        <a class="count" href="/member/voucher" onclick="GA_Event('마이페이지','회원정보','COUPON');">0&nbsp;<span>장</span></a>
	                    </div>
	                    <div class="point review">
							<p class="title">상품평</p>
							<img src="/resources/_ui/desktop/common/images/common/ico_ques2.png" alt="상품평이란?" class="tlt">
							<a href="/mypage/myreview" class="count" onclick="GA_Event('마이페이지','회원정보','상품평');">0&nbsp;<span>개</span></a>
						</div>
	                    </div>
                </div>
                
            </div>
    <!-- 회원정보 -->
    <!-- 최근주문 -->
    <div class="title_wrap">
        <h4 class="float_left">최근주문<!-- 최근주문 --></h4>
        
    </div>
    <!-- table -->
    <div class="tblwrap lncl1812"><!-- 클래스추가 181204 -->
        <table class="tbl_ltype review_betterment1905">
            <caption>상품평 리스트</caption>
            <colgroup class="interval1812"><!-- 수정 181204 -->
                <col style="width:100px">
                <col >
                <col >
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
							<td colspan="5" class="no_data">최근 한 달간 주문내역이 없습니다.<!-- 최근 한 달간 주문내역이 없습니다. --></td>
							
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="order" items="${orderList}" varStatus="status">
							<tr>
								<td scope="col"> ${order.oid}</td>
								<td scope="col"> ${order.pname}</td>
								<td scope="col"> ${order.oicount}</td>
								<td scope="col">₩ <fmt:formatNumber value="${order.oitotalprice}" pattern="#,###"/> </td>
								<c:choose>
									<c:when test="${order.ostatus eq '배송완료'}">
										<td scope="col" status = "${order.ostatus}" >배송완료</td>
									</c:when>
									<c:otherwise>
										<td scope="col" status = "${order.ostatus}"> 주문완료 </td>
									</c:otherwise>
								</c:choose>
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


<%@include file= "../include/footer.jsp" %>