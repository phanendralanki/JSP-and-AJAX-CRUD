<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONArray"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
JSONArray list = new JSONArray();
String stid = request.getParameter("id");
Connection con;
PreparedStatement pst;
ResultSet rs;
JSONObject obj = new JSONObject();
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost/jspStudent","root","user");
pst = con.prepareStatement("delete from ajax where id = ?");
pst.setString(1, stid);
pst.executeUpdate();
obj.put("name", "success");
list.add(obj);
out.println(list.toJSONString());
out.flush();
%>