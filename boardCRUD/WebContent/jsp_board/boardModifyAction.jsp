<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BOARD MODIFY ACTION</title>
</head>
<body>
<%
    request.setCharacterEncoding("euc-kr");
    if(request.getParameter("boardNo") == null || request.getParameter("boardPw") == null) {
        response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } else {
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        System.out.println("boardModifyAction param boardNo :"+boardNo);
        String boardPw = request.getParameter("boardPw");
        System.out.println("boardModifyAction param boardPw :"+boardPw);
        String boardTitle = request.getParameter("boardTitle");
        System.out.println("boardModifyAction param boardTitle :"+boardTitle);
        String boardContent = request.getParameter("boardContent");
        System.out.println("boardModifyAction param boardContent :"+boardContent);
        
        String dbUrl = "jdbc:mysql://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
        String dbUser = "root";
        String dbPw = "java0000";
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
            String selectSql = "UPDATE board SET board_title=?, board_content=? WHERE board_no=? AND board_pw=?";
            statement = connection.prepareStatement(selectSql);
            statement.setString(1, boardTitle);
            statement.setString(2, boardContent);
            statement.setInt(3, boardNo);
            statement.setString(4, boardPw);
            statement.executeUpdate();
            response.sendRedirect(request.getContextPath()+"/jsp_board/boardView.jsp?boardNo="+boardNo);
        } catch(Exception e) {
            e.printStackTrace();
            out.print("BOARD MODIFY ERROR!");
        } finally {
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
    }
%>
</body>
</html>