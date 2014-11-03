<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >
<%@ page import = "java.sql.*" %> 

<html>
<head>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <link rel="stylesheet" type="text/css" href="css/table.css">
  <script>
  $(function() {
    $( "#datepicker" ).datepicker({
    	dateFormat:"yy/mm/dd"
    });
  });
</script>
</head>
<body>
<%@include file="inc/asdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>
   <form method="post" action="output_Proc.jsp">
   <div style="border: 1px" >         
         <div>
            <div>출고입력</div>
            <div>상품코드 : <input type="text" name="code" /></div>            
            <div>출고갯수 : <input type="text" name="count" /></div>
            <div>출고날짜 : <input type="text" id="datepicker" name="odate" /></div>
         </div>
   <hr/> 
            <div>               
               <input class="b1" type="submit" value="전송" />               
            </div>
               
      </div>
   </form>
</body>
</html>