<%@page import="mybean.SawonDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script>
	function fnDeleteChk(no){
		var result=confirm("���� �����Ͻðڽ��ϱ�?");
		
		if(result == true){
			location.href = "deleteSawon.jsp?no=" + no;
		}
	}
</script>
</head>
<body>
<jsp:useBean id="dto" class="mybean.SawonDto"	/>
<jsp:useBean id="dao" class="mybean.SawonDao"	/>

<h1>���� ���� ����Ʈ</h1>
<a href="addSawon.html">���� �߰�</a>
<br/><br/>
<form method="post" action="index.jsp">
	<select name="search">
		<option value="id">���̵�</option>
		<option value="name">�̸�</option>
		<option value="dept">�μ�</option>
		<option value="addr">�ٹ���</option>
	</select>
	<input type="text" name="searchText"	/>
	<input type="submit"	value="�˻�"	/>
</form>
<table border="1">
	<tr>
		<th>���</th><th>ID</th><th>�̸�</th>
		<th>�н�����</th><th>����</th><th>�ٹ���</th>
		<th>������ȣ</th><th>�μ���</th>
	</tr>
 <%
 	request.setCharacterEncoding("euc-kr");
	String search = request.getParameter("search");
	String searchText = request.getParameter("searchText");
	
	try{
		List list = dao.getList(search, searchText);
		for(int i=0; i<list.size(); i++){
			dto = (SawonDto) list.get(i);
			pageContext.setAttribute("dto", dto);
%>
	<tr>
		<td><jsp:getProperty property="no" name="dto"	/></td>
		<%-- 
		<td><%=dto.getId() %></td>
		<td><%=dto.getName() %></td>
		<td><%=dto.getPass() %></td>
		<td><%=dto.getAge() %></td>
		<td><%=dto.getAddr() %></td>
		<td><%=dto.getExt() %></td>
		<td><%=dto.getDept() %></td>
		 --%>
		<td><jsp:getProperty property="id" name="dto"	/></td>
		<td><jsp:getProperty property="name" name="dto"	/></td>
		<td><jsp:getProperty property="pass" name="dto"	/></td>
		<td><jsp:getProperty property="age" name="dto"	/></td>
		<td><jsp:getProperty property="addr" name="dto"	/></td>
		<td><jsp:getProperty property="ext" name="dto"	/></td>
		<td><jsp:getProperty property="dept" name="dto"	/></td>
		<td><a href="editSawon.jsp?no=<%=dto.getNo() %>">����</a></td>
		<td><a href="javascript:fnDeleteChk(<%=dto.getNo() %>)">����</a></td>
<%
		}
	}
	catch(Exception err){
		System.out.println("index.jsp : " + err);
	}
%>
	</tr>
</table>
</body>
</html>