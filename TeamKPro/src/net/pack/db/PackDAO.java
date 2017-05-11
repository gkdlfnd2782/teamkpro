package net.pack.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PackDAO {

	Connection conn = null;
	PreparedStatement pstm = null;
	String sql = null;
	ResultSet rs = null;
	int num = 0;

	private Connection getConnection() throws Exception {
//		String dbid = "jspid";
//		String dbpass = "jsppass";
//		String dburl = "jdbc:mysql://localhost:3306/jspdb2";
//
//		Class.forName("com.mysql.jdbc.Driver");
//		conn = DriverManager.getConnection(dburl, dbid, dbpass);
//
//		return conn;

		
		
		//커넥션 풀 (Connection Poll)
		// 데이터베이스와 연결된 Connection 객체를 미리 생성
		// Pool 속에 저장해 두고 필요할때마다 접근하여 사용
		// 작업 끝나면 다시 반환
		
		//자카르타 DBCP API 이용한 커텍션 풀 
		//http://commons.apache.org/
		//commons-collections-3.2.1.jar
		//commons-dbcp-1.4.jar
		//commons-pool-1.6.jar
		
		// 1. WebContent - META-INF - context.xml 생성
		//    1단계, 2단계 기술 -> 디비연동 이름 정의
		// 2. WebContent - META-INF - web.xml 수정
		//    context.xml에 디비연동 해놓은 이름을 모든페이지에 알려줌
		// 3. DB작업(DAO) - 사용
		
		
		// Context 객체 생성
		Context init = new InitialContext();
		// DataSource = 디비연동 이름 불러오기
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/mysqlDB");
		// con = DataSource
		conn = ds.getConnection();
		return conn;
	}

	
	// 지역별로 분류
	public List getBoardList(int start, int count, String area) {
		List list = new ArrayList();

		try {
			conn = getConnection();
			sql = "select * from pack where area=? order by num desc limit ?, ?";
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, area);
			pstm.setInt(2, start - 1);
			pstm.setInt(3, count);

			rs = pstm.executeQuery();
			while (rs.next()) {
				PackBean PB = new PackBean();

				PB.setNum(rs.getInt("num"));
				PB.setSerial(rs.getInt("serial"));
				PB.setSubject(rs.getString("subject"));
				PB.setIntro(rs.getString("intro"));
				PB.setContent(rs.getString("content"));
				PB.setType(rs.getString("type"));
				PB.setArea(rs.getString("area"));
				PB.setCity(rs.getString("city"));
				PB.setCost(rs.getInt("cost"));
				PB.setReadcount(rs.getInt("readcount"));
				PB.setStock(rs.getInt("stock"));
				PB.setDate(rs.getString("date"));
				PB.setFile1(rs.getString("file1"));
				PB.setFile2(rs.getString("file2"));
				PB.setFile3(rs.getString("file3"));
				PB.setFile4(rs.getString("file4"));
				PB.setFile5(rs.getString("file5"));
				
				
				list.add(PB);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		finally {
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return list;
	}
	
	
	
	// 검색어(도시, 날짜) 있는 게시판 글 가져오기
	public List getBoardList_search(int start, int count, String search, int startDate, int endDate) {
		List list = new ArrayList();

		try {
			conn = getConnection();
//			sql = "select * from pack where city like ? order by num desc limit ?, ?";
			
			sql = "select * "
					+ "from(select substring(serial, 1, 8) sdate, "
					+ "num, serial, subject, intro, content, type, area, city, cost, readcount, stock, date, "
					+ "file1, file2, file3, file4, file5 from pack ) a "
					+ "where city like ? and sdate between ? and ? order by num desc";
	
			
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, "%" +  search + "%");
			pstm.setInt(2, startDate);
			pstm.setInt(3, endDate);
//			pstm.setInt(4, start - 1);
//			pstm.setInt(5, count);

			rs = pstm.executeQuery();
			while (rs.next()) {
				PackBean PB = new PackBean();
				PB.setNum(rs.getInt("num"));
				PB.setSerial(rs.getInt("serial"));
				PB.setSubject(rs.getString("subject"));
				PB.setIntro(rs.getString("intro"));
				PB.setContent(rs.getString("content"));
				PB.setType(rs.getString("type"));
				PB.setArea(rs.getString("area"));
				PB.setCity(rs.getString("city"));
				PB.setCost(rs.getInt("cost"));
				PB.setReadcount(rs.getInt("readcount"));
				PB.setStock(rs.getInt("stock"));
				PB.setDate(rs.getString("date"));
				PB.setFile1(rs.getString("file1"));
				PB.setFile2(rs.getString("file2"));
				PB.setFile3(rs.getString("file3"));
				PB.setFile4(rs.getString("file4"));
				PB.setFile5(rs.getString("file5"));

				list.add(PB);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		finally {
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return list;
	}
	
	// 검색어(도시, 날짜) 있는 게시판 갯수 카운터
	public int getPackCount(String search, int startDate, int endDate) {
		int count = 0;
		try {
			conn = getConnection();
//			sql = "select count(*) from pack where city like ?";
			
			sql = "select count(*) "
					+ "from (select substring(serial, 1, 8) sdate, city from pack) a "
					+ "where city like ? and sdate between ? and ?";
			
			
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, "%" + search + "%");
			pstm.setInt(2, startDate);
			pstm.setInt(3, endDate);
			rs = pstm.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		finally {
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return count;
	}
	
	
	public PackBean getPack(int num) {
		PackBean PB = new PackBean();
		try {
			conn = getConnection();
			sql = "select * from pack where num=?";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, num);
			rs = pstm.executeQuery();

			if (rs.next()) {
				PB.setNum(rs.getInt("num"));
				PB.setSerial(rs.getInt("serial"));
				PB.setSubject(rs.getString("subject"));
				PB.setIntro(rs.getString("intro"));
				PB.setContent(rs.getString("content"));
				PB.setType(rs.getString("type"));
				PB.setArea(rs.getString("area"));
				PB.setCity(rs.getString("city"));
				PB.setSarea(rs.getString("sarea"));
				PB.setCost(rs.getInt("cost"));
				PB.setReadcount(rs.getInt("readcount"));
				PB.setStock(rs.getInt("stock"));
				PB.setDate(rs.getString("date"));
				PB.setFile1(rs.getString("file1"));
				PB.setFile2(rs.getString("file2"));
				PB.setFile3(rs.getString("file3"));
				PB.setFile4(rs.getString("file4"));
				PB.setFile5(rs.getString("file5"));
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		finally {
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return PB;
	}
	
	
	public void insertPack(PackBean pb) {
		try {

			conn = getConnection();

			sql = "select max(num) from pack";
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();

			if (rs.next()) {
				num = rs.getInt(1) + 1;
			}
			
			int serial = Integer.parseInt(String.valueOf(pb.getSerial()) + String.valueOf(num));
			System.out.println("WriteInsert content >> " + pb.getContent());

			sql = "insert into pack(num, serial, subject, intro, content, area, city, sarea, cost, readcount, stock, date, file1, file2, file3, file4, file5) values(?,?,?,?,?,?,?,?,?,?,?,now(),?,?,?,?,?)";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, num);
			pstm.setInt(2, serial);
			pstm.setString(3, pb.getSubject());
			pstm.setString(4, pb.getIntro());
			pstm.setString(5, pb.getContent());
			pstm.setString(6, pb.getArea());
			pstm.setString(7, pb.getCity());
			pstm.setString(8, pb.getSarea());
			pstm.setInt(9, pb.getCost());
			pstm.setInt(10, 0);
			pstm.setInt(11, pb.getStock());
			pstm.setString(12, pb.getFile1());
			pstm.setString(13, pb.getFile2());
			pstm.setString(14, pb.getFile3());
			pstm.setString(15, pb.getFile4());
			pstm.setString(16, pb.getFile5());

			pstm.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		finally {
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	public void updateReadcount(int num) {
		try {
			conn = getConnection();
			sql = "update pack set readcount = readcount + 1 where num=?";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, num);
			pstm.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		finally {
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	
	
	public int updatePackcontent(PackBean pb, int num) {
		try {
			conn = getConnection();

//			sql = "select pass from pack where num=?";
//			pstm = conn.prepareStatement(sql);
//			pstm.setInt(1, bb.getNum());
//			rs = pstm.executeQuery();
//
//			if (rs.next()) {
//				if (rs.getString(1).equals(bb.getPass())) {
					sql = "update pack set subject=?, intro=?, content=?, area=?, city=?, sarea=?, cost=?, stock=?, file1=?, file2=?, file3=?, file4=?, file5=?  where num=?";
					pstm = conn.prepareStatement(sql);
					pstm.setString(1, pb.getSubject());
					pstm.setString(2, pb.getIntro());
					pstm.setString(3, pb.getContent());
					pstm.setString(4, pb.getArea());
					pstm.setString(5, pb.getCity());
					pstm.setString(6, pb.getSarea());
					pstm.setInt(7, pb.getCost());
					pstm.setInt(8, pb.getStock());
					pstm.setString(9, pb.getFile1());
					pstm.setString(10, pb.getFile2());
					pstm.setString(11, pb.getFile3());
					pstm.setString(12, pb.getFile4());
					pstm.setString(13, pb.getFile5());
					pstm.setInt(14, num);
					
					pstm.executeUpdate();
					return 1; // 수정 성공
//				} else
//					return -1; // 비번 틀림
//			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		finally {
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return 0; // 글번호 없음
	}
	
	

	public int deletePack(int num) {
		try {
			conn = getConnection();

//			sql = "select pass from pack where num=?";
//			pstm = conn.prepareStatement(sql);
//			pstm.setInt(1, num);
//			rs = pstm.executeQuery();
//
//			if (rs.next()) {
//				if (rs.getString(1).equals(pass)) {
					sql = "delete from pack where num=?";
					pstm = conn.prepareStatement(sql);
					pstm.setInt(1, num);
					pstm.executeUpdate();
					return 1;
//				} else
//					return 0;
//			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return -1;
	}
	
	

}
