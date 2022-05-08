<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp" %>
	</div>
</div>
<script src="https://googleads.g.doubleclick.net/pagead/viewthroughconversion/943253288/?random=1651452416636&amp;cv=9&amp;fst=1651452416636&amp;num=1&amp;guid=ON&amp;resp=GooglemKTybQhCsO&amp;u_h=1080&amp;u_w=1920&amp;u_ah=1040&amp;u_aw=1920&amp;u_cd=24&amp;u_his=6&amp;u_tz=540&amp;u_java=false&amp;u_nplug=5&amp;u_nmime=2&amp;sendb=1&amp;ig=1&amp;frm=0&amp;url=http%3A%2F%
2Fwww.thehandsome.com%2Fko%2Fc%2Fbe031%2F&amp;ref=http%3A%2F%2Fwww.thehandsome.com%2Fko%2Fc%2Fme031%2F&amp;tiba=%EB%8D%94%ED%95%9C%EC%84%AC%EB%8B%B7%EC%BB%B4&amp;hn=www.googleadservices.com&amp;rfmt=3&amp;fmt=4"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/7f85a56ba4.css">
<script src="https://static.uni1id.com/jsf/common/enp_uni_id_adver.js" type="text/javascript" defer="" async=""></script>

<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/products.css" media="all" />
<link rel="stylesheet" type="text/css" href="/resources/_ui/desktop/common/css/contents.css" media="all" />

<div id="bodyWrap" class="products">
    <h3 class="cnts_title ou1804">
        <!-- 선택한 카테고리 목록 -->
        <span>
        	<c:if test="${param.level == 1}">
            	<a href="#" onclick="">남성</a>
            </c:if>
            <c:if test="${param.level == 2}">
	            <a href="#" onclick="">남성</a>
	            <img src="http://cdn.thehandsome.com/_ui/desktop/common/images/products/ou_location_arr.png" alt="location arr">
	            <a href="#" onclick="">아우터</a>
            </c:if>
            <c:if test="${param.level == 3}">
	            <a href="#" onclick="">남성</a>
	            <img src="http://cdn.thehandsome.com/_ui/desktop/common/images/products/ou_location_arr.png" alt="location arr">
	            <a href="#" onclick="">아우터</a>
	            <img src="http://cdn.thehandsome.com/_ui/desktop/common/images/products/ou_location_arr.png" alt="location arr">
	            <a href="#" onclick="">${productList[0].categoryVO.cateName}</a>
            </c:if>
        </span>
        <!-- // 선택한 카테고리 목록 -->
    </h3>
    <div class="adaptive_wrap">     
            <!-- sort wrap -->
            <div class="filterWrap hsDelivery1902">             
                <div class="items_count float_right">
                    <span class="num">${pageMaker.total}</span><span>전체</span>
                </div>
            </div>
        </form>
        <div class="items_list" id="listContent" style="display: block;">
            <ul class="clearfix" id="listBody" style="display: block;">
            	<c:forEach items="${productList}" var="product" varStatus="status">            		
            		<c:choose>
	            		<c:when test="${status.index  % 4 != 3}">
			                <li> 
			                    <div class="item_box"> 
			                        <a href="/product/productDetail?pId=${product.PId}" class="item_info1" onclick=""> 
			                        <span class="item_img"> 
			                            <img src="${product.productColorVO.pcChipImg}" id="T01_IMG_0" alt="[MAISON LOUIS MARIE] NO.09 발레 드 파니 바디 로션 237ml" targetcode="CS2C3HCO019LMZ_NA" class="respon_image" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'"> 
			                            <img src="${product.productColorVO.pcImg1}" id="T02_IMG_0" alt="[MAISON LOUIS MARIE] NO.09 발레 드 파니 바디 로션 237ml" targetcode="CS2C3HCO019LMZ_NA" class="respon_image on" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'" style="display: none; opacity: 1;"> 
			                            <input type="hidden" id="newImage1_0" value="http://newmedia.thehandsome.com/CS/2C/SS/CS2C3HCO019LMZ_NA_T01.jpg">                
			                            <input type="hidden" id="newImage2_0" value="http://newmedia.thehandsome.com/CS/2C/SS/CS2C3HCO019LMZ_NA_T02.jpg">            
			                        </span> 
			                        <span class="item_size" id="itemsize_0" style="display: none; height: 1.67105px; padding-top: 0.664475px; margin-top: 0px; padding-bottom: 0.664475px; margin-bottom: 0px;"> 
			                            <div id="CS2C3HCO019LMZ_NA"> <span><c:out value="${status.index}"/></span></div> 
			                        </span> 
			                        </a> 
			                        <a href="/product/productDetail?pId=${product.PId}" class="item_info2" onclick=""> 
			                            <span class="brand">${product.brandVO.BName}</span> 
			                            <span class="title">${product.PName}</span> 
			                            <span class="price">₩ <span id="price_CS2C3HCO019LMZ_NA"><fmt:formatNumber value="${product.productColorVO.pcPrice}" pattern="#,###"/><span></span></span></span> 
			                            <span class="flag"> 
			                                <span class="product"></span> 
			                            </span> 
			                        </a> 			                       
			                        <a href="javascript:addWishListClick('CS2C3HCO019LMZ');" class="add_wishlist " id="wish_CS2C3HCO019LMZ" onclick="GA_Category('wish', $(this));brazeLogCustomEvent('0');" data-value="CS2C3HCO019LMZ_NA">위시리스트 담기</a> 
			                    </div> 	              
			                </li>
		                </c:when>
		                <c:otherwise>
		                	<li class="mr1m"> 
		                    <div class="item_box"> 
		                        <a href="/product/productDetail?pId=${product.PId}" class="item_info1" onclick=""> 
		                        <span class="item_img"> 
		                            <img src="${product.productColorVO.pcChipImg}" id="T01_IMG_0" alt="" targetcode="CS2C3HCO019LMZ_NA" class="respon_image" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'"> 
		                            <img src="${product.productColorVO.pcImg1}" id="T02_IMG_0" alt="" targetcode="CS2C3HCO019LMZ_NA" class="respon_image on" onerror="this.src='http://cdn.thehandsome.com/_ui/desktop/common/images/products/no_img3.jpg'" style="display: none; opacity: 1;"> 
		                            <input type="hidden" id="newImage1_0" value="">                
		                            <input type="hidden" id="newImage2_0" value="">            
		                        </span> 
		                        <span class="item_size" id="itemsize_0" style="display: none; height: 1.67105px; padding-top: 0.664475px; margin-top: 0px; padding-bottom: 0.664475px; margin-bottom: 0px;"> 
		                            <div id="CS2C3HCO019LMZ_NA"> <span><c:out value="${status.index}"/></span></div> 
		                        </span> 
		                        </a> 
		                        <a href="/product/productDetail?pId=${product.PId}" class="item_info2" onclick=""> 
		                            <span class="brand">${product.brandVO.BName}</span> 
		                            <span class="title">${product.PName}</span> 
		                            <span class="price">₩ <span id="price_CS2C3HCO019LMZ_NA"><fmt:formatNumber value="${product.productColorVO.pcPrice}" pattern="#,###"/><span></span></span></span> 
		                            <span class="flag"> 
		                                <span class="product"></span> 
		                            </span> 
		                        </a> 
		                        <a href="javascript:addWishListClick('CS2C3HCO019LMZ');" class="add_wishlist " id="wish_CS2C3HCO019LMZ" onclick="GA_Category('wish', $(this));brazeLogCustomEvent('0');" data-value="CS2C3HCO019LMZ_NA">위시리스트 담기</a> 
		                    </div> 	                 
		                	</li>
	                	</c:otherwise>
	            	</c:choose>    	             
	          	</c:forEach>              
              </ul>
        </div>
        <div class="paging" style="display: block;">
            	<a class="prev2" href="/product/productList?cateNo=${param.cateNo}&pageNum=1&amount=${pageMaker.amount}&level=${param.level}">처음 페이지로 이동</a>
            	<c:choose>
              		<c:when test = "${pageMaker.pageNum == pageMaker.startPage}">
            			<a href="/product/productList?cateNo=${param.cateNo}&pageNum=${pageMaker.pageNum}&amount=${pageMaker.amount}&level=${param.level}" class="prev">이전 페이지로 이동</a>
            		</c:when>
            		<c:otherwise>
            			<a href="/product/productList?cateNo=${param.cateNo}&pageNum=${pageMaker.pageNum - 1}&amount=${pageMaker.amount}&level=${param.level}" class="prev">이전 페이지로 이동</a>
            		</c:otherwise>
            	</c:choose>         
                <span class="num">
                	<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <a href="/product/productList?cateNo=${param.cateNo}&pageNum=${num}&amount=${pageMaker.amount}&level=${param.level}" class="pageBtn">${num}</a>
                    </c:forEach>
                </span>              	
              	<c:choose>
              		<c:when test = "${pageMaker.pageNum == pageMaker.endPage}">
            			<a href="/product/productList?cateNo=${param.cateNo}&pageNum=${pageMaker.pageNum}&amount=${pageMaker.amount}&level=${param.level}" class="next">다음 페이지로 이동</a>
            		</c:when>
            		<c:otherwise>
            			<a href="/product/productList?cateNo=${param.cateNo}&pageNum=${pageMaker.pageNum + 1}&amount=${pageMaker.amount}&level=${param.level}" class="next">다음 페이지로 이동</a>
            		</c:otherwise>
            	</c:choose>
            	<a href="/product/productList?cateNo=${param.cateNo}&pageNum=${pageMaker.endPage}&amount=${pageMaker.amount}&level=${param.level}" class="next2">마지막 페이지로 이동</a>
        </div>       
    </div>
</div>
<%@include file="../include/footer.jsp" %>