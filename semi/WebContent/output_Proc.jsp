<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="stockdao" class="semi.StockDao"/>
<jsp:useBean id="stockdto" class="semi.StockDto"/>
<jsp:setProperty property="code" name="stockdto"/>
<jsp:setProperty property="count" name="stockdto"/>
<jsp:setProperty property="idate" name="stockdto"/>

<%
	stockdao.addOutput(stockdto);
	response.sendRedirect("output.jsp");
%>