<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
	&#45908;&#54620;&#49452;&#45815;&#52980; | THE HANDSOME.COM</title>
	<link rel="shortcut icon" href="http://cdn.thehandsome.com/_ui/desktop/common/images/common/thehandsome_ic_16x16.ico" />
	<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/font_80.css" media="all" />
	    <link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/common.css" media="all" />
	<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/layout.css" media="all" />
	<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/popup.css" media="all" />
	<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/jquery-ui.min.css" media="all" />
	
	<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/brand.css" media="all" />
	<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/swiper.css" media="all" />
	<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/main_201903.css" media="all" />
	<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/footer.css" media="all" />
	<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/products.css" media="all" />
	<style type="text/css" media="print">
		@IMPORT url("/resources/_ui/desktop/common/blueprint/print.css");
	</style>
	
	<script type="text/javascript" src="/resources/_ui/desktop/common/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="/resources/_ui/desktop/common/js/jquery.vticker.js"></script><!-- 200318 ???????????? -->

</head>
<body>
<div class="popwrap w_type_4" id="customerReviewDiv" style="position: absolute; z-index: 101;">
	<a href="/product/productDetail?pId=${param.pId}" class="btn_close"><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png" alt="??????"></a>
    <!--???????????? ???????????? 1906 -->
    <div class="mileage_info_wrap1906">
        <p class="wrap_heading">????????? ?????? ??? ?????? ??????????????? ?????????!</p>
        <div class="mileage_info_box">
            <div class="review_w">
                <p class="review_w_tit">??? ????????? ?????? ????????? ?????? ???</p>
                <ul>
                    <li>
                        <div class="ico_mileage1906">
                            ????????????
                        </div>
                        <p><strong>????????????</strong><br>??????????????? <b>0.5%</b></p>
                    </li>
                    <li>
                        <div class="ico_mileage1906">
                            ???????????????
                        </div>
                        <p><strong>???????????????</strong><br>??????????????? <b>0.1%</b></p>
                    </li>
                    <li>
                        <div class="ico_mileage1906">
                            ???????????????
                        </div>
                        <p><strong>???????????????</strong><br>(????????? ??????)<br><b>2,000????????????</b></p>
                    </li>
                </ul>
            </div>
            <div class="best_review">
                <p class="review_w_tit">??? ?????????/???????????? ??????</p>
                <ul>
                    <li>
                        <div class="ico_mileage1906">
                            ???????????????
                        </div>
                        <p><strong>???????????????</strong><br>?????? 5??? <b>10??????</b> ?????????</p>
                    </li>
                </ul>
            </div>
        </div>
    </div>
        <!--//???????????? ???????????? 1906 -->
    <div class="pop_tltwrap2 pb0 customerreviewdiv1905">
    
        <h3>
            ?????????(<span id="review_cnt" class="review_cnt">${pageMaker.total}</span>)
        </h3>
        <div class="star_score1807" id="totalStarScoreWrapper" style="display: inline-block;">
            <span class="">
   
            </span>
        </div>
        <c:forEach items="${reviewList}" var="review" end="0">
        	<c:choose>
        		<c:when test="${empty sessionScope.user}">
        		</c:when>
        		<c:otherwise>
        			<a href="/review/reviewInsert?pId=${param.pId}&pName=${review.PName}" class="btn_evaluation1905" id="addReviewBtn" onclick="">????????? ????????????</a>
        		</c:otherwise>	
        	</c:choose>
        </c:forEach>
    </div>
    <!-- pop_cnt-->
    <div class="pop_cnt evaluation_list1807 options">
        <div class="tab_a m3 mt20">
        </div>
        <div class="clearfix review_tab1_1807">
            <ul>        
            	<c:choose>
	            	<c:when test="${empty reviewList}">
		            	<li class="evaluation_view no_list_data1905" style="text-align:center">
		            		????????? ???????????? ????????????.<br>??? ????????? ?????? ??? ?????? ?????? ?????? ??????????????????~
		            	</li>
		            </c:when>
		            <c:otherwise>
		            	<c:forEach items="${reviewList}" var="review" varStatus="status">
			            	<li class="evaluation_view" id="evaluation_view0">
			            		<div class="member_info_top">    
			            			<ul>        
			            				<li class="name">${review.MId}</li>      	            			        
			            				<li class="date">${review.RDate}</li>                    				
			            				<c:if test="${review.MId == sessionScope.user.mid}">
				            				<a href="/review/reviewModify?rNo=${review.RNo}&pId=${review.PId}">??????</a>
				            				<a href="/review/remove?rNo=${review.RNo}&pId=${review.PId}">??????</a>				            				
			            				</c:if>
			            			</ul>        
			            		</div>  
			            		<div class="review_represent_img1912">    
			            			<img src="/resources${review.RImage}" alt="" onclick="window.open(this.src)"/>
			            		</div>          	
			            		<div class="review_txt_wrap">    
			            			<p class="review_txt">${review.RContent}</p>
			            		</div>
			            	</li>
			            </c:forEach>		            	
		            </c:otherwise>
		    	</c:choose>
            </ul>		
		</div>
       </div>
        <!-- paging -->
        <div class="paging mt30" id="reviewPagingDiv">
            	<a class="prev2" href="/review/productReview?pId=${param.pId}&pageNum=1&amount=${pageMaker.amount}">?????? ???????????? ??????</a>
            	<c:choose>
              		<c:when test = "${pageMaker.pageNum == pageMaker.startPage}">
            			<a href="/review/productReview?pId=${param.pId}&pageNum=${pageMaker.pageNum}&amount=${pageMaker.amount}" class="prev">?????? ???????????? ??????</a>
            		</c:when>
            		<c:otherwise>
            			<a href="/review/productReview?pId=${param.pId}&pageNum=${pageMaker.pageNum - 1}&amount=${pageMaker.amount}" class="prev">?????? ???????????? ??????</a>
            		</c:otherwise>
            	</c:choose>         
                <span class="num">
                	<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <a href="/review/productReview?pId=${param.pId}&pageNum=${num}&amount=${pageMaker.amount}" class="pageBtn">${num}</a>
                    </c:forEach>
                </span>              	
              	<c:choose>
              		<c:when test = "${pageMaker.pageNum == pageMaker.endPage}">
            			<a href="/review/productReview?pId=${param.pId}&pageNum=${pageMaker.pageNum}&amount=${pageMaker.amount}" class="next">?????? ???????????? ??????</a>
            		</c:when>
            		<c:otherwise>
            			<a href="/review/productReview?pId=${param.pId}&pageNum=${pageMaker.pageNum + 1}&amount=${pageMaker.amount}" class="next">?????? ???????????? ??????</a>
            		</c:otherwise>
            	</c:choose>
            	<a href="/review/productReview?pId=${param.pId}&pageNum=${pageMaker.endPage}&amount=${pageMaker.amount}" class="next2">????????? ???????????? ??????</a>
        </div>
        <!-- //paging -->
    </div>
    <!--// pop_cnt-->
</body>
</html>