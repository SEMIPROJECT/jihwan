<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
 
<%	
String search = request.getParameter("search");
String searchText = request.getParameter("searchText");
		request.setCharacterEncoding("euc-kr");
		response.setCharacterEncoding("euc-kr");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String empno =request.getParameter("empno");
		String ename =request.getParameter("ename");
		String position =request.getParameter("position");
		String dept= request.getParameter("dept");
		String hire_date= request.getParameter("hire_date");
		
	try{
		Class.forName("org.gjt.mm.mysql.Driver");
		String url = "jdbc:mysql://localhost:3306/testboard";
		con = DriverManager.getConnection(url, "root", "1111");
		
		String insert = "INSERT INTO insa(ename, position, dept, hire_date) values( ?, ?, ?, ?)";
		pstmt= con.prepareStatement(insert);
		pstmt.setString(1, ename);
		pstmt.setString(2, position);
		pstmt.setString(3, dept);
		pstmt.setString(4, hire_date);
		pstmt.executeUpdate();
		
	}catch(Exception ex){
		ex.printStackTrace();
	}
%>
<%=search %><br>
<%=searchText %>
<a href="addSawon.html">직원추가</a><br>
<a href="insaSearch.jsp">메인</a>
</body>
</html>