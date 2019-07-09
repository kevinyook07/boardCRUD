<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
<!-- bootstrap을 사용하기 위한 CDN주소 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
 
</head>
<body>
<div class="container">
    <h1>BOARD VIEW</h1>
<%
    if(request.getParameter("boardNo") == null) {
        response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } else {
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        System.out.println("boardNo :"+boardNo);
        String dbUrl = "jdbc:mysql://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
        String dbUser = "root";
        String dbPw = "java0000";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
            String sql = "SELECT board_title, board_content, board_user, board_date FROM board WHERE board_no=?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, boardNo);
            resultSet = statement.executeQuery();
            if(resultSet.next()) {
%>
                <table class="table">
                    <tbody>
                        <tr>
                            <td>board_no :</td>
                            <td><%=boardNo%></td>
                        </tr>
                        <tr>
                            <td>board_title :</td>
                            <td><%=resultSet.getString("board_title")%></td>
                        </tr>
                        <tr>
                            <td>board_content :</td>
                            <td><%=resultSet.getString("board_content")%></td>
                        </tr>
                        <tr>
                            <td>board_user :</td>
                            <td><%=resultSet.getString("board_user")%></td>
                        </tr>
                        <tr>
                            <td>board_date :</td>
                            <td><%=resultSet.getString("board_date")%></td>
                        </tr>
                    </tbody>
                </table>
                  <a class="btn btn-default" href="<%=request.getContextPath()%>/jsp_board/boardModifyForm.jsp?boardNo=<%=boardNo%>">수정</a>
                <a class="btn btn-default" href="<%=request.getContextPath()%>/jsp_board/boardRemoveForm.jsp?boardNo=<%=boardNo%>">삭제</a>
                <a class="btn btn-default" href="<%=request.getContextPath()%>/jsp_board/boardList.jsp">글목록</a>
<%
            }
        } catch(Exception e) {
            e.printStackTrace();
            out.println("BOARD VIEW ERROR!");
        } finally {
            try {resultSet.close();} catch(Exception e){}
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
    }
%>
</div>
</body>
</html>

