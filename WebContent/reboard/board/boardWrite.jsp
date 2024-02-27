<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 입력확인</title>
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

<script>
	function fn_submit() {
		
		var f = document.frm
		
		if(f.title.value == "") {
			alert("제목을 입력해주세요.");
			f.title.focus();
			return false;
		}
		
		if(f.pass.value == "") {
			alert("암호을 입력해주세요.");
			f.pass.focus();
			return false;
		}
		
		document.frm.submit();
	}
	
	function fn_onload() {
		docuemnt.frm.title.focus();	
	}
	
</script>

<body onload="fn_onload()">
	
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
				<form name="frm" method="post" action="boardWriteSave.jsp">
					<table>
						<caption> 게시판 입력화면 </caption>
						<colgroup>
							<col width="25%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>제목</th>
								<td><input type="text" name="title" class="box_title" required></td>
							</tr>
							<tr>
								<th>암호</th>
								<td><input type="password" name="pass" class="box_name" required></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" name="name" class="box_name"></td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<textarea name="content" rows="7" cols="50"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div style="width:600px; text-align: center; margin-top:10px;">
						<button type="submit" onclick="fn_submit(); return false; ">저장</button>
						<button type="reset">취소</button>
					</div>
				</form>
			</article>
		</section>
		<footer>
			<%@ include file = "../include/footer.jsp" %>
		</footer>
	</div>
	
</body>
</html>