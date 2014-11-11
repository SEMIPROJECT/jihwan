<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >
<%@ page import="java.sql.Connection,java.sql.Date,java.sql.DriverManager
,java.sql.ResultSet,java.sql.SQLException,java.sql.SQLIntegrityConstraintViolationException,
java.sql.Statement,java.util.Scanner" %>
<%@ page import = "java.sql.*" %> 
                <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

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
  </script>
  <link rel="stylesheet" type="text/css" href="css/table.css">
</head>
<body>
<%@include file="inc/asdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>
<jsp:useBean id="dao" class="mybean.semiDao"	/>
<jsp:useBean id="dto" class="mybean.semiDto"	/>

   <form method="post" action="output.jsp">
      <div style="border: 1px" >         
         <div>
            <div>출고입력</div>
            <div>상품코드 : <input type="text" name="code" /></div>            
            <div>출고갯수 : <input type="text" name="count" /></div>
            <div>출고날짜 : <input type="text" id="datepicker" name="date" /></div>
         </div>
   <hr/>
         
            <div>               
               <input class="b1" type="submit" value="전송" />               
            </div>
               
      </div>
   </form>


<table width="550" border="1">
<%
	if(request.getParameter("code") != null && request.getParameter("count") != null
			&& request.getParameter("date") != null){
		// setList_code(), setSt_cnt(), setOdate()
		dto.setList_code(Integer.parseInt(request.getParameter("code")));
   	  	dto.setSt_cnt(Integer.parseInt(request.getParameter("count")));
   	   	dto.setOdate(request.getParameter("date"));
   	   	
   		dao.insertOutput(dto);
 	   	response.sendRedirect("output.jsp");
	}
%>
</table>
</body>
</html>