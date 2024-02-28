<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ include file = "../include/dbCon.jsp" %>
 
 <%
 	String unq = request.getParameter("unq"); 		// 부모(원글)의 UNQ
	String title = request.getParameter("title");
 	String pass = request.getParameter("pass");
 	String name = request.getParameter("name");
 	String content = request.getParameter("content");
 	
 	String sql1 = "select gid,thread from reboard ";
 		   sql1+= " where unq='"+unq+"' ";
 	ResultSet rs1 = stmt.executeQuery(sql1);
 	rs1.next();
 	String p_gid = rs1.getString("gid");  		// 부모 gid
 	String p_thread = rs1.getString("thread");	// 부보 thread
 	
 	String sql2 = " select ifnull(max(thread),'없음') as maxThread from reboard ";
 		   sql2+= " where gid='"+p_gid+"' and thread like '"+p_thread+"_' ";
 	ResultSet rs2 = stmt.executeQuery(sql2);
 	rs2.next();
 	
 	String maxThread = rs2.getString("maxThread");
 	// ac or 0
 	String myThread = "";
 	
 	if( maxThread.equals("없음") ) {
 		myThread = p_thread + "a";
 	} else {  // ac ,, aabbn => 끝에걸 가져오는 것이 목적 => "aabbn".substring(0,4);
 		char a1 = maxThread.charAt(maxThread.length()-1);
 		a1++; // c => d
 		String a2 = maxThread.substring(0,maxThread.length()-1);
 		myThread = a2 + a1;
 	}
 	
 	String sql3 = "insert into reboard(title,pass,name,content,rdate,gid,thread) ";
 		   sql3+= " values('"+title+"','"+pass+"','"+name+"','"+content+"',now(),'"+p_gid+"','"+myThread+"')";
 	int result = stmt.executeUpdate(sql3);
 %>
 
 <!-- 결과 메세지 -->
<%
	if( result == 1 ) {
%>
	<script>
		alert("답변완료");
		location="reBoardList.jsp";
	</script>
<%
	} else {
%>
	<script>
		alert("답변실패");
		location="reBoardList.jsp";
	</script>
<%
	}
%>
 
 