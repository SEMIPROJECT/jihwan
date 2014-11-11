package semi;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class sal_searchCommand implements Command{
	ResultSet rs = null;
	Connection conn = null;                                        // null로 초기화 한다.
	PreparedStatement pstmt = null;
	DBConnectionMgr pool = null;

	int pdes = 0 , pnum=0;

	public Object processCommand(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		 pool = DBConnectionMgr.getInstance();		
		 try{
		 conn= pool.getConnection(); 
		 StockDto dto = new StockDto();
		 dto.setCode(Integer.parseInt(req.getParameter("code")));
		 
		 String sql = "select phdate,psa,pname,p.pdes,p.pnum from plist p , psal s where p.pdes = s.pdes and p.pnum = s.pnum and pcode = ?";                        // sql 쿼리
			pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
			pstmt.setInt(1,dto.getCode());
			rs = pstmt.executeQuery();   
			
			rs.next();
			
		 }catch(Exception err){
			 System.out.println("sal_searchCommand() :"+err);
		 }
		return "sal-search.jsp";
	}

}






















