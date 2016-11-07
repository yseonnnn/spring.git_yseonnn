<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
 function fn_delete_image(image_id,fileName,input_id){
	 alert(input_id);
	 input=document.getElementById(input_id);
	//return ;
	
	 $.ajax({
		type : "post",
		async : false, //false�� ��� ��������� ó���Ѵ�.
		url : "http://localhost:8090/bookshop01/admin/goods/deleteImageFile.do",
		data : {
			command:"delete_image",
			image_id:image_id,
			fileName:fileName
		},
		success : function(data, textStatus) {
			if(data.trim()=='delete_success'){
				alert("������ �����߽��ϴ�.");
				input.value="";
				
			}
		},
		error : function(data, textStatus) {
			alert("������ �߻��߽��ϴ�."+data);
		},
		complete : function(data, textStatus) {
			//alert("�۾����Ϸ� �߽��ϴ�");
			
		}
	}); //end ajax	 
	 //window.location.reload();
}
</script>
</HEAD>
<BODY>
<form action="${pageContext.request.contextPath}/admin/goods/modifyGoodsImage.do" method="post"	enctype="multipart/form-data">
		<h1>��ǰ �̹��� ����â</h1>
		<br>
<table  cellspacing="0" cellpadding="0">
		<tr>
		 <td>
		   <br> 
		 </td>
		</tr>
 <c:choose>
   <c:when test="${empty imageFileList }">
      <tr>
			<td>�� �̹���1</td>
			<td>
				<input type="file" name="detail_image1" >
				<input type="text" disabled  />
				<br>
			</td>
		</tr>
		<tr>
		 <td>
		   <br>
		 </td>
		</tr>
		<tr>
			<td>�� �̹���2</td>
			<td>
				<input type="file" name="detail_image2" >
				<input type="text" disabled  />
				<br>
			</td>
		</tr>
		<tr>
		 <td>
		   <br>
		 </td>
		</tr>
		<tr>
			<td>�� �̹���3</td>
			<td>
				<input type="file" name="detail_image3"> 
				<input type="text" disabled  />
				<br>
			</td>
		</tr>
		<tr>
		 <td>
		   <br>
		 </td>
		</tr>
   </c:when>		
   <c:otherwise>
     <c:forEach var="item" items="${imageFileList }"  varStatus="itemNum">
       <c:choose>
         <c:when test="${itemNum.count==1 }">
            <tr>
			<td>���� �̹���${itemNum.count }</td>
			<td>
				<input type="file" name="main_image" >
				<input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  />
				<input type="hidden"  name="image_id" value="${item.image_id }"  />
				<br>
			</td>
			<td>
			  &nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td>
			 <input  type="button" value="�̹��� ����"  onClick="fn_delete_image('${item.image_id }','${item.fileName }','image_id${itemNum.count }')"/>
			</td>
		</tr>
		<tr>
		 <td>
		   <br>
		 </td>
		</tr>
         </c:when>
         <c:otherwise>
           <tr>
			<td>�� �̹���${itemNum.count }</td>
			<td>
				<input type="file" name="detail_image${itemNum.count-1 }" >
				<input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  />
				<input type="hidden"  name="image_id" value="${item.image_id }"  />
				<br>
			</td>
			<td>
			  &nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td>
			 <input  type="button" value="�̹��� ����"  onClick="fn_delete_image('${item.image_id }','${item.fileName }','image_id${itemNum.count }')"/>
			</td>
		</tr>
		<tr>
		 <td>
		   <br>
		 </td>
		</tr> 
         </c:otherwise>
       </c:choose>		
		
    </c:forEach>
 </c:otherwise>
</c:choose>		
		<tr>
			<td align=center colspan=2>
		      <INPUT   type="submit"  value="��ǰ �̹��� �����ϱ�">
		      <INPUT type="button" onClick="fn_return_list()" value="����Ʈ�� ���ư���"> 
			</td>
		</tr> 
	</table>		
		</form>
