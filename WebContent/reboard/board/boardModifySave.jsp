<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- DB연결 -->
<%@ include file="../include/dbCon.jsp" %>

<!-- 데이터 받기 -->
<%
	String unq = request.getParameter("unq");
	String title = request.getParameter("title");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String content = request.getParameter("content");
%>

<!-- 데이터 유효성 체크 -->
<%
	if(unq == null || title == null || pass == null) {
%>
	<script>
		alert("잘못된 경로의 접근입니다.")
		location = "boardList.jsp" 
	</script>
<%		
	return;
	}
%>

<!-- 암호 일치 검사 -->
<%
	// unq : 7 ,, pass : 1234
	// select count(*) from nboard where nuq='7' and pass='1234'
	// result : 1 (일치) , 0 (비일치)
	String sql = "select count(*) cnt from nboard	";
		   sql+= "	where unq='"+unq+"' and pass='"+pass+"' ";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	int cnt = rs.getInt("cnt");
	
	if( cnt == 0 ) {
%>
	<script>
		alert("암호를 다시 확인해 주세요.");
		history.back();
	</script>
<%
	return;
	}
%>

<!-- UPDATE SQL 작성 및 적용 -->
<%
	// title, name, content, rdate
	String sql2 = " update nboard set ";
		   sql2+= "		title='"+title+"', ";
		   sql2+= " 	name='"+name+"', ";
		   sql2+= "		content='"+content+"',	";
		   sql2+= "		rdate=now() ";
		   sql2+= " 	where ";
		   sql2+= "		unq='"+unq+"' ";
	
	int result = stmt.executeUpdate(sql2);
%>

<!-- 메세지 출력 -->
<%
	if(result == 1) {
%>
	<script>
		alert("변경완료");
		location="boardList.jsp"
	</script>
<%
	
	} else {
%>
	<script>
		alert("변경실패\n관리자에게 문의해주세요.");
		location="boardList.jsp"
	</script>
<%
	}
%>


