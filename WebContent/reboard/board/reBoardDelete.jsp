<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- DB연결 -->
<%@ include file="../include/dbCon.jsp" %>

<!-- 데이터 받기 -->
<%
	String unq = request.getParameter("unq");
	String pass = request.getParameter("pass");
%>

<!-- 유효성 체크 -->
<%
	if( unq == null || pass == null || unq.equals("") || pass.equals("") ) {
%>
	<script>
		alert("잘못된 경로의 접근입니다.");
		location = "/";	
	</script>
<%	
	return;
	}
%>

<!-- 암호 일치 검사 -->
<%
	String sql = " select count(*) cnt from reboard where unq='"+unq+"' and pass='"+pass+"' ";
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	int cnt = rs.getInt("cnt"); // cnt = 1, cnt = 0
	if( cnt == 0 ) {
%>
	<script>
		alert("암호가 일치하지 않습니다.");
		history.back();	
	</script>
<%
	return;
	}
%>

<!-- 자식레벨의(댓글)의 존재 유무 -->
<%
	String sql2 = "select gid, thread from reboard ";
		   sql2+= " where unq = '"+unq+"' ";
	ResultSet rs2 = stmt.executeQuery(sql2);
	rs2.next();
	int gid = rs2.getInt("gid");
	String thread = rs2.getString("thread");
	
	// like 검색의 "_"는 문자 1개를 의미, %는 문자열
	String sql3 = " select count(*) cnt2 from reboard ";
		   sql3+= " where gid='"+gid+"' and thread like '"+thread+"_' ";
	ResultSet rs3 = stmt.executeQuery(sql3);
	rs3.next();
	int cnt2 = rs3.getInt("cnt2");
	
%>

<!-- 존재하는 경우 설정 (UPDATE SQL) -->
<%
	int result = 0;
	if( cnt2 > 0) {
		String sql4 = "update reboard set title='작성자에 의한 삭제', content='' ";
			   sql4+= " where unq='"+unq+"' ";
		result = stmt.executeUpdate(sql4);
	}
	// 존재하지 않는 경우 설정 (DELETE SQL)
	else {
		String sql5 = " delete from reboard where unq='"+unq+"' ";
		result = stmt.executeUpdate(sql5);
	}
%>
<!-- 존재하지 않는 경우 설정 (DELETE SQL) -->


<!-- 결과 메세지 -->
<%
	if( result == 1 ) {
%>
	<script>
		alert("삭제완료");
		location="reBoardList.jsp";
	</script>
<%
	} else {
%>
	<script>
		alert("삭제실패");
		location="reBoardList.jsp";
	</script>
<%
	}
%>


