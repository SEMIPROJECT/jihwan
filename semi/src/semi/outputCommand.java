package semi;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class outputCommand implements Command{
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	@Override
	public Object processCommand(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		pool=DBConnectionMgr.getInstance();
		String sql=null;
		try{
			con=pool.getConnection();
			
			StockDto dto = new StockDto();
			
			dto.setCode(Integer.parseInt(req.getParameter("code")));
			dto.setCount(Integer.parseInt(req.getParameter("count")));
			dto.setIdate(req.getParameter("date"));
			
		
			sql = "select iname, cname, price, sprice , des  from tlist where code = ?";   
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCode());
			rs=pstmt.executeQuery();
			
			rs.next();
			dto.setName(rs.getString("iname"));
			dto.setCname(rs.getString("cname"));
			dto.setPrice(rs.getInt("price"));
			dto.setSprice(rs.getInt("sprice"));
			dto.setDes(rs.getInt("des"));
			System.out.println("검색");
			
		String sql1="select count from tstock where code=?";
			pstmt=con.prepareStatement(sql1);
			pstmt.setInt(1, dto.getCode());
			rs=pstmt.executeQuery();
			rs.next();
			int count = rs.getInt("count");
			System.out.println(count);
			
			if(dto.getCount()<count){
			sql = "update tstock set count = count- ? where code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCount());
			pstmt.setInt(2, dto.getCode());
			int result=pstmt.executeUpdate();
			System.out.println("업뎃 리절트");
		
			if(result==0){
				sql= "insert into tstock values(?, ?, ?, ?, ?, ?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, dto.getCode());
				pstmt.setString(2, dto.getName());
				pstmt.setString(3,dto.getCname());
				pstmt.setInt(4, dto.getCount());
				pstmt.setInt(5, dto.getPrice());
				pstmt.setInt(6, dto.getSprice());
				pstmt.setInt(7, dto.getDes());
				pstmt.executeUpdate();
				System.out.println("출고 업뎃");
			
				sql = "insert into toutput values(? , ?, ?, ?,?)";
			       
			       pstmt = con.prepareStatement(sql);
			       pstmt.setInt(1, dto.getCode());
			       pstmt.setString(2, dto.getName());
			       pstmt.setInt(3, dto.getCount());
			       pstmt.setString(4, dto.getIdate()); //날짜
			       pstmt.setInt(5, dto.getDes()); // desc
			       pstmt.executeUpdate();
			      System.out.println("출고 업뎃");
			}
			else{
			sql = "insert into toutput values(?, ?, ?, ?,?)";     
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCode());
			pstmt.setString(2, dto.getName());
			pstmt.setInt(3, dto.getCount());
			pstmt.setString(4, dto.getIdate());
			pstmt.setInt(5, dto.getDes());
			pstmt.executeUpdate();
			  System.out.println("출고 업뎃");
			}
			}
			else if(dto.getCount()>count){
				System.out.println("재고가 부족합니다");
			}
		}
		catch(Exception err){
			System.out.println("output() : "+err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
		return "output.jsp";
	}

}
