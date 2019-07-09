<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BOARD REMOVE FORM</title>
</head>
<body>
<%
    // boardNo값이 넘어오지 않으면 boardList.jsp로 이동
    if(request.getParameter("boardNo") == null) {
        response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } else {
%>
        <form action="<%=request.getContextPath()%>/jsp_board/boardRemoveAction.jsp" method="post">
            <!-- boardPw와 함께 boardNo값도 숨겨서(hidden값으로) 넘김 -->
            <input name="boardNo" value="<%=request.getParameter("boardNo")%>" type="hidden"/>
            <div>비밀번호확인 :</div>
            <div><input name="boardPw" type="password"></div>
            <div>
                <input type="submit" value="삭제"/>
                <input type="reset" value="초기화"/>
            </div>
        </form>
<%    
    }
%>
</body>
</html>

