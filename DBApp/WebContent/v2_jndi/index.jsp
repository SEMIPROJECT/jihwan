<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>

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
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	request.setCharacterEncoding("euc-kr");
	String search = request.getParameter("search");
	String searchText = request.getParameter("searchText");
	String sql = "";
	
	try{
		if(searchText.isEmpty()){
			sql = "select * from tblsawon order by no";
		}
		else{
			sql = "select * from tblsawon where " + search + " like '%" + searchText + "%' order by no";
		}
	}
	catch(NullPointerException err){
		sql = "select * from tblsawon order by no";
	}
	try{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/DBL3");
		con = ds.getConnection();
		/* 
		Class.forName("org.gjt.mm.mysql.Driver");
		String url = "jdbc:mysql://localhost:3306/dbl3";
		con = DriverManager.getConnection(url, "root", "1111");
		 */
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		while(rs.next()){
%>
	<tr>
		<td><%=rs.getInt("no") %></td>
		<td><%=rs.getString("id") %></td>
		<td><%=rs.getString("name") %></td>
		<td><%=rs.getString("pass") %></td>
		<td><%=rs.getInt("age") %></td>
		<td><%=rs.getString("addr") %></td>
		<td><%=rs.getString("ext") %></td>
		<td><%=rs.getString("dept") %></td>
		<td><a href="editSawon.jsp?no=<%=rs.getInt("no") %>">����</a></td>
		<td><a href="javascript:fnDeleteChk(<%=rs.getInt("no") %>)">����</a></td>
	</tr>
<%
		}
	}
	catch(Exception err){
		System.out.println("index.jsp : " + err);
	}
	finally{
		if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(con != null) try{con.close();}catch(SQLException sqle){}
	}
%>
</table>
</body>
</html>