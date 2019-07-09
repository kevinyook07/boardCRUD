<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BOARD REMOVE ACTION</title>
</head>
<body>
<%
    // boardNo 나 boardPw값이 넘어오지 않으면 boardList.jsp로 이동
    if(request.getParameter("boardNo") == null || request.getParameter("boardPw") == null) {
        response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } else {
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        // System.out.println("boardNo :"+boardNo);
        String boardPw = request.getParameter("boardPw");
        // System.out.println("boardPw :"+boardPw);
        String dbUrl = "jdbc:mysql://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
        String dbUser = "root";
        String dbPw = "java0000";
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
            String sql = "DELETE FROM board WHERE board_no=? AND board_pw=?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, boardNo);
            statement.setString(2, boardPw);
            if(statement.executeUpdate()==1){
                response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
            } else {
                response.sendRedirect(request.getContextPath()+"/jsp_board/boardRemoveForm.jsp?boardNo="+boardNo);
            }
        } catch(Exception e) {
            e.printStackTrace();
            out.print("BOARD REMOVE ERROR!");
        } finally {
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
    }
%>
</body>
</html>