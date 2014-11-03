<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/table.css">
<title>Insert title here</title>
</head>
<body>
<h1>직원 급여 조회</h1>
<br/><br/>
<div align="center">
	<form method="post" action="totalSal.jsp">
		<select name="search">
			<option value="p1.pcode">사번</option>
			<option value="p1.pname">이름</option>
		</select>
		<input type="text" name="searchText"/>
		<input type="submit" value="검색" />
	</form>
</div>
<br/><br/>
<table border="1">
	<tr>
		<th>사번</th><th>이름</th><th>부서</th>
		<th>직급</th><th>기본급여</th><th>최종급여
	</tr>
<% 
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String getpname=null, getposname=null;
	int getpcode=0, getpdes=0, getpnum=0, getpsa=0, penal=0;
	
	String url="jdbc:mysql://192.168.10.49:3306/testboard";
	String id="root";
	String pw="1234";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection(url, id, pw);
		
		request.setCharacterEncoding("euc-kr");
		String search=request.getParameter("search");
		String searchText=request.getParameter("searchText");
		String sql="";
		try{
			if(searchText==null || searchText.isEmpty()){
				sql="SELECT p1.pcode, p1.pname, p1.pdes, p2.posname, p2.pnum "
					+"FROM plist p1 INNER JOIN pposit p2 "
					+"ON p1.pnum=p2.pnum WHERE p1.pcode>0";	
			}
			else{
				sql="SELECT p1.pcode, p1.pname, p1.pdes, p2.posname, p2.pnum "
					+"FROM plist p1 INNER JOIN pposit p2 "
					+"ON p1.pnum=p2.pnum WHERE "+search+"='"+searchText+"'";	
			}
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			System.out.println(sql);
			%>
			<%=sql %>
			<%=search %>
			<%
			while(rs.next()){
				getpcode=rs.getInt("p1.pcode");
				getpname=rs.getString("p1.pname");
				getpdes=rs.getInt("p1.pdes");
				getposname=rs.getString("p2.posname");
				getpnum=rs.getInt("p2.pnum");
			}
			
			sql="SELECT psa FROM psal WHERE pdes=10 AND pnum=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, getpnum);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				getpsa=rs.getInt("psa");
				%>
				<tr>
				<td><%=getpcode %></td>
				<td><%=getpname %></td>
				<td><%=getpdes %></td>
				<td><%=getposname %></td>
				<td><%=getpsa %></td>
				<td><%=getpsa-penal %></td>
				</tr>
				<%
			}	
		}
		catch(NullPointerException err){
			err.printStackTrace();
			%>

			<script>
				//alert("해당 사원이 없습니다.")
				//location.href="totalSal.jsp";
			</script>
			<%
		}
	}
	catch(Exception err){
		
	}
	finally{
		if(rs!=null)try{rs.close();}catch(Exception err){}
		if(pstmt!=null)try{pstmt.close();}catch(Exception err){}
		if(con!=null)try{con.close();}catch(Exception err){}
	}
%>
</table>
</body>
</html>