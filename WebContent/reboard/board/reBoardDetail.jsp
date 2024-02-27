<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/dbCon.jsp" %>
<%
	String unq = request.getParameter("unq");

	// 조회수증가 SQL
	String sql2 = "update reboard set hits=hits+1 where unq = '"+unq+"' ";
	stmt.executeUpdate(sql2);

	// 화면 출력 SQL
	String sql = "select title, name, content, rdate ";
		   sql+= " from reboard ";
		   sql+= " where unq='"+unq+"'";
		   
	ResultSet rs = stmt.executeQuery(sql);
	
	String title = "";
	String name = "";
	String content = "";
	String rdate = "";
	
	if( rs.next() ) {
		title = rs.getString("title");
		name = rs.getString("name");
		content = rs.getString("content");
		rdate = rs.getString("rdate");
		
		// replace메서드 \를 br로 바꿀수가 있다
		content = content.replace("\n","<br>");
		// 공간하나를 => nbsp;로 바꾼다
		content = content.replace(" ", "&nbsp;");
		
	} else {
%>
	<script>
		alert("잘못된 접근입니다!!");
		location = "../main/main.jsp";
	</script>
<%	
	return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변형 게시판 상세화면</title>
<link rel="stylesheet" href="../css/layout.css" >
</head>

<style>
	td {
		text-align: left;
	}

	.box_title {
		width: 98%;
	}
	
	.box_name {
		width: 150px;
	}
</style>

<body>

	<div class="wrap">
		<header>
			<div class="top_logo">
				
			</div>
			<div class="top_header">
			
			</div>
		</header>
		<nav>
			<%@ include file="../include/topmenu.jsp" %>
		</nav>
		<aside>
			<%@ include file="../include/leftmenu.jsp" %>
		</aside>
		<section>
			<article>
					<table>
						<caption>답변형 게시판 상세화면 </caption>
						<colgroup>
							<col width="25%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>제목</th>
								<td><%=title %></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><%=name %></td>
							</tr>
							<tr>
								<th>내용</th>
								<td height="100" valign="top">
									<%=content %>
								</td>
							</tr>
							<tr>
								<th>날짜</th>
								<td>
									<%=rdate %>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div style="width:600px; text-align: center; margin-top:10px;">
						<button type="button" onclick="location= 'reBoardWrite.jsp' ">입력</button>
						<button type="button" onclick="location= 'reBoardList.jsp' ">목록</button>
						<button type="button" onclick="location= 'replyWrite.jsp?unq=<%=unq %>' ">답변</button>
						<button type="button" onclick="location= 'reBoardModify.jsp?unq=<%=unq %>' ">수정</button>
						<button type="button" onclick="location= 'passWrite.jsp?unq=<%=unq %>&gubun=R '">삭제</button>
					</div>
			</article>
		</section>
		<footer>
			<%@ include file = "../include/footer.jsp" %>
		</footer>
	</div>
	
</body>
</html>