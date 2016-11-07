<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="euc-kr"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
<c:when test='${not empty goods.goods_type}'>
<script>
window.onload=function()
{
  test();
}

function test(){
	init();
	
}
function init(){
	var frm_mod_goods=document.frm_mod_goods;
	var h_goods_type=frm_mod_goods.h_goods_type;
	var goods_type=h_goods_type.value;
	var select_goods_type=frm_mod_goods.goods_type;
	 select_goods_type.value=goods_type;
}
</script>
<script type="text/javascript">
function fn_modify_goods(goods_id, mod_type){
	
//	alert("mod_type:"+mod_type);
	var frm_mod_goods=document.frm_mod_goods;
	if(mod_type=='goods_sort'){
		value=frm_mod_goods.goods_sort.value;
	//	alert("goods_sort:"+value);
		
	}else if(mod_type=='goods_title'){
		value=frm_mod_goods.goods_title.value;
	//	alert("value:"+value);
	}else if(mod_type=='goods_writer'){
		value=frm_mod_goods.goods_writer.value;   
	}else if(mod_type=='goods_publisher'){
		value=frm_mod_goods.goods_publisher.value;
	}else if(mod_type=='goods_price'){
		value=frm_mod_goods.goods_price.value;
	}else if(mod_type=='goods_sales_price'){
		value=frm_mod_goods.goods_sales_price.value;
	}else if(mod_type=='goods_point'){
		value=frm_mod_goods.goods_point.value;
	}else if(mod_type=='goods_published_date'){
		value=frm_mod_goods.goods_published_date.value;
	}else if(mod_type=='goods_page_total'){
		value=frm_mod_goods.goods_page_total.value;
	}else if(mod_type=='goods_isbn'){
		value=frm_mod_goods.goods_isbn.value;
	}else if(mod_type=='goods_delivery_price'){
		value=frm_mod_goods.goods_delivery_price.value;
	}else if(mod_type=='goods_delivery_date'){
		value=frm_mod_goods.goods_delivery_date.value;
	}else if(mod_type=='goods_type'){
		value=frm_mod_goods.goods_type.value;
	}else if(mod_type=='goods_contents_order'){
		value=frm_mod_goods.goods_contents_order.value;
	}else if(mod_type=='goods_writer_intro'){
		value=frm_mod_goods.goods_writer_intro.value;
	}else if(mod_type=='goods_intro'){
		value=frm_mod_goods.goods_intro.value;
	}else if(mod_type=='publisher_comment'){
		value=frm_mod_goods.publisher_comment.value;
	}else if(mod_type=='recommendation'){
		value=frm_mod_goods.recommendation.value;
	}

	$.ajax({
		type : "post",
		async : false, //false�� ��� ��������� ó���Ѵ�.
		url : "http://localhost:8090/bookshop01/admin/goods/modifyGoodsInfo.do",
		data : {
			goods_id:goods_id,
			mod_type:mod_type,
			value:value
		},
		success : function(data, textStatus) {
			if(data.trim()=='mod_success'){
				alert("��ǰ ������ �����߽��ϴ�.");
			}else if(data.trim()=='failed'){
				alert("�ٽ� �õ��� �ּ���.");	
			}
			
		},
		error : function(data, textStatus) {
			alert("������ �߻��߽��ϴ�."+data);
		},
		complete : function(data, textStatus) {
			//alert("�۾����Ϸ� �߽��ϴ�");
			
		}
	}); //end ajax	
}

function fn_moveToImagePage(goods_id){
	var formObj=document.frm_mod_goods;
	var i_goods_id=document.createElement("input"); 
    
	i_goods_id.name="goods_id";
	i_goods_id.value=goods_id;
	
    formObj.appendChild(i_goods_id);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="/bookshop01/admin/goods/modifyGoodsImageForm.do";
    formObj.submit();
}
</script>
</c:when>
</c:choose>



</HEAD>
<BODY>
<form  name="frm_mod_goods"  method=post >
<DIV class="clear"></DIV>
	<!-- ���� ��� ���� �� -->
	<DIV id="container">
		<UL class="tabs">
			<LI><A href="#tab1">��ǰ����</A></LI>
			<LI><A href="#tab2">��ǰ����</A></LI>
			<LI><A href="#tab3">��ǰ���ڼҰ�</A></LI>
			<LI><A href="#tab4">��ǰ�Ұ�</A></LI>
			<LI><A href="#tab5">���ǻ� ��ǰ ��</A></LI>
			<LI><A href="#tab6">��õ��</A></LI>
		</UL>
		<DIV class="tab_container">
			<DIV class="tab_content" id="tab1">
				<table >
			<tr >
				<td width=200 >��ǰ�з�</td>
				<td width=500>
				  <select name="goods_sort">
					<c:choose>
				      <c:when test="${goods.goods_sort=='��ǻ�Ϳ� ���ͳ�' }">
						<option value="��ǻ�Ϳ� ���ͳ�" selected>��ǻ�Ϳ� ���ͳ� </option>
				  	    <option value="������ ���">������ ���  </option>
				  	  </c:when>
				  	  <c:when test="${goods.goods_sort=='������ ���' }">
						<option value="��ǻ�Ϳ� ���ͳ�" >��ǻ�Ϳ� ���ͳ� </option>
				  	    <option value="������ ���" selected>������ ���  </option>
				  	  </c:when>
				  	</c:choose>
					</select>
				</td>
				<td >
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_sort')"/>
				</td>
			</tr>
			<tr >
				<td >��ǰ�̸�</td>
				<td><input name="goods_title" type="text" size="40"  value="${goods.goods_title }"/></td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_title')"/>
				</td>
			</tr>
			
			<tr>
				<td >����</td>
				<td><input name="goods_writer" type="text" size="40" value="${goods.goods_writer }" /></td>
								<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_writer')"/>
				</td>
				
			</tr>
			<tr>
				<td >���ǻ�</td>
				<td><input name="goods_publisher" type="text" size="40" value="${goods.goods_publisher }" /></td>
			     <td>
				  <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_publisher')"/>
				</td>
				
			</tr>
			<tr>
				<td >��ǰ����</td>
				<td><input name="goods_price" type="text" size="40" value="${goods.goods_sales_price }" /></td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_price')"/>
				</td>
				
			</tr>
			
			<tr>
				<td >��ǰ�ǸŰ���</td>
				<td><input name="goods_sales_price" type="text" size="40" value="${goods.goods_sales_price }" /></td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_sales_price')"/>
				</td>
				
			</tr>
			
			
			<tr>
				<td >��ǰ ���� ����Ʈ</td>
				<td><input name="goods_point" type="text" size="40" value="${goods.goods_point }" /></td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_point')"/>
				</td>

			</tr>
			
			<tr>
				<td >��ǰ������</td>
				<td><input  name="goods_published_date"  type="text" size="40" value="${goods.goods_published_date }" /></td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_published_date')"/>
				</td>

			</tr>
			
			<tr>
				<td >��ǰ �� ��������</td>
				<td><input name="goods_total_page" type="text" size="40"  value="${goods.goods_total_page }"/></td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_total_page"/>
				</td>

			</tr>
			
			<tr>
				<td >ISBN</td>
				<td><input name="goods_isbn" type="text" size="40" value="${goods.goods_isbn }" /></td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_isbn')"/>
				</td>

			</tr>
			<tr>
				<td >��ǰ ��ۺ�</td>
				<td><input name="goods_delivery_price" type="text" size="40"  value="${goods.goods_delivery_price }"/></td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_delivery_price')"/>
				</td>

			</tr>
			<tr>
				<td >��ǰ ���� ������</td>
				<td><input name="goods_delivery_date" type="text" size="40" value="${goods.goods_delivery_date }" /></td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_delivery_date')"/>
				</td>

			</tr>
			
			<tr>
				<td >��ǰ����</td>
				<td>
				<select name="goods_type">
				  <option value="bestseller"  >����Ʈ����</option>
				  <option value="steadyseller" >���׵𼿷�</option>
				  <option value="newbook" >�Ű�</option>
				  <option value="on_sale" >�Ǹ���</option>
				  <option value="buy_out"  selected>ǰ��</option>
				  <option value="out_of_print" >����</option>
				</select>
				<input  type="hidden" name="h_goods_type" value="${goods.goods_type }"/>
				</td>
				<td>
				 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_type')"/>
				</td>
			</tr>
			<tr>
			 <td colspan=3>
			   <br>
			 </td>
			</tr>
				</table>	
			</DIV>
			<DIV class="tab_content" id="tab2">
				<H4>å����</H4>
				<table>	
				<tr>
					<td >��ǰ����</td>
					<td><textarea  rows="100" cols="80" name="goods_contents_order">
					  ${goods.goods_contents_order }
					</textarea>
					</td>
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;
					 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_contents_order')"/>
					</td>
				</tr>
				</table>	
			</DIV>
			<DIV class="tab_content" id="tab3">
				<H4>��ǰ ���� �Ұ�</H4>
				<P>
				 <table>
	  				 <tr>
						<td >��ǰ ���� �Ұ�</td>
						<td><textarea  rows="100" cols="80" name="goods_writer_intro">
						  ${goods.goods_writer_intro }
						</textarea>
						</td>
						<td>
						&nbsp;&nbsp;&nbsp;&nbsp;
						 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_writer_intro')"/>
						</td>
				   </tr>
			   </table>
				</P>
			</DIV>
			<DIV class="tab_content" id="tab4">
				<H4>��ǰ�Ұ�</H4>
				<P>
				<table>
					<tr>
						<td>��ǰ�Ұ�</td>
						<td><textarea  rows="100" cols="80" name="goods_intro">
						${goods.goods_intro }
						</textarea>
						</td>
						<td>
						&nbsp;&nbsp;&nbsp;&nbsp;
						 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_intro')"/>
						</td>
					</tr>
			    </table>
				</P>
			</DIV>
			<DIV class="tab_content" id="tab5">
				<H4>���ǻ� ��ǰ ��</H4>
				<P>
				<table>
					<tr>
						<td>���ǻ� ��ǰ ��</td>
						<td><textarea  rows="100" cols="80" name="goods_publisher_comment">
						  ${goods.goods_publisher_comment }
						</textarea>
						</td>
						<td>
						&nbsp;&nbsp;&nbsp;&nbsp;
						 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_publisher_comment')"/>
						</td>
					</tr>
			</table>
				</P>
			</DIV>
			<DIV class="tab_content" id="tab6">
				<H4>��õ��</H4>
				<p>
				 <table>
					 <tr>
						<td>��õ��</td>
						<td><textarea  rows="100" cols="80" name="goods_recommendation">
						  ${goods.goods_recommendation }
						</textarea>
						</td>
						<td>
						&nbsp;&nbsp;&nbsp;&nbsp;
						 <input  type="button" value="�����ݿ�"  onClick="fn_modify_goods('${goods.goods_id }','goods_recommendation')"/>
						</td>
					</tr>
			    </table>
				</p>
			</DIV>
		</DIV>
		
	</DIV>
	<DIV class="clear"></DIV>
	<table>
		<tr>
		  <td align=center colspan=2>
			<INPUT   type="button" value="�̹��������ϱ�" onClick="fn_moveToImagePage('${goods.goods_id }')"> 
		   </td>
		</tr> 
	</table>				
</form>	