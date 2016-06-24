<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%!
	Connection con; //접속시도가 아니라, 접속 후 그 정보를 보유함!!	
	PreparedStatement pstmt; //쿼리 수행 객체
%>
<%
	//클라이언트가 누구이던지, 이 jsp에게 regid를 파라미터로 전달하기만 하면 
	//오라클에 insert 시킨다!!
	
	//드라이버 로드!!
	Class.forName("oracle.jdbc.driver.OracleDriver");

	//접속 시도 
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String id="spring";
	String pwd="spring";
	
	con=DriverManager.getConnection(url, id, pwd);
	if(con !=null){
		out.print("접속 성공!!");
	}	
	String sql="insert into gcmuser(gcmuser_id, regid) values(seq_gcmuser.nextval,?)";
	pstmt=con.prepareStatement(sql); // 객체 생성!!!
		
	//바인드 변수 값 지정
	String regid = request.getParameter("regid");
	pstmt.setString(1, regid);
	
	//쿼리 수행!!
	int result=pstmt.executeUpdate(); //DML(insert, update, delete) 은 이 메서드로 수행!!
	if(result!=0){
		out.print("입력 성공");
	}else{
		out.print("입력 실패");
	}
	
	pstmt.close();
	con.close();
%>













