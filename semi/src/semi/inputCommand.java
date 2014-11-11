package semi;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class inputCommand implements Command{
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
			
			sql="SELECT iname, cname, price, sprice, des FROM tlist WHERE code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCode());
			rs=pstmt.executeQuery();
			
			if(rs.next()){
			dto.setName(rs.getString("iname"));
			dto.setCname(rs.getString("cname"));
			dto.setPrice(rs.getInt("price"));
			dto.setSprice(rs.getInt("sprice"));
			dto.setDes(rs.getInt("des"));
			
			System.out.println("°Ë»ö");
			
			sql="UPDATE tstock SET count = count+ ? WHERE code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCount());
			pstmt.setInt(2, dto.getCode());
			int result=pstmt.executeUpdate();
			System.out.println("¾÷µ« ¸®ÀýÆ®");
		
			if(result==0){
				sql="INSERT into tstock VALUES(?, ?, ?, ?, ?, ?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, dto.getCode());
				pstmt.setString(2, dto.getName());
				pstmt.setString(3,dto.getCname());
				pstmt.setInt(4, dto.getCount());
				pstmt.setInt(5, dto.getPrice());
				pstmt.setInt(6, dto.getSprice());
				pstmt.setInt(7, dto.getDes());
				pstmt.executeUpdate();
				System.out.println("Àç°í ¾÷µ«");
			   sql = "insert into tinput values(? , ?, ?, ?,?)";
			       
			       pstmt = con.prepareStatement(sql);
			       pstmt.setInt(1, dto.getCode());
			       pstmt.setString(2, dto.getName());
			       pstmt.setInt(3, dto.getCount());
			       pstmt.setString(4, dto.getIdate()); //³¯Â¥
			       pstmt.setInt(5, dto.getDes()); // desc
			       pstmt.executeUpdate();
			      System.out.println("ÀÔ°í ¾÷µ«");
			}
			else{
			sql="INSERT INTO tinput VALUES(?, ?, ?, ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCode());
			pstmt.setString(2, dto.getName());
			pstmt.setInt(3, dto.getCount());
			pstmt.setString(4, dto.getIdate());
			pstmt.setInt(5, dto.getDes());
			pstmt.executeUpdate();
			  System.out.println("ÀÔ°í ¾÷µ«");
			}
			}
		}
		catch(Exception err){
			System.out.println("addInput() : "+err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
		return "input.jsp";
	}

}
