package semimvc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybean.DBConnectionMgr;
import mybean.semiDto;

public class InsertInputCommand implements Command {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	semiDto dto = new semiDto();
	
	public InsertInputCommand(){
		try{
			pool = DBConnectionMgr.getInstance();
		}
		catch(Exception err){
			System.out.println("InsertInputCommand() : " + err);
		}
	}
	@Override
	public Object processCommand(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("insertinput success");
		req.setCharacterEncoding("euc-kr");

		dto.setList_code(Integer.parseInt(req.getParameter("code")));
   	  	dto.setSt_cnt(Integer.parseInt(req.getParameter("count")));
   	   	dto.setIdate(req.getParameter("date"));
   	   	insertInput(dto);
   	   	
		return "/input_DBCP.jsp";
	}
	public void insertInput(semiDto dto){
		String sql1 = "";
		String sql2 = "";
		
		try{
			System.out.println("try문 입장");
			con = pool.getConnection();
			sql1 = "select iname, cname, price, sprice, des from tlist where code=?";
			pstmt = con.prepareStatement(sql1);
			pstmt.setInt(1, dto.getList_code());	
			
			rs = pstmt.executeQuery();
			rs.next();
			dto.setList_iname(rs.getString("iname"));
			dto.setList_cname(rs.getString("cname"));
			dto.setList_price(rs.getInt("price"));
			dto.setList_sell_price(rs.getInt("sprice"));
			dto.setList_des(rs.getInt("des"));
			System.out.println("dto 입력 ok");
			
			sql1 = "update tstock set count = count+ ? where code=?";
			pstmt = con.prepareStatement(sql1);
			pstmt.setInt(1, dto.getSt_cnt());
			pstmt.setInt(2, dto.getList_code());
			int result = pstmt.executeUpdate();
			System.out.println("update tstock 완료");
			
			if(result == 0){
				sql2 = "insert into tstock values(?, ?, ?, ?, ?, ?,?)";
				pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1, dto.getList_code());
				pstmt.setString(2, dto.getList_iname());
				pstmt.setString(3, dto.getList_cname());
				pstmt.setInt(4, dto.getSt_cnt());
				pstmt.setInt(5, dto.getList_price());
				pstmt.setInt(6, dto.getList_sell_price());
				pstmt.setInt(7, dto.getList_des());
				pstmt.executeUpdate();
				System.out.println("insert tstock 완료");
			}
			else{
				sql2 = "insert into tinput values(?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1, dto.getList_code());
				pstmt.setString(2, dto.getList_iname());
				pstmt.setInt(3, dto.getSt_cnt());
				pstmt.setString(4, dto.getIdate());
				pstmt.setInt(5, dto.getList_des());
				pstmt.executeUpdate();
				System.out.println("insert tinput 완료");
			}
		}
		catch(Exception err){
			System.out.println("insertInput() : " + err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
}