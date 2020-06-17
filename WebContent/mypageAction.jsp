<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SPROUT</title>
</head>
<body>
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

		
		//User user = new UserDAO().getUser(userID);
		//if (!userID.equals(user.getUserID())) {
			//PrintWriter script = response.getWriter();
			//script.println("<script>");
			//script.println("alert('권한이 없습니다.')");
			//script.println("location.href = 'main.jsp'");
			//script.println("</script>");
		//}
		//else
		{
			if (request.getParameter("userPasswaord") == null || request.getParameter("userEmail") == null || request.getParameter("userName")== null ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				UserDAO userDAO = new UserDAO();
				int result = userDAO.update(request.getParameter("userPasswaord"), request.getParameter("userName") , request.getParameter("userEmail"),userID);
//				int result = userDAO.update(user.getUserPasswaord(), user.getUserName(), user.getUserEmail(), user.getUserID());
				{
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원 정보 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
				}
			}
		}
	%>
</body>
</html>