<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
</head>
<body>
<%
    /* *** 사용된 API 요약 **************************************************************** 
        request.setCharacterEncoding() - request안에 들어있는 매개변수값들에 대한 인코딩 설정
        request.getParameter() - 매개변수값을 읽을때 사용되는 getter매서드
        Connection - DB연결과 관련된 정보를 가지는 데이터 타입
        PreparedStatement - 연결된 DB에 쿼리를 설정하고 실행할대 사용되는 데이터 타입
        Class.forName() - 매개변수로 입력되는 문자열의 데이터베이스를 사용할 수 있도록 초기화 시키는 메서드
        DriverManager.getConnection - 데이터베이스를 연결하는 메서드, Connection객체를 리턴함
    ********************************************************************************** */
    request.setCharacterEncoding("euc-kr");
    String boardPw = request.getParameter("boardPw");
    System.out.println("param boardPw:"+boardPw);
    String boardTitle = request.getParameter("boardTitle");
    System.out.println("param boardTitle:"+boardTitle);
    String boardContent = request.getParameter("boardContent");
    System.out.println("param boardContent:"+boardContent);
    String boardUser = request.getParameter("boardUser");
    System.out.println("param boardUser:"+boardUser);
    String dbUrl = "jdbc:mysql://127.0.0.1:3306/jjdev?useUnicode=true&characterEncoding=euckr";
    String dbUser = "root";
    String dbPw = "java0000";
    Connection connection = null;
    PreparedStatement statement = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
        String sql = "INSERT INTO board(board_pw, board_title, board_content, board_user, board_date) values(?,?,?,?,now())";
        statement = connection.prepareStatement(sql);
        statement.setString(1,boardPw);
        statement.setString(2,boardTitle);
        statement.setString(3,boardContent);
        statement.setString(4,boardUser);
        statement.executeUpdate(); // insert 쿼리를 실행
    
    //  쿼리 실행후 boardList.jsp 페이지로 이동하는 코드 - boardList.jsp페이지를 만들지 않아서 주석처리 해둠    
    response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } catch(Exception e) {
        e.printStackTrace();
        out.print("입력 예외 발생"); //  response.sendRedirect(request.getContextPath()+"/jsp_board/boardAddForm.jsp");
    } finally {
        try {statement.close();} catch(Exception e){}
        try {connection.close();} catch(Exception e){}
    }
%>
</body>
</html>

