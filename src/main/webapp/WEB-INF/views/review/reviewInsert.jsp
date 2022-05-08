<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
	<script type="text/javascript" src="/resources/_ui/desktop/common/js/jquery.vticker.js"></script><!-- 200318 ì¶ê° -->

</head>
<body>
<div class="popwrap w_type_3" id="productQnAWriteDiv" style=" position: absolute; z-index: 101; display: block;">
	<div class="pop_tltwrap2">
		<h3>상품평작성하기</h3>
	</div>
	<div class="pop_cnt evaluation_write">
		<form id="productQnAForm" name="productQnAForm" action="/review/reviewInsert" method="post" enctype="multipart/form-data" autocomplete="off">
			<input type="hidden" id="mId" name="mId" value="${sessionScope.user.mid}">
			<input type="hidden" id="mName" name="mName" value="${sessionScope.user.mname}">
			<input type="hidden" id="pId" name="pId" value="${param.pId}">
			<input type="hidden" id="pName" name="pName" value="${param.pName}">
			<fieldset>
				<legend>상품평작성하기</legend>
				<div class="tblwrap">					
					<table class="tbl_wtype1">
						<caption>상품평작성하기 입력항목</caption>
						<colgroup>
							<col width="140px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><strong class="reqd">*</strong><label for="inquiryContents">상품평 내용</label><span class="com_txt_p">(300자 이하)</span></th>
								<td>
									<textarea id="rContent" name="rContent" cols="30" rows="5" style="width:98%;height:200px"></textarea>
								</td>
							</tr>
							<tr>
							<th scope="row" class="th_space"><label for="file">파일 첨부하기</label></th>
								<td>
									<!-- File upload -->
									<div class="file_upload">
										<label for="rImage">이미지</label>
										<input type="file" id="rImage" name="file"/>
										<div class="select_img"><img src="" /></div>										 
										<script>
											$("#rImage").change(function(){
										    	if(this.files && this.files[0]) {
										    	var reader = new FileReader;
										    	reader.onload = function(data) {
										     		$(".select_img img").attr("src", data.target.result).width(500);        
										    	}
										    	reader.readAsDataURL(this.files[0]);
										   		}
										  });
										 </script>											 										 																													 
									</div>
									<!-- //File upload -->
									<p class="txt_guide">10MB 미만의 jpg,gif,png 파일만 첨부하실 수 있습니다.</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btnwrap mt40">
					<input type="submit" id="reviewWriteSend" value="등록하기" class="btn gray mr0">
				</div>
			</fieldset>
			<div>
				<input type="hidden" name="CSRFToken" value="d1226e22-a5f9-4d24-a18d-c9adb2d3da44">
			</div>
		</form>
	</div>
	<a href="/review/productReview?pId=${param.pId}&pageNum=1&amount=10" class="btn_close"><img src="http://cdn.thehandsome.com/_ui/desktop/common/images/popup/ico_close.png" alt="닫기"></a>
</div>
</body>
</html>