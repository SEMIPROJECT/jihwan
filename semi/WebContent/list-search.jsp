<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %> 
 
                <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->

<html>
<head>
<link rel="stylesheet" type="text/css" href="css/table.css">

</head>

<body>
<%@include file="inc/asdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>

	<form method="post" action="list-search.jsp">
		<table style="border: 1px solid black">			
			<tr>
				<td>��ǰ�ڵ� : </td>
				<td><input type="text" name="code" /></td>
			</tr>
	
				<tr>
				<td colspan="2" align="center">
					<input class="b1"  type="submit" value="����"  />&nbsp;&nbsp;&nbsp;					
				</td> 	
			</tr>			
		</table>
	</form>
	
<br/>
<table width="550" border="1">
<%
ResultSet rs = null;
Connection conn = null;                                        // null�� �ʱ�ȭ �Ѵ�.
PreparedStatement pstmt = null;

try{
	String url = "jdbc:mysql://192.168.10.49:3306/testboard";
	String id = "root";                                                    // ����� ����
	String pw = "1234";                                                // ����� ������ �н�����

	Class.forName("com.mysql.jdbc.Driver");                      // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.
	conn=DriverManager.getConnection(url,id,pw); 
	String a = request.getParameter("code");
	if(a != ""){
	String sql = "select * from tlist where code = ?";                        // sql ����
	pstmt = conn.prepareStatement(sql);                          // prepareStatement���� �ش� sql�� �̸� �������Ѵ�.
	pstmt.setString(1,a);
	}
	if(a == ""){
		String sql1 = "select * from tlist order by code";                        // sql ����
		pstmt = conn.prepareStatement(sql1);                          // prepareStatement���� �ش� sql�� �̸� �������Ѵ�.
		
	}

	rs = pstmt.executeQuery();                                        // ������ �����ϰ� ����� ResultSet ��ü�� ��´�.
%>
	<tr class="lv-bg">
		<td width="200">��ǰ�ڵ�</td>
		<td width="100">��ǰ��</td>
		<td width="100">��ü��</td>		
		<td width="100">�԰�ܰ�</td>
		<td width="100">�ǸŴܰ�</td>
		<td width="100">�μ���ȣ</td>
	</tr>
<%	
	while(rs.next()){                                                        // ����� �� �྿ ���ư��鼭 �����´�.
		int code = rs.getInt("code");
		String iname = rs.getString("iname");
		String cname = rs.getString("cname");
		int price = rs.getInt("price");
		int sprice = rs.getInt("sprice");
		int des = rs.getInt("des");
		
		
%>		
	<tr class="lv-bg">
		<td width="200"><%=code%></td>
		<td width="100"><%=iname%></td>
		<td width="100"><%=cname%></td>
		<td width="100"><%=price%></td>
		<td width="100"><%=sprice%></td>
		<td width="100"><%=des%></td>
	</tr>

<%
		}

	}
	catch(Exception e){                                                    // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.
		e.printStackTrace();
		out.println("member ���̺� ȣ�⿡ �����߽��ϴ�.");
	}
	finally	{                                                            // ������ ���� �Ǵ� ���п� ������� ����� �ڿ��� ���� �Ѵ�.  (�����߿�)
		if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset ��ü ����
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement ��ü ����
		if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection ����
	}
%>
</table>
</body>
</html>