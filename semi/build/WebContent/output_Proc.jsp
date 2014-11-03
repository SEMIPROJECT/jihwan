<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<jsp:useBean id="stockdao" class="semi.StockDao"/>
<jsp:useBean id="stockdto" class="semi.StockDto"/>
<script>
	function status(s, name, count){
		if(s==1){
			alert(name+"의 재고가 모두 소진되었습니다.");
		}
		else if(s==2){
			alert(name+"의 재고가 "+count+"개 남았습니다.");
		}
		else if(s==3){
			alert(name+"의 재고가 부족합니다.");
		}
	}
</script>
<jsp:setProperty property="code" name="stockdto"/>
<jsp:setProperty property="count" name="stockdto"/>
<jsp:setProperty property="odate" name="stockdto"/>
<%
	int s = stockdao.addOutput(stockdto);
%>
<%-- <%=s %>
<%=stockdto.getName()%>
<%=stockdto.getCount()%><br/><br/> --%>
</head>
<body onunload="status('<%=s %>', '<%=stockdto.getName()%>', '<%=stockdto.getCount()%>')">

<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<meta http-equiv="refresh" content="0.01;url=output.jsp">
</body>
</html>
