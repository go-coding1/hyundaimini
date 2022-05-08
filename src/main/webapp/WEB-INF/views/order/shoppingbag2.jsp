<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
  <%@ include file="../include/header.jsp" %>
    <div id="bodyWrap" style="padding-bottom: 0;">
      <!-- title-->
      <h3 class="cnts_title cnts_tlt1807"><span>쇼핑백</span></h3>
      <!-- 장바구니-->
      <span id="shoppingbagCartView">
        <script>
          function click_tab(tab){
            if(tab == '택배'){
              //장바구니에 담김 상품중 택배 조회 ajax
            }else if(tab == '매장수령'){
              //장바구니에 담긴 상품중 매장 수령 조회 ajax
            }else if(tab == '퀵배송'){
              //장바구니에 담긴 상품중 퀵배송 수령 조회
            }
          }

        </script>
        <!--sub_container-->
        <div class="sub_container ">
          <!--order wrap-->
          <div class="shopping_cart_tab1807 tab_a">
            <!-- 장바구니개편 -->
            <ul class="tab3">
              <li>
                <a href="#;" name="cartDivision" data-division="" onclick="click_tab('택배');"><span
                    class="delt_ico"></span>택배 (1)</a>
              </li>
              <li>
                <a href="#;" name="cartDivision" data-division="store" onclick="click_tab('매장수령');"><span
                    class="spt_ico"></span>매장수령 (0)</a>
              </li>
              <li>
                <a href="#;" name="cartDivision" data-division="quick"
                  onclick="click_tab('퀵배송');"><span
                    class="quk_ico"></span>퀵배송 (0)</a>
              </li>
            </ul>
            <!-- //장바구니개편 -->
          </div>

          <div class="orderwrap1807">
            <div class="tbl_info_wrap">
              <p class="cart_top_text">
              </p>

              <div class="fourpm_pd_ck">
                <div class="input_wrap">
                </div>
              </div>
            </div>
            <!--shoppingback table-->
            <div class="tblwrap">
              <table class="tbl_ltype">
                <caption>
                  쇼핑백</caption>
                <colgroup>
                  <col style="width: 10px;" />
                  <col />
                  <col style="width: 120px" />
                  <col style="width: 105px" />
                  <!-- <col style="width: 140px" /> -->
                  <col style="width: 110px" />
                </colgroup>
                <thead>
                  <tr>
                    <th scope="col">
                      <!-- 2019.11.07 쇼핑백 진입 시 선택 상품 없도록 수정 -->
                      <input type="checkbox" id="entryCheckAll" value="cartlist">
                    </th>
                    <th scope="col">상품정보</th>
                    <th scope="col">수량</th>
                    <th scope="col">판매가</th>
                    <th scope="col">선택</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- 반복하는거 시작-->
                  <c:forEach var="cart" items="${cartList}" varStatus="status">
                  <tr name="entryProductInfo" data-pk="10681668861996" data-deliverykind="" data-outofstock="false"
                    data-category="ME032">
                    <td class="frt">
                      <!-- 2019.11.07 쇼핑백 진입 시 선택 상품 없도록 수정 -->
                      <input type="checkbox" name="cartlist" data-pk="10681668861996" data-division=""
                        data-deliverykind="" value="0">
                    </td>
                    <td class="pt_list_wrap">
                      <!-- pt_list_all -->
                      <div class="pt_list_all">
                        <img src="http://newmedia.thehandsome.com/TH/2C/SS/TH2C4WOT328M_SP_S01.jpg" alt="" />
                        
                        <div class="tlt_wrap">
                          <a href="#"
                            class="basket_tlt">
                            <span class="tlt">${cart.bname}</span>
                            <span class="sb_tlt">
                              ${cart.pname}</span>
                          </a>

                          <p class="color_op">

                            color : ${cart.pccolorcode}<span class="and_line">/</span>

                            size : ${cart.psize}</p>


                          <div class="option_wrap">
                            <a href="#none" class="btn_option" id="optOpenLayer^0^TH2C4WOT328M_SP"
                              onclick="GA_Event('쇼핑백','옵션변경', '모크넥 드로우스트링 점퍼')">옵션변경</a>
                          </div>
                        </div>
                      </div>
                      <!-- //pt_list_all-->
                    </td>
                    <td class="al_middle">
                      <form id="updateCartForm0"
                        data-cart="{&quot;cartCode&quot; : &quot;371680496&quot;,&quot;productPostPrice&quot;:&quot;790000.0&quot;,&quot;productName&quot;:&quot;모크넥 드로우스트링 점퍼&quot;}"
                        action="/ko/shoppingbag/update" method="post" style="text-align:center;"><input type="hidden" name="entryNumber"
                          value="0" />
                        <input type="hidden" name="productCode" value="TH2C4WOT328M_SP_100" />
                        <input type="hidden" name="initialQuantity" value="1" />
                        <input type="hidden" name="chgProductCode" value="" />
                        <input type="hidden" name="curSize" value="100" />
                        <input type="hidden" name="storeId" value="" />
                        <input type="hidden" name="storePickupDate" value="" />
                        <input type="hidden" name="deliveryKind" value="" />
                        <input type="hidden" name="cartDivision" value="" />
                        <!-- qty_sel -->
                        <span class="qty_sel num" >
                          <a href="#none" onMouseDown="javascript:AEC_F_D('TH2C4WOT328M_SP_100','o',1);" class="left"
                            onclick="GA_Event('쇼핑백', '수량', '-');">-</a>
                          <%-- <input id="quantity0" name="quantity" type="text" class="mr0" value="${cart.pquantity}" size="1"
                            maxlength="3" /> --%>
                            <input id= "quantity0" name="quantity" type="text" size="2" maxlength="3" value="${cart.pquantity }"/>
                            <a href="#none"
                            onMouseDown="javascript:AEC_F_D('TH2C4WOT328M_SP_100','i',1);" class="right"
                            onclick="GA_Event('쇼핑백', '수량', '+');">+</a>
                        </span>
                        <!-- //qty_sel -->
                        <a href="#none" id="QuantityProduct_0" class="btn wt_ss qty_w mr0">변경</a>
                        <div>
                          <input type="hidden" name="CSRFToken" value="d43028c9-c041-4b3e-9836-9ff7ea0af207" />
                        </div>
                      </form>
                    </td>
                    <td class="al_middle">
                      <!-- Price -->
                      <div class="price_wrap">
                        <span>₩${cart.pcprice * cart.pquantity}</span> <input type="hidden" name="checkZeroPrice" value="${cart.pcprice * cart.pquantity}" />
                      </div> <!-- //Price -->
                    </td>
                    <td class="al_middle">
                      <!-- Button size -->
                      <div class="btn_wrap">
                        <a href="#none" class="btn wt_ss"
                          onclick="callWishListClick('모크넥 드로우스트링 점퍼',$(this),'TH2C4WOT328M_SP_100');"
                          data-value="0">위시리스트</a>
                        <a href="#none" id="RemoveProduct_0" class="btn wt_ss"
                          onclick="GA_Event('쇼핑백','삭제','모크넥 드로우스트링 점퍼');">삭제</a>
                      </div> <!-- //Button size -->
                    </td>
                  </tr>
                </c:forEach>
                  <!-- 반복하는거 마무리-->
                  <!-- Info wrap -->
                  <tr>
                    <td colspan="6" class="basket_wrap">
                      <!-- Info -->
                      <div class="basket_info">
                        <span class="btn_arr">위치아이콘</span>
                        <div class="info">
                          <!-- Products -->
                          <div class="pt_list" id="pt_list_0">

                          </div>
                          <!-- //Products -->
                          <!-- btns -->
                          <div class="btns">
                            <a href="#none" class="btn wt_ss mr0" id="UpdateCart_0">변경</a>
                            <a href="#none" class="btn wt_ss mt10 mr0" id="optCancelLayer_0">취소</a>
                            <a href="#none" class="btn_close" id="optCloseLayer_0">닫기</a>
                          </div>
                          <!-- //btns -->
                        </div>
                      </div> <!-- //Info -->
                    </td>
                  </tr>
                  <tr>
                    <td colspan="6" class="basket_wrap">
                    </td>
                  </tr>


                  <!-- AceCounter eCommerce (Product_Detail) v7.5 Start -->
                  <!-- Data Allocation (Product_Detail) -->
                  <script language='javascript' type="text/javascript">
                    _A_amt[_ace_countvar] = "790000";
                    _A_nl[_ace_countvar] = "1";
                    _A_pl[_ace_countvar] = "TH2C4WOT328M_SP_100";
                    _A_pn[_ace_countvar] = "모크넥 드로우스트링 점퍼";
                    _A_ct[_ace_countvar] = "TIME HOMME";
                    _ace_countvar++;
                  </script>
                  <!-- AceCounter eCommerce (Cart_InOut) v7.5 End -->
                  <!-- //Info wrap -->
                </tbody>
              </table>
            </div>
            <!--// shoppingback table-->
            <!--Total wrap-->
            <div class="total_wrap">
              <!-- total -->
              <div class="total_price_wrap">
                <dl>
                  <dt>
                    상품 합계</dt>
                  <dd>
                    <span id="cartDataSubtotal">₩790,000</span>
                  </dd>
                  <dt class="delch_wrap">
                    <p class="tlt_ship">배송비</p>
                    <!--delivery charge layer popup-->
                    <div class="delch_box" style="display: none;">
                      <span class="arr">위치아이콘</span>
                      <ul class="bul_sty01_li">
                        <li>쿠폰/바우처 할인금액 및 한섬마일리지/H.Point 사용을 제외한 실 결제금액 기준 <strong>3만원 미만 결제 시 2,500원 배송비가 부과</strong>
                          됩니다.(3만원 이상 구매 시 무료배송)</li>
                        <li>도서산간 지역은 배송비가 추가 될 수 있습니다.</li>
                        <li>한섬마일리지, H.Point, e-money로 배송비 결제가 불가합니다.</li>
                      </ul>
                    </div>
                    <!--//delivery charge layer popup-->
                  </dt>
                  <dd>
                    <span id="cartDataDeliveryCost">₩ 0</span>
                  </dd>
                </dl>
                <dl class="total ">
                  <dt>
                    합계</dt>
                  <dd>
                    <span id="cartDataTotalPrice">₩790,000</span>
                  </dd>
                </dl>
              </div>
              <div class="total_count1807">
                <p>총 <span id="selectProductCount">1</span>개 상품</p>
              </div>
              <!-- //total -->
            </div>
            <!--//Total wrap-->
            <!--button wrap-->
            <div class="btnwrap order" id="checkout_btn_wrap">
              <a href="#;" onclick="selectRemove();"><input value="선택상품삭제" class="btn wt" type="button" /></a>
              <a href="#;" onclick="checkoutPage();">
                <input value="선택상품 주문하기" class="btn gray mr0" type="button" />
              </a>

            </div>
            <!--//button wrap-->
            <div class="promotion_wrap mt60" id="freeGiftPromotion">
              <dl class="promotion_list" style="border-top:1px solid #ebebeb; padding:60px 20px 18px 20px">
                <dt class="promotion_tit">PROMOTION 혜택</dt>
                <dd class="promotion_con1">
                  <strong>혜택 1 /

                    구매하신 고객님께 사은품을 드립니다.
                  </strong>
                  <ul class="bul_sty01_li promotion_img">
                    <li class="img"><img
                        src="/medias/KakaoTalk-20220421-111328678.jpg?context=bWFzdGVyfHJvb3R8MTMyNzU3MHxpbWFnZS9qcGVnfGhhOS9oMzcvOTI5NTc2NjU1MjYwNi5qcGd8YzNlZjk4ZjRkMWVkNTA1MTlkNGJiMmU4NGRhZTY2MmM2ZDgzMmU5MmY4MzU4YzY3NzRhNDI2OWJmNjMxMDkyOQ" />
                    </li>
                    <li>사은품 : Liquides 시그니처 기프트 박스</li>
                    <li>기간 내 리퀴드 퍼퓸바 향수 구매 고객님께 시그니처 기프트 박스를 사은품으로 드립니다.<BR>주문 1건당 박스는 1개 제공되며, 사이즈는 구매하신 향수 갯수에 따라
                      제공됩니다. (S/M/L 선택 불가) 사은품은 주문하신 배송지로 상품과 함께 발송됩니다. <BR>- 기간 : 5월 2일 ~ 5월 20일까지 (선착순 증정)</li>
                  </ul>
                </dd>
                <dd class="promotion_con2">
                  <strong>혜택 2 /
                    400,000원 이상

                    구매하신 고객님께 사은품을 드립니다.
                  </strong>
                  <ul class="bul_sty01_li promotion_img">
                    <li class="img"><img
                        src="/medias/GIFT.jpg?context=bWFzdGVyfHJvb3R8MTIxMzc4fGltYWdlL2pwZWd8aDcxL2g0YS85Mjk1NTI4MTY1NDA2LmpwZ3xlMjY3YjJlNWVhYWM3NzNhZGY2ZTQxYzA5MTFmYTRlMGY3MjcwMWIzNTIzZmY4NTNiZjAzMjU4NjgzOTEyMTUz" />
                    </li>
                    <li>사은품 : 더한섬닷컴 GIFT_켈리박 3단 우산</li>
                    <li>기간 내 정상 40만원 이상 구매 고객님께 구매 사은품으로 더한섬닷컴 X</BR>켈리박 작가와 함께한 3단 우산을 드립니다.</BR>추가로 해당 기간 내 선착순 1명에게는
                      직접 드로잉 한 양산, 구매금액 BEST 고객 1명에게는 레더백이 함께 발송될 예정입니다. (실 결제금액 기준, 아울렛 상품 구매 금액 제외)</BR>
                      - 기간 : 5월 2일 ~ 소진시 까지 (선착순 증정)</BR>사은품은 이벤트 종료 후, 취소 및 반품을 고려하여 5월 31일 이후 일괄 발송 예정입니다. (1~3일 지연
                      가능)</li>
                  </ul>
                </dd>
              </dl>
            </div>
          </div>
          <!--//order wrap-->
        </div>
        <!--//sub_container-->
      </span>
      <!-- // 장바구니개편 -->
    </div>
    <%@ include file="../include/footer.jsp" %>