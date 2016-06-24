<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String id = "spring";
	String pwd = "spring";%>
<%
	//오라클을 연동하여 regid를 출력하자!!
	Class.forName(driver); //드라이버 로드 
	con = DriverManager.getConnection(url, id, pwd); //접속 시도!!
	if (con == null) {
		out.print("접속할 수 없습니다.");
		return;
	}

	String sql = "select * from gcmuser";
	pstmt = con.prepareStatement(sql); //수행 객체 생성 

	rs = pstmt.executeQuery(); //select문일 경우 결과집합이 있으므로, executeQuery사용
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	//대왕체크박스 따라하기...
	function checkAll() {
		//체크박스 수만큼 반복문 돌리면서 대왕 체크박스 따라하기!!
		for(var i=0;i<form1.ch.length;i++){
			form1.ch[i].checked=form1.king.checked;
		}
	}

	function send() {
		form1.action="/admin/send.jsp";
		form1.submit();
	}
</script>
</head>
<body>
	<form name="form1" method="post">
		<table width="100%" border="1">
			<tr>
				<td><input type="checkbox" name="king" onClick="checkAll()"></td>
				<td>regid</td>
				<td>등록날짜</td>
			</tr>

			<%
				while (rs.next()) {
			%>
			<tr>
				<td><input type="checkbox" name="ch" value="<%=rs.getString("regid")%>"></td>
				<td><%=rs.getString("regid")%></td>
				<td><%=rs.getString("regdate")%></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="3">
				<input type="text" name="msg" size="50"> 
				<input type="button" value="메세지 전송" onClick="send()"></td>
			</tr>
		</table>
	</form>
</body>
</html>
<%
	rs.close();
	pstmt.close();
	con.close();
%>








