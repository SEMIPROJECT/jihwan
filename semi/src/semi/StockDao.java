package semi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StockDao {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DBConnectionMgr pool;
	
	public StockDao(){
		pool=DBConnectionMgr.getInstance();
	}
	
	// 입고입력 메서드
	public void addInput(StockDto stockdto){
		String sql=null;
		try{
			con=pool.getConnection();
			
			sql="SELECT iname, cname, price, sprice, des FROM tlist WHERE code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, stockdto.getCode());
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				stockdto.setName(rs.getString("iname"));
				stockdto.setCname(rs.getString("cname"));
				stockdto.setPrice(rs.getInt("price"));
				stockdto.setSprice(rs.getInt("sprice"));
				stockdto.setDes(rs.getInt("des"));
			}
			
			sql="UPDATE tstock SET count = count+ ? WHERE code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, stockdto.getCount());
			pstmt.setInt(2, stockdto.getCode());
			int result=pstmt.executeUpdate();
			//System.out.println("업뎃 리절트 : "+result);
			
			if(result==0){
				sql="INSERT into tstock VALUES(?, ?, ?, ?, ?, ?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, stockdto.getCode());
				pstmt.setString(2, stockdto.getName());
				pstmt.setString(3,stockdto.getCname());
				pstmt.setInt(4, stockdto.getCount());
				pstmt.setInt(5, stockdto.getPrice());
				pstmt.setInt(6, stockdto.getSprice());
				pstmt.setInt(7, stockdto.getDes());
				pstmt.executeUpdate();
			}
			
			sql="INSERT INTO tinput VALUES(?, ?, ?, ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, stockdto.getCode());
			pstmt.setString(2, stockdto.getName());
			pstmt.setInt(3, stockdto.getCount());
			pstmt.setString(4, stockdto.getIdate());
			pstmt.setInt(5, stockdto.getDes());
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("addInput() : "+err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	
	// 출고입력 메서드
	public void addOutput(StockDto stockdto){
		String sql=null;
		try{
			con=pool.getConnection();
			
			sql="SELECT iname, cname, price, sprice, des FROM tlist WHERE code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, stockdto.getCode());
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				stockdto.setName(rs.getString("iname"));
				stockdto.setCname(rs.getString("cname"));
				stockdto.setPrice(rs.getInt("price"));
				stockdto.setSprice(rs.getInt("sprice"));
				stockdto.setDes(rs.getInt("des"));
			}
			
			sql="UPDATE tstock SET count = count- ? WHERE code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, stockdto.getCount());
			pstmt.setInt(2, stockdto.getCode());
			int result=pstmt.executeUpdate();
			
			
			if(result==0){
				sql="INSERT into tstock VALUES(?, ?, ?, ?, ?, ?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, stockdto.getCode());
				pstmt.setString(2, stockdto.getName());
				pstmt.setString(3,stockdto.getCname());
				pstmt.setInt(4, stockdto.getCount());
				pstmt.setInt(5, stockdto.getPrice());
				pstmt.setInt(6, stockdto.getSprice());
				pstmt.setInt(7, stockdto.getDes());
				pstmt.executeUpdate();
			}
			
			sql="INSERT INTO toutput VALUES(?, ?, ?, ?, ?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, stockdto.getCode());
			pstmt.setString(2, stockdto.getName());
			pstmt.setInt(3, stockdto.getCount());
			pstmt.setString(4, stockdto.getIdate());
			pstmt.setInt(5, stockdto.getDes());
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("addInput() : "+err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
}
