<%@page contentType="text/html;charset=euc-kr" %>
<%@page import="semi.DBConnectionMgr" %>
<!DOCTYPE html >
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %> 
                <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

<html>
<head>
<link rel="stylesheet" type="text/css" href="css/table.css">

</head>

<body>
<%@include file="inc/pasdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>

	<form method="post" action="test-plist-search.jsp">
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
ResultSet rs = null;
Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;
DBConnectionMgr pool = null;

try{
	   pool = DBConnectionMgr.getInstance();		
	   conn= pool.getConnection(); 
	String a = request.getParameter("code");
	
	String sql = "select pnum from plist where pcode = ?";                        // sql 쿼리
	pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setString(1,a);
	rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
	
	rs.next();
	int pnum = rs.getInt("pnum");
	
	String sql1 = "select posname from pposit where pnum = ?";                        // sql 쿼리
	pstmt = conn.prepareStatement(sql1);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setInt(1,pnum);
	rs = pstmt.executeQuery();
	
	rs.next();
	String posname = rs.getString("posname");
	
	String sql3 = "select pcode,pname,pdes,phdate from plist where pcode = ?";                        // sql 쿼리
	pstmt = conn.prepareStatement(sql3);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setString(1,a);
	rs = pstmt.executeQuery(); 
	%>
	<tr class="lv-bg">
		<td width="50">사원코드</td>
		<td width="50">사원명</td>
		<td width="50">부서번호</td>
		<td width="50">직위</td>
		<td width="50">입사일자</td>
	</tr>
<%	
if(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
	int pcode = rs.getInt("pcode");
	String pname = rs.getString("pname");
	int pdes = rs.getInt("pdes");
	String phdate = rs.getString("phdate");
	
	
%>		
<tr class="lv-bg">
	<td width="50"><%=pcode%></td>
	<td width="50"><%=pname%></td>
	<td width="50"><%=pdes%></td>
	<td width="50"><%=posname%></td>
	<td width="50"><%=phdate%></td>

</tr>

<%
		}
	}
	catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		//e.printStackTrace();
		//out.println("member 테이블 호출에 실패했습니다.");
	}
	finally	{       
		pool.freeConnection(conn,pstmt,rs);
	}
%>
</table>
</body>
</html>