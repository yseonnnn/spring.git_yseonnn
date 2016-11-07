<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
}

#popup {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 50%;
	top: 45%;
	width: 300px;
	height: 200px;
	background-color: #ccffff;
	border: 3px solid #87cb42;
}

#close {
	z-index: 4;
	float: right;
}
</style>
<script type="text/javascript">
	function fn_order_each_goods(goods_id, goods_title, goods_sales_price,
			fileName) {

		var isLogOn = document.getElementById("isLogOn");
		var loginState = isLogOn.value;

		// alert(loginState);

		if (loginState == "false") {
			alert("로그인 후 주문이 가능합니다.");
		}

		var total_price, final_total_price, _goods_qty;

		_order_goods_qty = 1; //장바구니에 담긴 개수 만큼 주문한다.
		var formObj = document.createElement("form");
		var i_goods_id = document.createElement("input");
		var i_goods_title = document.createElement("input");
		var i_goods_sales_price = document.createElement("input");
		var i_fileName = document.createElement("input");
		var i_order_goods_qty = document.createElement("input");

		i_goods_id.name = "goods_id";
		i_goods_title.name = "goods_title";
		i_goods_sales_price.name = "goods_sales_price";
		i_fileName.name = "goods_fileName";
		i_order_goods_qty.name = "order_goods_qty";

		i_goods_id.value = goods_id;
		i_order_goods_qty.value = _order_goods_qty;
		i_goods_title.value = goods_title;
		i_goods_sales_price.value = goods_sales_price;
		i_fileName.value = fileName;

		formObj.appendChild(i_goods_id);
		formObj.appendChild(i_goods_title);
		formObj.appendChild(i_goods_sales_price);
		formObj.appendChild(i_fileName);
		formObj.appendChild(i_order_goods_qty);

		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "/bookshop01/order/orderEachGoods.do";
		formObj.submit();
	}

	function add_cart(goods_id) {
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "http://localhost:8090/bookshop01/cart/addCart.do",
			data : {
				goods_id : goods_id
			},
			success : function(data, textStatus) {
				//alert(data);
				//	$('#message').append(data);
				if (data.trim() == 'add_success') {
					imagePopup('open', '.layer01');
				} else if (data.trim() == 'already_existed') {
					alert("이미 카트에 등록된 제품입니다.");
				}
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다." + data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}
		}); //end ajax	
	}

	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');
			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer').height(jQuery(document).height());
		} else if (type == 'close') {
			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}

	function fn_reviewDetail(type, review_content) {
		if (type == 'open') {
			// 팝업창을 연다.
			$('#layer_review').attr('style', 'visibility:visible');
			$('#message').text(review_content);

			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			$('#layer_review').height(jQuery(document).height());

		} else if (type == 'close') {
			// 팝업창을 닫는다.
			$('#layer_review').attr('style', 'visibility:hidden');
		}
	}

	function fn_showTbl() {
		$('#tbl_review').attr('style', 'visibility:visible');
		$('#btn_review').attr('style', 'visibility:hidden');
	}
	function fn_cancelTbl() {
		$('#tbl_review').attr('style', 'visibility:hidden');
		$('#btn_review').attr('style', 'visibility:visible');
	}

	function fn_regReview() {
		var t_review_title = document.getElementById("t_review_title");
		var t_review_content = document.getElementById("t_review_content");
		var t_review_pw = document.getElementById("t_review_pw");
		var h_goods_id = document.getElementById("h_goods_id");

		/* value는 속성이므로 ()를 사용하면 안된다 */
		var review_title = t_review_title.value;
		var review_content = t_review_content.value;
		var review_pw = t_review_pw.value;
		var goods_id = h_goods_id.value;

		/* alert(review_title);
		alert(review_content);
		alert(review_pw);
		alert(goods_id); */

		var formObj = document.createElement("form");
		var i_review_title = document.createElement("input");
		var i_review_content = document.createElement("input");
		var i_review_pw = document.createElement("input");
		var i_goods_id = document.createElement("input");

		i_review_title.name = "review_title";
		i_review_title.value = review_title;

		i_review_content.name = "review_content";
		i_review_content.value = review_content;

		i_review_pw.name = "review_pw";
		i_review_pw.value = review_pw;

		i_goods_id.name = "goods_id";
		i_goods_id.value = goods_id;

		formObj.appendChild(i_review_title);
		formObj.appendChild(i_review_content);
		formObj.appendChild(i_review_pw);
		formObj.appendChild(i_goods_id);

		document.body.appendChild(formObj);
		formObj.method = "post";
		formObj.action = "/bookshop01/goods/addReview.do";
		formObj.submit();
	}
</script>
</head>


<body>
	<hgroup>
		<h1>컴퓨터와 인터넷</h1>
		<h2>국내외 도서 &gt; 컴퓨터와 인터넷 &gt; 웹 개발</h2>
		<h3>${goodsMap.goods.goods_title }</h3>
		<h4>${goodsMap.goods.goods_writer}&nbsp;저|
			${goodsMap.goods.goods_publisher }</h4>
	</hgroup>
	<div id="goods_image">
		<figure>
			<img alt="HTML5 &amp; CSS3"
				src="${pageContext.request.contextPath}/fileDownload.do?goods_id=${goodsMap.goods.goods_id}&fileName=${goodsMap.goods.goods_fileName}">
		</figure>
	</div>
	<div id="detail_table">
		<table>
			<tbody>
				<tr>
					<td class="fixed">정가</td>
					<td class="active"><span> <fmt:formatNumber
								value="${goodsMap.goods.goods_price}" type="number"
								var="goods_price" /> ${goods_price}원
					</span></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">판매가</td>
					<td class="active"><span> <fmt:formatNumber
								value="${goodsMap.goods.goods_price*0.9}" type="number"
								var="discounted_price" /> ${discounted_price}원(10%할인)
					</span></td>
				</tr>
				<tr>
					<td class="fixed">포인트적립</td>
					<td class="active">${goodsMap.goods.goods_point}P(10%적립)</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">포인트 추가적립</td>
					<td class="fixed">만원이상 구매시 1,000P, 5만원이상 구매시 2,000P추가적립 편의점 배송
						이용시 300P 추가적립</td>
				</tr>
				<tr>
					<td class="fixed">발행일</td>
					<td class="fixed"><c:set var="pub_date"
							value="${goodsMap.goods.goods_published_date}" /> <c:set
							var="arr" value="${fn:split(pub_date,' ')}" /> <c:out
							value="${arr[0]}" /></td>
				</tr>
				<tr>
					<td class="fixed">페이지 수</td>
					<td class="fixed">${goodsMap.goods.goods_total_page}쪽</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">ISBN</td>
					<td class="fixed">${goodsMap.goods.goods_isbn}</td>
				</tr>
				<tr>
					<td class="fixed">배송료</td>
					<td class="fixed"><strong>무료</strong></td>
				</tr>
				<tr>
					<td class="fixed">배송안내</td>
					<td class="fixed"><strong>[당일배송]</strong> 당일배송 서비스 시작!<br>
						<strong>[휴일배송]</strong> 휴일에도 배송받는 Bookshop</TD>
				</tr>
				<tr>
					<td class="fixed">도착예정일</td>
					<td class="fixed">지금 주문 시 내일 도착 예정</td>
				</tr>
				<tr>
					<td class="fixed">수량</td>
					<td class="fixed"><select style="width: 60px;"><option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
					</select></td>
				</tr>
			</tbody>
		</table>
		<ul>
			<li><a class="buy"
				href="javascript:fn_order_each_goods('${goodsMap.goods.goods_id }','${goodsMap.goods.goods_title }','${goodsMap.goods.goods_sales_price}','${goodsMap.goods.goods_fileName}');">구매하기
			</a></li>
			<li><a class="cart"
				href="javascript:add_cart('${goodsMap.goods.goods_id }')">장바구니</a></li>
			<li><a class="wish" href="#">위시리스트</a></li>
		</ul>
	</div>
	<div class="clear"></div>
	<!-- 내용 들어 가는 곳 -->
	<div id="container">
		<ul class="tabs">
			<li><a href="#tab1">책소개</a></li>
			<li><a href="#tab2">저자소개</a></li>
			<li><a href="#tab3">책목차</a></li>
			<li><a href="#tab4">출판사서평</a></li>
			<li><a href="#tab5">추천사</a></li>
			<li><a href="#tab6">리뷰</a></li>
		</ul>
		<div class="tab_container">
			<div class="tab_content" id="tab1">
				<h4>책소개</h4>
				<p>${goodsMap.goods.goods_intro}</p>
				<c:forEach var="image" items="${goodsMap.imageList }">
					<img width="400" height="400"
						src="${pageContext.request.contextPath}/fileDownload.do?goods_id=${goodsMap.goods.goods_id}&fileName=${image.fileName}">
				</c:forEach>
			</div>
			<div class="tab_content" id="tab2">
				<h4>저자소개</h4>
				<p>
				<div class="writer">저자 : ${goodsMap.goods.goods_writer}</div>
				${goodsMap.goods.goods_writer_intro }
				<p></p>
			</div>
			<div class="tab_content" id="tab3">
				<h4>책목차</h4>
				<p>${goodsMap.goods.goods_contents_order }</p>
			</div>
			<div class="tab_content" id="tab4">
				<h4>출판사서평</h4>
				<p>${goodsMap.goods.goods_publisher_comment }</p>
			</div>
			<div class="tab_content" id="tab5">
				<h4>추천사</h4>
				<p>${goodsMap.goods.goods_recommendation }</p>
			</div>
			<div class="tab_content" id="tab6">
				<h4>리뷰</h4>
				<font size="4">
					<center>
						<table border="1" width="100%" align="center" class="list_view">
							<tr height="40">
								<td align="center" width="10%">글 번호</td>
								<td align="center" width="15%">작성자</td>
								<td align="center" width="45%">제목</td>
								<td align="center" width="30%">작성일자</td>
							</tr>

							<c:forEach var="review" items="${goodsMap.reviewList }">
								<!--  1. ${ goodsMap.reviewList } 				
										> 2.  GoodsServiceImpl - HashMap goodsDetail
										> 3.  goodsMap.put("reviewList", reviewList); 	
										>> 3. 좌측 큰따옴표의 key("reviewList") = 1. key 호출 (reviewList) -->
								<tr>
									<td align="center">${review.review_id }</td>
									<td align="center">${review.member_id }</td>
									<td align="center">
										<a href="javascript:fn_reviewDetail('open','${review.review_content }');">
																									${review.review_title } </a>
									</td>
									<td align="center">${review.reg_date }</td>
								</tr>
							</c:forEach>

							<input type="hidden" value=" ${review.review_content }"
								id="${review.review_id }">
							
							<c:set var="pre_chapter" value="${chapter-1 }" />
							<tr align="center">
								<td colspan="4">
									<c:if test="${chapter >1}">
										<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_id=${goodsMap.goods.goods_id }&chapter=${chapter-1}&pageNum=${pageNum-(chapter-pre_chapter)*10}">&nbsp;pre</a>
									</c:if>									
									<c:forEach var="page" begin="${1+pre_chapter*10 }" end="${10+pre_chapter*10 }" step="1">									
										<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_id=${goodsMap.goods.goods_id }&chapter=${chapter}&pageNum=${page }">${page }</a>
									</c:forEach> 
									<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_id=${goodsMap.goods.goods_id }&chapter=${chapter+1}&pageNum=${chapter*10+1}">next</a>
								</td>
							</tr>
							<br>
							</font>
						</table>

						<br> <input type="button" value="리뷰 작성" id="btn_review"
							onClick="fn_showTbl()"> <br> <br> <input
							type="hidden" value="${goodsMap.goods.goods_id}" id="h_goods_id">
						<table style="visibility: hidden" id="tbl_review">
							<tr>
								<td width="100">Title</td>
								<td><input type="text" size="60" id="t_review_title" /><br></td>
							</tr>
							<tr>
								<td width="100">Content</td>
								<td><textarea cols="60" rows="10" id="t_review_content">내용을 입력하세요
							</textarea></td>
							</tr>
							<tr>
								<td width="100">Password</td>
								<td><input type="text" size="10" id="t_review_pw" /></td>
							</tr>
							<tr align="center">
								<td colspan="2"><input type="submit" value="submit"
									onClick="fn_regReview()" /> <input type="button"
									value="cancel" onClick="fn_cancelTbl()" /></td>
							</tr>
						</table>

					</center>
			</div>
		</div>
	</div>

	<div class="clear"></div>

	<div id="layer" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:"
				onClick="javascript:imagePopup('close', '.layer01');"> <img
				src="${pageContext.request.contextPath}/image/close.png" id="close" />
			</a> <br /> <font size="12" id="contents">장바구니에 담았습니다.</font><br>
			<form action='${pageContext.request.contextPath}/cart/myCartMain.do'>
				<input name="btn_cart_list" type="submit" value="장바구니 보기">
			</form>
		</div>
	</div>

	<div id="layer_review" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:"
				onClick="javascript:fn_reviewDetail('close', '.layer_review');">
				<img src="${pageContext.request.contextPath}/image/close.png"
				id="close" />
			</a> <br> <font size="5" id="contents"><p id="message" /></font><br>
			<form action='${pageContext.request.contextPath}/cart/myCartMain.do'>
				<br> <br> <input name="btn_review_close" type="button"
					value="닫기" onClick="fn_reviewDetail('close', '.layer_review')">
			</form>
		</div>
	</div>

</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}">