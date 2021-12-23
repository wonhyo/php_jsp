<%@ page import="java.sql.*" %>

<HTML>
<HEAD>
<TITLE>Simple JSP to Oracle connection Example</TITLE>
</HEAD>
<BODY>
<%
    Connection conn = null;
    String ClassName = "oracle.jdbc.driver.OracleDriver" ;
    try
    {
        Class.forName(ClassName);
        out.print("Found Class "+ ClassName +"<br>");
        conn = DriverManager.getConnection("jdbc:oracle:oci:@localhost:1521:orcl", "scott", "tiger");
        out.println("connected....!!");

    }

    catch(Exception e)
    {
        out.println("Exception : " + e.getMessage() + "");
    }


%>
</BODY>
</HTML>

