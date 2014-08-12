package spn_test;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginTest
 */
@WebServlet("/ProfessorServlet")
public class ProfessorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfessorServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			HttpSession session = request.getSession(true);
			LoginBean lb = (LoginBean)session.getAttribute("currentSessionUser");
			if (request.getParameter("prereq") != null) {
				request.setAttribute("prereq", true);
			}
			if (request.getParameter("gpa") != null) {
				request.setAttribute("gpa", true);
			}
			if (request.getParameter("credits") != null) {
				request.setAttribute("credits", true);
			}
			System.out.print(request.getAttribute("prereq") + " " + request.getAttribute("gpa") + "\n");
			ClassInfoDAO cdao = new ClassInfoDAO();
			ArrayList<ClassInfo> clist = cdao.getClassesByProf(lb.getUsername());
			int clen = clist.size();
			String par1 = "";
			String par2 = "";
			for(int i = 0; i < clen; i++){
				par1 = clist.get(i).getStringDeptid();
				par2 = clist.get(i).getStringCid();
				if(request.getParameter(par1 + " : " + par2)!=null){
					request.setAttribute("Sel", clist.get(i));
					break;
				}
			}
			request.setAttribute("formAction", "getTheInfo");
			RequestDispatcher rd = request.getRequestDispatcher("/ProfessorMain.jsp");
	        rd.forward(request, response); 
			
			
        } catch (Throwable exc) {
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
