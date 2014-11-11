package semi;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FrontController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String cmd = req.getParameter("cmd");
		Command icmd = null;
		StockDto dto = new StockDto();
		//System.out.println(cmd);
	//System.out.println(req.getParameter("code"));
		if(cmd.equals("INPUT")){	
			icmd = new inputCommand();	
		}
		else if(cmd.equals("OUTPUT")){
			icmd = new outputCommand();
		}
		
		String url=(String)icmd.processCommand(req, resp);
		RequestDispatcher view = req.getRequestDispatcher(url);
		view.forward(req, resp);
	}

}
