
<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >
<%@ page import="java.sql.Connection,java.sql.Date,java.sql.DriverManager
,java.sql.ResultSet,java.sql.SQLException,java.sql.SQLIntegrityConstraintViolationException,
java.sql.Statement,java.util.Scanner" %>
<%@ page import = "java.sql.*" %> 
                <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->

<html>
<head>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
  $(function() {
    $( "#datepicker" ).datepicker({
    	dateFormat:"yy/mm/dd"
    });
  });
  <link rel="stylesheet" type="text/css" href="css/table.css">
  </script>
</head>
<body>
<%@include file="inc/asdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>
<jsp:useBean id="dao" class="mybean.semiDao"	/>
<jsp:useBean id="dto" class="mybean.semiDto"	/>

   <form method="post" action="input.jsp">
      <div style="border: 1px" >         
         <div>
            <div>�԰��Է�</div>
            <div>��ǰ�ڵ� : <input type="text" name="code" /></div>            
            <div>�԰��� : <input type="text" name="count" /></div>
            <div>�԰�¥ : <input type="text" id="datepicker" name="date" /></div>
         </div>
   <hr/>
         
            <div>               
               <input class="b1" type="submit" value="����" />               
            </div>
               
      </div>
   </form>


<table width="550" border="1">
<%
   int code = Integer.parseInt((request.getParameter("code"));
   int count = Integer.parseInt((request.getParameter("count"));
   String date = request.getParameter("date");
   
   
   
   pstmt.setString(1, count); //code
   pstmt.setString(2, a); // count
   int result = pstmt.executeUpdate();   
   out.println(result);
    if(result == 0){
    	out.println("����");
       String sql2 = "insert into tstock values(?, ?, ?, ?, ?, ?,?)";
       System.out.println(sql2);
       pstmt = conn.prepareStatement(sql2);
       pstmt.setString(1, a); //code
       pstmt.setString(2, iname); // iname
       pstmt.setString(3, cname); // cname
       pstmt.setString(4, count); // count
       pstmt.setInt(5, price); // price
       pstmt.setInt(6, sprice); // sprice
       pstmt.setInt(7, des); // desc
       pstmt.executeUpdate();
       
       String sql4 = "insert into tinput values(? , ?, ?, ?,?)";
       
       pstmt = conn.prepareStatement(sql4);
       pstmt.setString(1, a);
       pstmt.setString(2, iname);
       pstmt.setString(3, count);
       pstmt.setString(4, date); //��¥
       pstmt.setInt(5, des); // desc
       pstmt.executeUpdate();
    }
    else{    	
       String sql4 = "insert into tinput values(?, ?, ?, ?,?)";            
       pstmt = conn.prepareStatement(sql4);
       pstmt.setString(1, a);
       pstmt.setString(2, iname);
       pstmt.setString(3, count);
       pstmt.setString(4, date); //��¥
       pstmt.setInt(5, des); // desc
       pstmt.executeUpdate();
    }
  
   }
   catch(Exception e){                                                    // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.
     //e.printStackTrace();
	    String a = request.getParameter("code");
/*       if(a != null)
      out.println("�Էµ� ���� ���ų� ����Ʈ�� ���� ��ǰ�Դϴ�.");  */
   }
   finally   {                                                            // ������ ���� �Ǵ� ���п� ������� ����� �ڿ��� ���� �Ѵ�.  (�����߿�)
      if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset ��ü ����
      if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement ��ü ����
      if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection ����
   }
%>
</table>
</body>
</html>