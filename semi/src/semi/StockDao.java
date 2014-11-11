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
		try{
		pool=DBConnectionMgr.getInstance();
		}catch(Exception err){
			System.out.println("StockDao() : "+err);
		}
	}
	
	// �԰��Է� �޼���
	public void addInput(StockDto dto){
		String sql=null;
		try{
			con=pool.getConnection();
			
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
			
			System.out.println("�˻�");
			
			sql="UPDATE tstock SET count = count+ ? WHERE code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCount());
			pstmt.setInt(2, dto.getCode());
			int result=pstmt.executeUpdate();
			System.out.println("���� ����Ʈ");
		
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
				System.out.println("��� ����");
			   sql = "insert into tinput values(? , ?, ?, ?,?)";
			       
			       pstmt = con.prepareStatement(sql);
			       pstmt.setInt(1, dto.getCode());
			       pstmt.setString(2, dto.getName());
			       pstmt.setInt(3, dto.getCount());
			       pstmt.setString(4, dto.getIdate()); //��¥
			       pstmt.setInt(5, dto.getDes()); // desc
			       pstmt.executeUpdate();
			      System.out.println("�԰� ����");
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
			  System.out.println("�԰� ����");
			}
			}
		}
		catch(Exception err){
			System.out.println("addInput() : "+err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	public void output(StockDto dto){
		String sql=null;
		try{
			con=pool.getConnection();
			
			sql = "select iname, cname, price, sprice , des from tlist where code = ?";   
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCode());
			rs=pstmt.executeQuery();
			
			if(rs.next()){
			dto.setName(rs.getString("iname"));
			dto.setCname(rs.getString("cname"));
			dto.setPrice(rs.getInt("price"));
			dto.setSprice(rs.getInt("sprice"));
			dto.setDes(rs.getInt("des"));
			
			System.out.println("�˻�");
			
			sql = "update tstock set count = count- ? where code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, dto.getCount());
			pstmt.setInt(2, dto.getCode());
			int result=pstmt.executeUpdate();
			System.out.println("���� ����Ʈ");
		
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
				System.out.println("��� ����");
			
				sql = "insert into toutput values(? , ?, ?, ?,?)";
			       
			       pstmt = con.prepareStatement(sql);
			       pstmt.setInt(1, dto.getCode());
			       pstmt.setString(2, dto.getName());
			       pstmt.setInt(3, dto.getCount());
			       pstmt.setString(4, dto.getIdate()); //��¥
			       pstmt.setInt(5, dto.getDes()); // desc
			       pstmt.executeUpdate();
			      System.out.println("��� ����");
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
			  System.out.println("��� ����");
			}
			}
		}
		catch(Exception err){
			System.out.println("output() : "+err);
		}
		finally{
			pool.freeConnection(con, pstmt, rs);
		}
	}
}
