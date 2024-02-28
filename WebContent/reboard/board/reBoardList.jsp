<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file = "../include/dbCon.jsp" %>

<%
	int unit = 10;

	String vpage = request.getParameter("vpage");
	if( vpage == null ) {
		vpage = "1";
	}
	
	int v_page = Integer.parseInt(vpage);
	
	// (1 -> 0) ; (2 -> 10) ; (3 -> 20) ; (4 -> 30)
	int index_no = (v_page-1) * unit;

	String sqlTot = "SELECT count(*) total FROM reboard";
	ResultSet rsTot = stmt.executeQuery(sqlTot);
	rsTot.next();
	int total = rsTot.getInt("total"); // 전체 데이터 개수
	
	// 19 -> 2, 29 -> 3, 39 -> 4
	// 19/10 -> 1.9 -> ceil(1.9) -> 2.0 -> (int)2.0 -> 2
	// 원래 나누기를 하면 -> 1.0이 나옴
	// 29/10 -> 2.9 -> ceil(2.9) -> 3.0 
	// 39/10 -> 3.9 -> ceil(3.9) -> 4.0
	// ceil은 올림메서드
	int lastpage = (int)Math.ceil((double)total/unit);
	
	int rownumber = total - index_no; // 행번호

	String sql = " SELECT unq,"; 
		   sql+= "	title, ";
		   sql+= "	name, "; 
		   sql+= "	date_format(rdate, '%Y-%m-%d') rdate, "; // left(rdate,10), subString(1, 10)
		   sql+= "	hits, ";
		   sql+= "  gid, ";
		   sql+= "	thread ";
		   sql+= "	FROM reboard ";
		   sql+= " 	ORDER BY gid DESC, thread ASC ";
		   sql+= "	LIMIT "+index_no+","+unit;	// limit 시작번호, 출력개수 (0, 10, 20)
	ResultSet rs = stmt.executeQuery(sql);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변형 게시판 목록</title>
<link rel="stylesheet" href="../css/layout.css" >

</head>
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
				<table >
					<caption> 
						<div>답변형 게시판 목록</div>
						<div style="display:flex; align-item: center; justify-content:center; margin-top: 5px;">
							<div style="font-size:12px; width:50%; height:30px; line-height:30px; text-align:left; font-weight:400; ">
								전체 데이터 개수 : 총 <%=total %>개
							</div> 
							<div style="width:50%; text-align:right; height:30px; margin-top:10px;">
								<button type="button" onclick="location='reBoardWrite.jsp' ">글쓰기</button>
							</div>
						</div>
					</caption>
					<colgroup>
						<col width="10%" />
						<col width="50%" />
						<col width="15%" />
						<col width="15%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>이름</th>
							<th>날짜</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<%
							while( rs.next() ) {
								int unq = rs.getInt("unq");
								String title = rs.getString("title");
								String name = rs.getString("name");
								String hits = rs.getString("hits");
								String rdate = rs.getString("rdate");
								String thread = rs.getString("thread");
								// a (원글) , (aa,ab,ac,ad ~)(댓글), (aaa,aab,aac)
								int len = thread.length();
								String re = "";
								if(len > 1) re = "[re]";
						%>
							<tr>
								<td><%=rownumber %></td>
								<td align="left">
								<%
									for(int i=1; i<len; i++) {
										out.print("&nbsp;&nbsp;");
									}
								%>
								<%=re %>
									<a href="reBoardDetail.jsp?unq=<%=unq %>"><%=title %></a>
								</td>
								<td><%=name %></td>
								<td><%=rdate %></td>
								<td><%=hits %></td>
							</tr>
						<%
								rownumber--;
							}
						%>
					</tbody>
				</table>
				
				<div style="width:600px; text-align:center; margin-top: 10px;">
					<%
						for( int i=1; i<=lastpage; i++ ) {
							//out.print("<a href='boardList.jsp?vpage="+i+"'>" +i+ "</a> " );
					%>
						<a href="boardList.jsp?vpage=<%=i %>"><%=i %></a>
					<%
						}
					%>
				</div>
				
			</article>
		</section>
		<footer>
			<%@ include file = "../include/footer.jsp" %>
		</footer>
	</div>
	
</body>
</html>