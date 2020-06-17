<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>SPROUT1</title>
</head>
<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		User user = new UserDAO().getUser(userID);
		
	%>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expaded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Sprout</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="board.jsp">게시판</a></li>
				<li><a href="store.jsp">스토어</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						<li class="active"><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="coll-lg-4"></div>
		<div class="coll-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="mypageAction.jsp">
					<h3 style="text-align: center;">회원 정보 수정</h3>
					<div class="form-group">
					<label>ID</label>
					<label><%=user.getUserID() %></label>
					</div>
					<div class="form-group">
					<label>Gender</label>
					<label><%=user.getUserGender() %></label>
					</div>
					<div class="form-group">
					<label>Password</label>
						<input type="text" class="form-control" value = <%=user.getUserPassword() %> name="userPasswaord" maxlength="20">
					</div>
					<div class="form-group">
					<label>Name</label>
						<input type="text" class="form-control" value = <%=user.getUserName() %> name="userName" maxlength="20">
					</div>
					<div class="form-group">
					<label>Email</label>
						<input type="email" class="form-control" value = <%=user.getUserEmail() %> name="userEmail" maxlength="50">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원 정보 수정">
				</form>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>