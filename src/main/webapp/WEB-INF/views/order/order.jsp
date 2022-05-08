<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp" %>

<c:choose>
<c:when test="${empty sessionScope.user}">
<script>
location.href ='/member/login';
</script>
</c:when>
</c:choose>


<script>
    $(document).ready(function(){
        var length = $('.price_wrap_price').length;
        var totalPrice = 0;
        for(var i = 0 ; i < length; i++){
            totalPrice += parseInt($('.price_wrap_price')[i].getAttribute('price'));
        }
        
        $('#subTotal').text('₩ '+totalPrice.toLocaleString('ko-KR'));
        $('#deliveryCost').text('₩ 0');
        $('#totalPrice').text('₩ '+totalPrice.toLocaleString('ko-KR'));
        $('#total').text(totalPrice.toLocaleString('ko-KR'));
    });

</script>
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

    function doOrder(){
        var length = $('.al_middle').length;
        var psid = '';
        var Oicount = '';
        var Oitotalprice = '';


        var OrderItemList = [];
        for(var i = 0 ; i<length;i++){
            psid = $('#psid'+i).val();
            Oicount = $('#Oicount'+i).text();
            Oitotalprice = $('#Oitotalprice'+i).attr('price');
            var OrderItemVO = {
                'psid' : psid,
                'oicount' : Oicount,
                'oitotalprice' : Oitotalprice
            }
            OrderItemList.push(OrderItemVO);
        }
        
        var Oaddress1 = $('#address').val() + ' ' + $('#line1').val();
        var Oaddress2 = $('#line2').val();
        var Oreceiver = $('#rcpt_name').val();
        var Ophone = $('#hp').val() + $('#hp_num2').val() + $('#hp_num3').val();
        var Omemo = $('#orderr').val();
        var Oemail = $('#mail').val() + '@' + $('#emailDelySel').val();
        var Obefroeprice = $('#total').text().replace(/,/gi,'');
        var Oafterprice = $('#total').text().replace(/,/gi,'');
        var Ostatus = '주문완료';
        var Pmcode = $('input[name="mode"]:checked').val();
        if(Oaddress1 == '' || Oaddress2 == ''){
            alert('주소를 적어주세요 ');
            return;
        }
        if(Oreceiver == ''){
        	alert('수령인을 적어주세요 ');
        	return;
        }
        if($('#hp_num2').val() == ''){
        	alert('중간 휴대폰 번호를 적어주세요 ');
        	return;
        }
        if($('#hp_num3').val() == '' ){
        	alert(' 끝자리 휴대폰 번호를 적어주세요 ');
        	return;
        }
        if(Pmcode == undefined){
         	alert('결제수단을 선택해주세요 ');
         	return;
        }
        if(!$('#agree').is(':checked')){
            alert('구매자 동의에 동의해주세요 ');
            return;
        }
        var mid = '${sessionScope.user.mid}';
        var orderVO = {
            'oaddress1' : Oaddress1,
            'oreceiver' : Oreceiver,
            'ophone' : Ophone,
            'omemo' : Omemo,
            'oemail' : Oemail,
            'obefroeprice' : Obefroeprice,
            'oafterprice' : Oafterprice,
            'ostatus' : Ostatus,
            'mid' : mid,
            'oaddress2' : Oaddress2,
            'pmcode' : Pmcode,
            'orderItemList' : OrderItemList
        }
        

        var json = JSON.stringify(orderVO);        
        console.log(json);

        $.ajax({
            type : 'POST',
              url : '/order/sendOrder',
              data : json,
              contentType: 'application/json; charset=utf-8',
              dataType: 'text',
              success: function(data){
                alert('주문에 성공했습니다. ');
                console.log(data);
                location.href="/";
                
              },
              error: function(request, status, error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                alert('주문에 실패했습니다.');
              }
        });
    }

</script>

<!-- bodyWrap -->
<div id="bodyWrap">
    <h3 class="cnts_title">
        <span>배송&amp;결제정보 입력</span>
    </h3>

    <input type="hidden" id="chk_giftAmount" value="" />
    <input type="hidden" id="chk_pointAmount" value="" />

    <form id="orderForm" action="/ko/checkout/ordersheet" method="post">
        <script language="javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js"
            type="text/javascript" charset="UTF-8"></script>
        <input type="hidden" id="paytype" name="paytype" value="Inicis" />
        <input type="hidden" id="globalPayment" name="globalPayment" value="" /><input type="hidden"
            name="ordererName" id="ordererName" value="" />
        <input type="hidden" name="ordererMobilePhone" id="ordererMobilePhone" value="" />
        <input type="hidden" name="ordererEmail" id="ordererEmail" value="" />
        <input type="hidden" name="addressId" id="addressId" value="" />
        <input type="hidden" name="email" id="email" value="" />
        <input type="hidden" id="discInfo_coupon" name="couponCode" value="" />
        <input type="hidden" id="customDutiesPaymentYN" name="customDutiesPaymentYN" value="0" />
        <input type="hidden" id="chinaYN" name="chinaYN" />
        <input type="hidden" id="idCardOrPassport" name="idCardOrPassport" />
        <input type="hidden" id="selectedCompany" name="selectedCompany" value="" />
        <input type="hidden" id="isPermanentCompany" name="isPermanentCompany" value="" />

        <input type="hidden" name="wpayToken" value="" />
        <input type="hidden" name="cardQuota" value="" />
        <input type="hidden" name="cardInterest" value="" />
        <input type="hidden" name="discInfo" value="" />

        <!--sub_container-->
        <div class="sub_container">
            <!--orderwrap-->
            <div class="orderwrap del_pay">
                <!--orderwrap left-->
                <div class="float_left">
                    <!--table wrap1-->
                    <div id="checkoutCartView" class="tblwrap">
                        <table class="tbl_ltype ">

                            <caption>
                                배송&amp;결제정보 입력</caption>
                            <colgroup>
                                <col />
                                <col style="width: 66px" />
                                <col style="width: 158px" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">상품정보</th>
                                    <th scope="col">수량</th>

                                    <th scope="col">판매가</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- 반복되는것 시작-->
                                <c:forEach var="product" items="${productList}" varStatus="status">
                                <input type="hidden" id="psid${status.index}" value = "${product.psid}"/>
                                <tr class="al_middle">
                                    <td class="frt">
                                        <!-- pt_list_all -->
                                        <div class="pt_list_all">
                                            <a
                                                href="">
                                                <img src="${product.pcchipimg}"
                                                    alt="" />
                                            </a>
                                            <div class="tlt_wrap">
                                                <a href="/ko/HANDSOME/MEN/OUTER/JACKET/%5BPARIS%5D-%EC%98%A4%EB%B2%84%EC%82%AC%EC%9D%B4%EC%A6%88-%EC%8B%B1%EA%B8%80-%EC%9E%AC%ED%82%B7/p/SH2C1WJCT02M_OW_105"
                                                    class="basket_tlt">
                                                    <span class="tlt">${product.bname}</span>
                                                    <span class="sb_tlt">${product.pname}</span>
                                                </a>
                                                <p class="color_op">

                                                    size : ${product.psize}</p>
                                            </div>
                                        </div> <!-- //pt_list_all -->
                                    </td>
                                    <td id="Oicount${status.index}">${product.pquantity}</td>
                                    <td>
                                        <!-- price_wrap -->
                                        <div class="price_wrap ">
                                            <span class="price_wrap_price" id="Oitotalprice${status.index}" price="${product.pcprice *  product.pquantity}">
                                                ₩ <fmt:formatNumber value="${product.pcprice *  product.pquantity}" pattern="#,###"/></span>
                                        </div> <!-- //price_wrap -->
                                    </td>
                                </tr>
                                </c:forEach>
                                <!-- 반복되는 것 종료-->
                            </tbody>
                        </table>
                        <script>var checktHandsomepointUsableAmount = parseInt('898000.0');</script>
                    </div>
                    <!--//table wrap1-->

                    <p>
                        ●&nbsp;먼저 준비된 상품부터 순차적으로 발송하므로, 부분 배송될 수 있습니다.</p>
                    <!--title_wrap & table wrap3-->
                    <div class="title_wrap clearfix mt40">
                        <h4 class="float_left">
                            주문자 정보</h4>
                    </div>
                    <div class="tblwrap">
                        <table class="tbl_wtype1">
                            <caption>
                                주문자 정보</caption>
                            <colgroup>
                                <col style="width: 140px" />
                                <col />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row" class="th_space">주문자</th>
                                    <td>${member.mname}</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="th_space">휴대폰</th>
                                    <td>
                                        ${member.mphone}</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="th_space">E-mail</th>
                                    <td>${member.memail}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--nonmember-->
                    <!--//nonmember-->

                    <!--//title_wrap & table wrap3-->
                    <!--title_wrap & table wrap4-->
                    <div class="title_wrap clearfix mt40" id="deliveryAddressDisplay">
                        <h4 class="float_left">
                            배송지 정보</h4>
                        <p class="reqd_txt none">
                            <strong class="reqd">*</strong>
                            표시는 필수항목입니다.
                        </p>
                        
                    </div>

                    <div class="tblwrap" id="deliveryInfoTitle">
                        <table class="tbl_wtype1">
                            <caption>
                                배송지 정보</caption>
                            <colgroup>
                                <col style="width: 140px" />
                                <col />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row" class="tooltip191022">
                                        <strong class="reqd">*</strong>
                                        <label for="adress">배송지 주소</label>
                                        <span class="ico_question">icon</span>
                                        <div class="delch_box190816">
                                            <span class="arr">위치아이콘</span>
                                            <ul class="bul_sty01_li">
                                                <li>기본배송지 변경은 <strong>마이페이지> [배송지관리]</strong>에서 가능합니다.
                                                </li>
                                                <li>기본배송지 설정 시 기본배송지가 최우선으로 노출 됩니다.</li>
                                            </ul>
                                        </div>
                                    </th>
                                    <td>
                                        <!-- address -->
                                        <input type="text" id="address" placeholder="우편번호">
                                        <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn add_s"><br>
                                        <div id="basis_bk_flag">
                                        <input type="text" id="line1" placeholder="주소"  class="post_wall top" type="text" readonly><br>
                                        </div>
                                        <input type="text" id="line2" placeholder="상세주소" class="post_wall" type="text" maxlength="110"
                                        placeholder="나머지 주소를 입력해 주세요.">
                                        <!-- address-->
                                        <!-- <input type="text" id="sample6_extraAddress" placeholder="참고항목"> -->
                                        <!-- <input value="" title="우편번호" id="adress" name="postcode"
                                            class="post" type="text" readonly />
                                        <input value="우편번호 조회" id="addrSearchBtn" class="btn add_s"
                                            type="button" />
                                        <br />
                                        <div id="basis_bk_flag">
                                            <input value="" title="주소1" name="line1" id="line1"
                                                class="post_wall top" type="text" readonly />
                                        </div>
                                        <input value="" title="주소2" name="line2" id="line2"
                                            class="post_wall" type="text" maxlength="110"
                                            placeholder="나머지 주소를 입력해 주세요." />  -->
                                            <!-- //address -->
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><strong class="reqd">*</strong><label
                                            for="rcpt_name">수령인</label></th>
                                    <td><input value="" title="수령인" id="rcpt_name" name="lastName"
                                            maxlength="13" type="text" style="width: 118px;" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><strong class="reqd">*</strong><label for="hp">휴대폰
                                            번호</label></th>
                                    <td>
                                        <!-- hp --> <select id="hp" name="hp_num1" title="휴대폰 번호 앞자리"
                                            class="hp_num1">
                                            <option value="010">010</option>
                                            <option value="011">011</option>
                                            <option value="016">016</option>
                                            <option value="017">017</option>
                                            <option value="018">018</option>
                                            <option value="019">019</option>
                                        </select>
                                        <div class="form_hyphen">-</div> <input title="휴대폰 번호 가운데자리"
                                            name="hp_num2" id="hp_num2" class="hp_num2" type="text"
                                            maxlength="4" numberOnly="true" />
                                        <div class="form_hyphen">-</div> <input title="휴대폰 번호 뒷자리"
                                            name="hp_num3" id="hp_num3" class="hp_num2" type="text"
                                            maxlength="4" numberOnly="true" /> <!-- //hp -->
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="th_space"><label for="ph">연락처</label></th>
                                    <td>
                                        <!-- phone --> <select name="ph_num1" id="ph" title="연락처 앞자리"
                                            class="hp_num1">
                                            <option value="">선택</option>
                                            <option value="02">02</option>
                                            <option value="031">031</option>
                                            <option value="032">032</option>
                                            <option value="033">033</option>
                                            <option value="041">041</option>
                                            <option value="042">042</option>
                                            <option value="043">043</option>
                                            <option value="044">044</option>
                                            <option value="051">051</option>
                                            <option value="052">052</option>
                                            <option value="053">053</option>
                                            <option value="054">054</option>
                                            <option value="055">055</option>
                                            <option value="061">061</option>
                                            <option value="062">062</option>
                                            <option value="063">063</option>
                                            <option value="064">064</option>
                                        </select>
                                        <div class="form_hyphen">-</div> <input title="연락처 가운데자리"
                                            name="ph_num2" id="ph_num2" class="hp_num2" type="text"
                                            maxlength="4" numberOnly="true" />
                                        <div class="form_hyphen">-</div> <input title="연락처 뒷자리"
                                            name="ph_num3" id="ph_num3" class="hp_num2" type="text"
                                            maxlength="4" numberOnly="true" /> <!-- //phone -->
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="th_space"><label for="orderr">배송 메세지</label>
                                    </th>
                                    <td>
                                        <div class="input_sumtxt">
                                            <div class="input_sumtxt_box">
                                                <!-- input -->
                                                <input
                                                    onkeyup="chkword('orderr','orderr_text_length',20);"
                                                    id="orderr" name="deliveryRequestContents"
                                                    autocomplete="off" type="text" value=""
                                                    title="배송 메세지" maxlength="20" />
                                                <!-- //input -->
                                                <div class="delivery_comt">
                                                    <ul>
                                                        <li>
                                                            <a href="#;" data-readonly="readonly"
                                                                deliveryRequestMessage="배송 전 연락 바랍니다">
                                                                배송 전 연락 바랍니다</a>
                                                        </li>
                                                        <li>
                                                            <a href="#;" data-readonly="readonly"
                                                                deliveryRequestMessage="부재 시 문 앞에 놓아주세요">
                                                                부재 시 문 앞에 놓아주세요</a>
                                                        </li>
                                                        <li>
                                                            <a href="#;" data-readonly="readonly"
                                                                deliveryRequestMessage="부재 시 경비실에 맡겨주세요">
                                                                부재 시 경비실에 맡겨주세요</a>
                                                        </li>
                                                        <li>
                                                            <a href="#;" data-readonly="readonly"
                                                                deliveryRequestMessage="빠른 배송 부탁드립니다">
                                                                빠른 배송 부탁드립니다</a>
                                                        </li>
                                                        <li>
                                                            <a href="#;" data-readonly="readonly"
                                                                deliveryRequestMessage="부재 시 핸드폰으로 연락바랍니다">
                                                                부재 시 핸드폰으로 연락바랍니다</a>
                                                        </li>
                                                        <li>
                                                            <a href="#;" data-readonly="write"
                                                                deliveryRequestMessage="직접입력">
                                                                직접입력</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div>
                                                <span id="orderr_text_length">0</span> <span>/20자</span>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <th scope="row" class="th_space"><label for="mail">수령인
                                            E-mail</label></th>
                                    <td>
                                        <!-- email --> <input type="text" id="mail" name="mail"
                                            title="이메일 아이디" class="em_form" /> <span
                                            class="andmail">@</span>
                                        <select title="이메일 계정"
                                            id="emailDelySel" class="em_select">
                                            
                                            <option value="naver.com">naver.com</option>
                                            <option value="gmail.com">gmail.com</option>
                                            <option value="daum.net">daum.net</option>
                                            <option value="nate.com">nate.com</option>
                                            <option value="hanmail.net">hanmail.net</option>
                                            <option value="yahoo.com">yahoo.com</option>
                                            <option value="dreamwiz.com">dreamwiz.com</option>
                                        </select> <!-- //email -->
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <ul class="bul_sty01_li">
                            <li>선택사항을 미입력하더라도 불이익은 발생하지 않습니다.</li>
                        </ul>
                    </div>
                    <!--//title_wrap & table wrap4-->
                    
                    <!--//title_wrap & table wrap2-->
                    <!--title_wrap & table wrap5-->
                    <div class="title_wrap clearfix mt40">
                        <h4 class="float_left">결제 수단 선택</h4>
                    </div>
                    <div class="tblwrap">
                        <table class="tbl_wtype1">
                            <caption>결제 수단 선택</caption>
                            <colgroup>
                                <col style="width: 140px" />
                                <col />
                            </colgroup>
                            <tbody>
                                <!-- H.Point Start NOT ANY **********************************-->
                                <!-- H.Point End ********************************************-->
                                <tr>
                                    <th scope="row" class="th_space">결제수단 선택</th>
                                    <td>
                                        <div class="rd_wrap payment_way1907">
                                            <ul>
                                                <c:forEach var="pay" items="${payList}" varStatus="status">
                                                <li>
                                                    <c:choose>
                                                        <c:when test="${status.index eq 4}">
                                                            <span style="display: block;">
                                                                <input type="radio" name="mode" id="sel_rd${status.index}" value="${pay.pmcode}" />
                                                                <label id="sel_rd${status.index}">${pay.pmcompany}</label>
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${status.index eq 3}">
                                                            <span>
                                                                <input type="radio" name="mode" id="sel_rd${status.index}" value="${pay.pmcode}" />
                                                                <label id="sel_rd${status.index}">${pay.pmcompany}</label>
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${status.index != 4}">
                                                            <input type="radio" name="mode" id="sel_rd${status.index}" value="${pay.pmcode}" />
                                                            <label id="sel_rd${status.index}">${pay.pmcompany}</label>
                                                        </c:when>
                                                    </c:choose>
                                                    
                                                </li>
                                                </c:forEach>
                                                
                                            </ul>
                                        </div> <!-- ckout_wrap -->

                                      
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--//title_wrap & table wrap5-->

                  
                </div>
                <!--//orderwrap left-->
                <!--orderwrap right-->
                <div class="float_right" style="position: absolute; left: 680px; ">
                    <!--final payment sum box-->
                    <div class="sum_box">
                        <div>
                            <p class="tlt">
                                최종 결제 금액</p>
                            <hr />
                            <dl class="clearfix">
                                <dt>
                                    상품 합계</dt>
                                <dd id="subTotal">
                                    
                                    </dd>
                                <dt>배송비</dt>
                                <dd id="deliveryCost">
                                    </dd>
                            </dl>
                        </div>
                        <div class="total">
                            <dl class="clearfix">
                                <dt>
                                    합계</dt>
                                <dd id="totalPrice">
                                    
                                    </dd>
                            </dl>
                        </div>
                        <input type="hidden" name="total" id="total" />
                        <input type="hidden" name="cartDeliveryCost" id="cartDeliveryCost" value="" />
                    </div>
                    <!--//final payment sum box-->
                    <!--point & agreement box-->
                    <div class="p_a_box">
                        <div class="agree">
                            <input type="checkbox" id="agree" /><label for="agree" class="tlt"> 구매자
                                동의</label>
                            <p class="txt">
                                주문할 상품의 상품명, 가격, 배송정보 등<br />
                                판매조건을 확인하였으며, 구매진행에 동의합니다.<br />
                                (전자상거래법 제8조 2항)<br /><br />
                                기존 마이너스 한섬마일리지를 보유하고 있는 고객은
                                한섬마일리지가 차감되어 적립되는 것에 동의합니다.
                                적립 예정 한섬마일리지가 상이할 수 있습니다.

                            </p>
                        </div>
                    </div>
                    <!--//point & agreement box-->
                    <span id="doOrderBtn">
                        <a href="#;" class="btn gray " onclick="doOrder();">
                            결제하기</a>
                    </span>
                </div>
                <!--//orderwrap right-->
            </div>
            <!--//orderwrap-->
        </div>
        <!--//sub_container-->
    </form>
    <!--layer pop-->
  
</div>
<!-- //bodyWrap -->
<%@ include file="../include/footer.jsp" %>