<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- DB연결 -->
<%@ include file="../include/dbCon.jsp" %>

<!-- 2가지 넘어온다 => 삭제대상 (unq, 패스워드) 데이터 받기 -->

<%
	String unq = request.getParameter("unq");
	String pass = request.getParameter("pass");
	
%>

<!-- 유효성 체크 -->
<%
	if( unq == null || pass == null ) {
%>
	<script>
		alert("잘못된 경로로의 접근!!");
		location="boardList.jsp";
	</script>
<%	
		return;
	}
%>

<!-- 패스워드 일치 검사 -->
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

<!-- 삭제SQL 작성 및 실행 -->
<%
	String sql2 = "DELETE FROM nboard WHERE unq='"+unq+"' ";
	int result = stmt.executeUpdate(sql2);
	
%>

<!-- 결과 메세지 -->
<%
	if (result == 1 ) {
%>
	<script>
		alert("삭제완료");
		location="boardList.jsp";
	</script>
<%
	} else {
%> 
	<script>
		alert("삭제실패\n관리자에게 연락 부탁합니다.");
		location="boardList.jsp";
	</script>
<%
	}
%>


