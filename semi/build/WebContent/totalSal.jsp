<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/table.css">
<title>Insert title here</title>
</head>
<body>
<h1>���� �޿� ��ȸ</h1>
<br/><br/>
<div align="center">
	<form method="post" action="totalSal.jsp">
		<select name="search">
			<option value="p1.pcode">���</option>
			<option value="p1.pname">�̸�</option>
		</select>
		<input type="text" name="searchText"/>
		<input type="submit" value="�˻�" />
	</form>
</div>
<br/><br/>
<table border="1">
	<tr>
		<th>���</th><th>�̸�</th><th>�μ�</th>
		<th>����</th><th>�⺻�޿�</th><th>�����޿�
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
				//alert("�ش� ����� �����ϴ�.")
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