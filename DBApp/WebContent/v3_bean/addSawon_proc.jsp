<%@page import="mybean.DBConnectionMgr"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	// dto �Լ� ȣ�� ���� �Ѱ��� �� ���ڵ�
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="mybean.SawonDao"/>
<jsp:useBean id="dto" class="mybean.SawonDto"/>
<jsp:setProperty property="*" name="dto"	/>
<%
	try{
		/* 
		dto.setId(request.getParameter("id"));
		dto.setName(request.getParameter("name"));
		dto.setPass(request.getParameter("pass"));
		dto.setAge(Integer.parseInt(request.getParameter("age")));
		dto.setAddr(request.getParameter("addr"));
		dto.setExt(request.getParameter("ext"));
		dto.setDept(request.getParameter("dept"));
		 */
		//out.println(dto.getId() + ", " + dto.getName() + ", " + dto.getPass() + ", " + dto.getAge() + ", " + dto.getAddr() + ", " + dto.getExt() + ", " + dto.getDept());		
		dao.addSawon(dto);
%>
<script>
	alert("�� �߰��Ǿ����ϴ�.");
	location.href="index.jsp";
</script>
<%
	}
	catch(Exception err){
		System.out.println("addSawon_proc.jsp : " + err);
		response.sendRedirect("addSawon.html");
	}
%>