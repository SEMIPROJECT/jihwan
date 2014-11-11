<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >
<%@page import="mybean.DBConnectionMgr"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/table.css">

</head>

<body>
<%@include file="inc/pasdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>

	<form method="post" action="sal-search.jsp">
		<table style="border: 1px solid black">			
			<tr>
				<td>사원번호 검색 : </td>
				<td><input type="text" name="code" /></td>				
			</tr>
	
				<tr>
				<td colspan="2" align="center">
					<input class="b1"  type="submit" value="전송"  />&nbsp;&nbsp;&nbsp;					
				</td> 	
			</tr>			
		</table>
	</form>
	
<br/>
<table width="550" border="1">
<%
DBConnectionMgr pool = null;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String code = request.getParameter("code");

try{
	pool = DBConnectionMgr.getInstance();
	conn = pool.getConnection();
	
	//String sql = "select phdate,psa,pname,p.pdes,p.pnum from plist p , psal s where p.pdes = s.pdes and p.pnum = s.pnum and pcode = ?";                        // sql 쿼리
	String sql = "select phdate, psa, pname, p.pdes, p.pnum from plist p , psal s where p.pdes = s.pdes and p.pnum = s.pnum and pcode = ?";
	pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setString(1, code);
	rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
	
	rs.next();
	String phdate = rs.getString("phdate");	
	int psa = rs.getInt("psa");
	String pname = rs.getString("pname");	
	int pdes = rs.getInt("p.pdes");
	int pnum = rs.getInt("pnum");
	
	String sql1 = "select posname from pposit where pnum = ?";                        // sql 쿼리
	pstmt = conn.prepareStatement(sql1);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setInt(1,pnum);
	rs = pstmt.executeQuery();
	
	rs.next();
	String posname = rs.getString("posname");
	//psa = psa - 50000;
	%>
	<tr class="lv-bg">
		<td width="50">사원코드</td>
		<td width="50">사원명</td>
		<td width="50">부서번호</td>
		<td width="50">직급</td>
		<td width="50">급여</td>
		<td width="50">입사일자</td>
	</tr>
<%	

%>		
<tr class="lv-bg">
	<td width="50"><%=code%></td>
	<td width="50"><%=pname%></td>
	<td width="50"><%=pdes%></td>
	<td width="50"><%=posname%></td>
	<td width="50"><%=psa%></td>
	<td width="50"><%=phdate%></td>

</tr>

<%

	}
	catch(Exception e){
		System.out.println("delegency-search.jsp : error ");
	}
	finally	{
		pool.freeConnection(conn, pstmt, rs);
	}
%>
</table>
</body>
</html>