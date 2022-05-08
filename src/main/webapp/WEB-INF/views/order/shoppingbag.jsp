<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp" %>

<c:choose>
<c:when test="${empty sessionScope.user}">
<script>
location.href ='/member/login';
</script>
</c:when>
</c:choose>

<script type="text/javascript"
	src="/resources/_ui/desktop/common/js/jquery-1.11.2.min.js"></script>
    <div id="bodyWrap" style="padding-bottom: 0;">
      <!-- title-->
      <h3 class="cnts_title cnts_tlt1807"><span>쇼핑백</span></h3>
      <!-- 장바구니-->
      <span id="shoppingbagCartView">
        <script>
          $(document).ready(function(){
        	  $('#cartDataSubtotal').text("₩ "+0);
        	  $('#cartDataDeliveryCost').text("₩ "+0);
        	  $('#cartDataTotalPrice').text("₩ "+0);
        	  
        	  $('#entryCheckAll').click(function(){


        		 if($('#entryCheckAll').is(":checked")){
              $("input[name=cartlist]").prop("checked",true);
             } 
             else {
              $("input[name=cartlist]").prop("checked",false);
             } 
             var checked = $("input[name=cartlist]:checked").length;

              $('#selectProductCount').text(checked);
             calTotalPrice();
        	  });

            $("input[name=cartlist]").click(function(){
              var total = $("input[name=cartlist]").length;
              var checked = $("input[name=cartlist]:checked").length;

              $('#selectProductCount').text(checked);
              $('')
              if(total != checked) {
                $("#entryCheckAll").prop("checked",false);
              } 
              else {
                $("#entryCheckAll").prop("checked",true);
              }
              calTotalPrice();
            });
            
            $("#orderSheet").submit(function(e){
           	   e.preventDefault();
               var form = $('#orderSheet');
               var count = 0;
               //선택한 상품 개수만큼 데이터 input 추가
               $("input[name=cartlist]:checked").each(function(key, value){
            	 count++;
                 console.log("key : " + key);
                 console.log("psid : " + value.getAttribute("psid"));
                 console.log("pqauntity : " + value.getAttribute("pquantity"));
                 
                 var input_psid = $("<input type='hidden' value=" + value.getAttribute("psid") + " name='list["+key+"].psid' readonly>");
                 var intput_pquantity = $("<input type='hidden' value=" + value.getAttribute("pquantity") + " name='list["+key+"].pquantity' readonly>");
                 
                 form.append(input_psid);
                 form.append(intput_pquantity);

               });
               
               if(count == 0){
                 alert('선택된 상품이 없습니다.');
                 return false;
               }
               
              $('#orderSheet')[0].submit();
            });
            
          });
          function cartRemove(idx){
            
            var psid = $('#updateCartForm'+idx).children('input[name=psid]').val();
            var cartList = new Array();
            cartList.push({"psid" : psid});
           
            deleteCart(cartList);
          }

          var mid =  '${sessionScope.user.mid}';
          
          function deleteCart(cartList){
            console.log('Start deleteCart');
            console.log(JSON.stringify(cartList));
            $.ajax({
              type : 'POST',
              url : '/cart/deleteCart',
              data : JSON.stringify(cartList),
              contentType: 'application/json; charset=utf-8',
              
              success: function(data){
                alert('succes');
                console.log(data);
                location.href="/cart/getList?mid="+mid;
              },
              error: function(request, status, error){
                alert("code:"+request.status+"\n"+"error:"+error);
              }
            })
          }

          function selectRemove(){
            var cartList = new Array();
            $("input[name=cartlist]:checked").each(function(key, value){
              console.log("key : " + key);
              console.log("psid : " + value.getAttribute("psid"));
              cartList.push({"psid" : value.getAttribute("psid")});
            });
            if(cartList.length == 0){
              alert('선택된 상품이 없습니다.');
              return;
            }
            deleteCart(cartList);
            
          } 
          
          function calTotalPrice(){
            console.log("call calTotalPrice");
            var totalPrice = 0;
            $("input[name=cartlist]:checked").each(function(key, value){
              console.log("key : " + key);
              console.log(value.value);
              totalPrice +=parseInt(value.value);
            });
            console.log(totalPrice);
            $('#cartDataSubtotal').text("₩ "+totalPrice.toLocaleString('ko-KR'));
        	  $('#cartDataDeliveryCost').text("₩ "+0);
        	  $('#cartDataTotalPrice').text("₩ "+totalPrice.toLocaleString('ko-KR'));
          }
        
          function click_tab(tab){
            if(tab == '택배'){
              //장바구니에 담김 상품중 택배 조회 ajax
            }else if(tab == '매장수령'){
              //장바구니에 담긴 상품중 매장 수령 조회 ajax
            }else if(tab == '퀵배송'){
              //장바구니에 담긴 상품중 퀵배송 수령 조회
            }
          }

          function quantityChange(op, idx){
            if(op == '-'){
            	document.querySelectorAll('quantity'+idx);
              var quantity = $('#quantity'+idx).val();
              console.log('clicked - ', quantity);
              if(quantity == 0){
                return;
              }
              $('#quantity'+idx).val(parseInt(quantity)-1);
              $('#cartlist'+idx).attr('pquantity',parseInt(quantity)-1)
            }else if(op == '+') {
              var quantity = $('#quantity'+idx).val();
              console.log('clicked + ', quantity);
              $('#quantity'+idx).val(parseInt(quantity)+1);
              $('#cartlist'+idx).attr('pquantity',parseInt(quantity)+1)
            }
          }
          
          function updateQuantity(idx){
        	  console.log(idx);
            var form = $('#updateCartForm'+idx)[0];
            var formData = new FormData(form);
            console.log(formData);
              console.log(form);
              
              var formSerializeArray = $('#updateCartForm'+idx).serializeArray();
              var object = {};
              for (var i = 0; i < formSerializeArray.length; i++){
                  object[formSerializeArray[i]['name']] = formSerializeArray[i]['value'];
              }
			 
			var json = JSON.stringify(object);

            $.ajax({
              type : 'POST',
              url : '/cart/updateQuantity',
              data : json,
              contentType: 'application/json; charset=utf-8',
              dataType: 'json',
              success: function(data){
                alert('succes');
                console.log(data);
                $('#quantity'+idx).val(data.pquantity);
                
                //가격 수정하는 부분 
                var price = parseInt($('#pcprice'+idx).val());
                console.log('price : ' + price);
                price = price * parseInt(data.pquantity)
                console.log('price : ' + price);
                $('#price_wrap'+idx).children('span').text('₩ '+price.toLocaleString('ko-KR'));
                $('#price_wrap'+idx).children('input').val(price);
                $('#cartlist'+idx).val(price);
                
                //체크박스의 가격 수정하는 부분
                $('#cartlist'+idx).val(price);
              },
              error: function(request, status, error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              }
            })
          }

        </script>
        <!--sub_container-->
        <div class="sub_container ">
          <!--order wrap-->
          <!-- <div class="shopping_cart_tab1807 tab_a">
          
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
            
          </div> -->

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
                      <input type="checkbox" name="cartlist" id="cartlist${status.index }" data-pk="10681668861996" data-division=""
                        data-deliverykind="" value="${cart.pquantity*cart.pcprice}" psid="${cart.psid}" pquantity="${cart.pquantity}" >
                    </td>
                    <td class="pt_list_wrap">
                      <!-- pt_list_all -->
                      <div class="pt_list_all">
                        <img src="${cart.pcchipimg}" alt="" />
                        
                        <div class="tlt_wrap">
                          <a href="#"
                            class="basket_tlt">
                            <span class="tlt">${cart.bname}</span>
                            <span class="sb_tlt">
                              ${cart.pname}</span>
                          </a>

                          <p class="color_op">

                            size : ${cart.psize}</p>
                        </div>
                      </div>
                      <!-- //pt_list_all-->
                    </td>
                    <td class="al_middle">
                      <form id="updateCartForm${status.index}"
                        action="/cart/updateQuantity" method="post" style="text-align:center;">
                        <input type="hidden" name="psid" value="${cart.psid}" />
                        <input type="hidden" name="mid" value="${cart.mid}"/>
                        <input type="hidden" name="pcprice${status.index }" value="${cart.pcprice }" id="pcprice${status.index }"/>
                        <!-- qty_sel -->
                        <span class="qty_sel num" >
                          <a href="#none" onclick="quantityChange('-', '${status.index}');" class="left">-</a>
                          <input id= "quantity${status.index}" name="pquantity" type="text" class="mr0" size="1" maxlength="3" value="${cart.pquantity }"/>
                          <a href="#none" onclick="quantityChange('+', '${status.index}');" class="right">+</a>
                        </span>
                        <!-- //qty_sel -->
                        <a id="QuantityProduct_${status.index}" class="btn wt_ss qty_w mr0" onclick="updateQuantity(${status.index})">변경</a>
                        <div>
                          <!-- <input type="hidden" name="CSRFToken" value="d43028c9-c041-4b3e-9836-9ff7ea0af207" /> -->
                        </div>
                      </form>
                    </td>
                    <td class="al_middle">
                      <!-- Price -->
                      <div class="price_wrap" id="price_wrap${status.index }">
                        <span>₩ <fmt:formatNumber value="${cart.pcprice * cart.pquantity}" pattern="#,###"/></span> <input type="hidden" name="checkZeroPrice" value="${cart.pcprice * cart.pquantity}" />
                      </div> <!-- //Price -->
                    </td>
                    <td class="al_middle">
                      <!-- Button size -->
                      <div class="btn_wrap">
                        <a href="#none" id="RemoveProduct_0" class="btn wt_ss"
                          onclick="cartRemove(${status.index})">삭제</a>
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
                    <span id="cartDataSubtotal">₩ 0</span>
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
                    <span id="cartDataTotalPrice">₩ 0</span>
                  </dd>
                </dl>
              </div>
              <div class="total_count1807">
                <p>총 <span id="selectProductCount">0</span>개 상품</p>
              </div>
              <!— //total —>
            </div>
            <!—//Total wrap—>
            <!—button wrap—>
            <div class="btnwrap order" id="checkout_btn_wrap">
              <a href="#;" onclick="selectRemove();"><input value="선택상품삭제" class="btn wt" type="button" /></a>
                <form action="/order/orderSheet" method="POST" id="orderSheet">
                  <input value="선택상품 주문하기"  class="btn gray mr0" type="submit"  />
                </form>
                

            </div>
            
          </div>
          <!—//order wrap—>
        </div>
        <!—//sub_container—>
      </span>
      <!— // 장바구니개편 —>
    </div>
    <%@ include file="../include/footer.jsp" %>