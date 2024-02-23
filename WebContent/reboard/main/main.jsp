<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>메인</title>
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
				<table>
					<caption>CSS 적용 테이블</caption>
					<colgroup>
						<col width="20%" />
						<col width="50%" />
						<col width="30%" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>날짜</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>도시까스요금..</td>
							<td>2018-02-02</td>
						</tr>
						<tr>
							<td>2</td>
							<td>도시까스요금..</td>
							<td>2018-02-02</td>
						</tr>
					</tbody>
				</table>
			</article>
		</section>
		<footer>
			<%@ include file = "../include/footer.jsp" %>
		</footer>
	</div>
	
</body>
</html>