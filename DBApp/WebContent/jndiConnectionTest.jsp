<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<h1>JNDI�� �̿��� DB���� �׽�Ʈ</h1>
<%
	try{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/DBL3");
			// ��ҹ��ڵ� Ʋ���� X/java:comp/env : ���� ������Ʈ/Object->DataSource
		Connection con = ds.getConnection();
			
		if(con != null)
			out.println("���� ����");
	}
	catch(Exception err){
		System.out.println("���� ���� : " + err);
	}
%>
</body>
</html>