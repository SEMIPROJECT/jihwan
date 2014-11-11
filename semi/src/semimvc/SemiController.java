package semimvc;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import mybean.semiDto;

public class SemiController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("controller success");
		req.setCharacterEncoding("euc-kr");
		String cmd = req.getParameter("command");
		String url = null;
		Command icmd = null;
		
		if(cmd.equals("INDEX")){
			//icmd = new IndexCommand();
		}
		else if(cmd.equals("INPUT")){
			System.out.println("INPUT");
			icmd = new InsertInputCommand();
		}
		else{
			// 비 정상적인 접근에 대한 처리
		}
		url = (String)icmd.processCommand(req, resp);
		RequestDispatcher view = req.getRequestDispatcher(url);
		view.forward(req, resp);
	}
}