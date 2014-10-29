<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��� ����</title>
</head>
<body>
<%
	String no = request.getParameter("no");
	out.println(no);
	String id = null;
	String name = null;
	String pass = null;
	String age = null;
	String addr = null;
	String ext = null;
	String dept = null;
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/DBL3");
		con = ds.getConnection();
		/* 
		Class.forName("org.gjt.mm.mysql.Driver");
		String url = "jdbc:mysql://localhost:3306/dbl3";
		con = DriverManager.getConnection(url, "root", "1111");
		 */
		String sql = "select * from tblsawon where no=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, no);
		rs = pstmt.executeQuery();

		if(rs.next()){
			id = rs.getString("id");
			name = rs.getString("name");
			pass = rs.getString("pass");
			age = new String().valueOf(rs.getInt("age"));
			addr = rs.getString("addr");
			ext = rs.getString("ext");
			dept = rs.getString("dept");
		}
	}
	catch(Exception err){
		System.out.println("editSawon.jsp : " + err);
	}
	finally{
		if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(con != null) try{con.close();}catch(SQLException sqle){}
	}
%>
<h1>��� ����</h1>
<form method="post" action="editSawon_proc.jsp">
<!-- hidden�� ������ �뵵 -->
<input type="hidden" name="no" value="<%=no %>"	/>
<table border="1">
	<tr>
		<td>ID : </td>
		<td><input type="text" name="id" value="<%=id %>"	/></td>
	</tr>
	<tr>
		<td>�̸� : </td>
		<td><input type="text" name="name" value="<%=name %>"	/></td>
	</tr>
	<tr>
		<td>�н����� : </td>
		<td><input type="text" name="pass" value="<%=pass %>"	/></td>
	</tr>
	<tr>
		<td>���� : </td>
		<td><input type="text" name="age"	 value="<%=age%>"/></td>
	</tr>
	<tr>
		<td>�ٹ��� : </td>
		<td>
			<select name="addr">
				<option value="����" <%if(addr.equals("����")){ %>
						 selected="true"	<%}%>>����</option>
				<option value="���" <%if(addr.equals("���")){ %>
						 selected="true"	<%}%>>���</option>
				<option value="����" <%if(addr.equals("����")){ %>
						 selected="true"	<%}%>>����</option>
				<option value="�λ�" <%if(addr.equals("�λ�")){ %>
						 selected="true"	<%}%>>�λ�</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>���� ��ȣ : </td>
		<td><input type="text" name="ext" value="<%=ext %>"	/></td>
	</tr>
	<tr>
		<td>�μ��� : </td>
		<td>
			<select name="dept">
				<option value="����" <%if(dept.equals("����")){ %>
						selected="true"<%}%>>����</option>
				<option value="���" <%if(dept.equals("���")){ %>
						selected="true"<%}%>>���</option>
				<option value="��ȹ" <%if(dept.equals("��ȹ")){ %>
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