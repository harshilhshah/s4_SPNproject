package spn_test;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		try
        {
            LoginBean user = new LoginBean();
            user.setUserName(request.getParameter("uname"));
            user.setPassword(request.getParameter("password"));
            if(request.getParameter("studentForm")!=null){
            	user.setUserType("student");
            }
            else{
            	user.setUserType("professor");
            }
            user = LoginDAO.login(user);
            if(user.isValid())
            {
                HttpSession session = request.getSession(true);
                session.setAttribute("currentSessionUser",user);
                RequestDispatcher rd1 = request.getRequestDispatcher("ProfessorMain.jsp");
                rd1.forward(request, response);  
            }else{
            	request.setAttribute("user", "fail");
            	RequestDispatcher rd = request.getRequestDispatcher("/" + user.getUserType() +  "_login.jsp");
                rd.forward(request, response);  
            }
        } catch (Throwable exc)
        {
            System.out.println(exc);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
