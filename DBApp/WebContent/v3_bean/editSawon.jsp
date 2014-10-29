<%@page import="mybean.SawonDto"%>
<%@page import="mybean.DBConnectionMgr"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��� ����</title>
</head>
<body>
<jsp:useBean id="dao" class="mybean.SawonDao"	/>
<jsp:useBean id="dto" class="mybean.SawonDto"	/>
<%
	request.setCharacterEncoding("euc-kr");
	int no = Integer.parseInt(request.getParameter("no"));
	out.println(no);
	
	try{
		dto = (SawonDto)dao.getSawon(no);
	}
	catch(Exception err){
		System.out.println("editSawon.jsp : " + err);
	}
%>
<h1>��� ����</h1>
<form method="post" action="editSawon_proc.jsp">
<!-- hidden�� ������ �뵵 -->
<input type="hidden" name="no" value=<%=no%>	/>
<table border="1">
	<tr>
		<td>ID : </td>
		<td><input type="text" name="id" value="<%=dto.getId() %>"	/></td>
	</tr>
	<tr>
		<td>�̸� : </td>
		<td><input type="text" name="name" value="<%=dto.getName() %>"	/></td>
	</tr>
	<tr>
		<td>�н����� : </td>
		<td><input type="text" name="pass" value="<%=dto.getPass() %>"	/></td>
	</tr>
	<tr>
		<td>���� : </td>
		<td><input type="text" name="age"	 value="<%=dto.getAge()%>"/></td>
	</tr>
	<tr>
		<td>�ٹ��� : </td>
		<td>
			<select name="addr">
				<option value="����" <%if(dto.getAddr().equals("����")){ %>
						 selected="true"	<%}%>>����</option>
				<option value="���" <%if(dto.getAddr().equals("���")){ %>
						 selected="true"	<%}%>>���</option>
				<option value="����" <%if(dto.getAddr().equals("����")){ %>
						 selected="true"	<%}%>>����</option>
				<option value="�λ�" <%if(dto.getAddr().equals("�λ�")){ %>
						 selected="true"	<%}%>>�λ�</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>���� ��ȣ : </td>
		<td><input type="text" name="ext" value="<%=dto.getExt() %>"	/></td>
	</tr>
	<tr>
		<td>�μ��� : </td>
		<td>
			<select name="dept">
				<option value="����" <%if(dto.getDept().equals("����")){ %>
						selected="true"<%}%>>����</option>
				<option value="���" <%if(dto.getDept().equals("���")){ %>
						selected="true"<%}%>>���</option>
				<option value="��ȹ" <%if(dto.getDept().equals("��ȹ")){ %>
						selected="true"<%}%>>��ȹ</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="����"	/>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" value="�ٽ� �ۼ�"	/>
		</td>
	</tr>
</table>
</form>
</body>
</html>