<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.android.gcm.server.MulticastResult"%>
<%@page import="com.google.android.gcm.server.Sender"%>
<%@ page import="com.google.android.gcm.server.Message"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%!
	String apiKey="AIzaSyAPa-x8fhkVkRxWwfFZ7uCH111ojsmpb4o";
%>
<%
	//클라이언트가 전송한 파라미터값들을 받아서, 해당 regid에 메세지 전송하자!!
	request.setCharacterEncoding("utf-8"); //파라미터에 대한 인코딩..
	String msg=request.getParameter("msg");
	String[] ch=request.getParameterValues("ch"); //html 양식의 컴포넌트가 배열일때...
	
	out.print(msg+"<br>");
	
	ArrayList<String> list = new ArrayList<String>();
	
	for(int i=0;i<ch.length;i++){
		out.print(ch[i]+"<br>");
		list.add(ch[i]); //regid 추가하기!!
	}

	//메세지 구성하기
	 Message.Builder builder = new Message.Builder();
	 builder.addData("msg", URLEncoder.encode(msg , "UTF-8"));
	 
	 Message message = builder.build();
	 
	 //메세지 전송하기
	 Sender sender=new Sender(apiKey);
	 MulticastResult result=sender.send(message, list , 5);
	 
	 out.print(result.getMulticastId()+","+result.getRetryMulticastIds()+","+result.getSuccess()); 

%>
