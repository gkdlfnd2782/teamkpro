package net.pack.action;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.pack.db.PackBean;
import net.pack.db.PackDAO;

public class PackModifyAction implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		System.out.println("ModifyAction");

		// upload 폴더 만들기  5*1024*1024
		// MultipartRequest 객체 생성
		ServletContext context=request.getServletContext();
		String realPath=context.getRealPath("writeAPI/upload");
		int maxSize=5*1024*1024;
		MultipartRequest multi=new MultipartRequest(request, realPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println("Modify num >> " + num);
		
		String subject = multi.getParameter("subject");
		String intro = multi.getParameter("intro");
		String content = multi.getParameter("content");
		String area = multi.getParameter("area");
		String city = multi.getParameter("city");
		String sarea = multi.getParameter("sarea");
		int cost = Integer.parseInt(multi.getParameter("cost"));
		int stock = Integer.parseInt(multi.getParameter("stock"));
		String file1 = multi.getFilesystemName("file1");
		String file2 = multi.getFilesystemName("file2");
		String file3 = multi.getFilesystemName("file3");
		String file4 = multi.getFilesystemName("file4");
		String file5 = multi.getFilesystemName("file5");
		
		String sdate = multi.getParameter("sdate");
		
		String aa[] = sdate.split("-");
		
		String serial = aa[0] + aa[1] + aa[2];
		
		
		PackBean pb = new  PackBean();
		PackDAO pdao = new PackDAO();
		
		pb.setIntro(intro);
		pb.setSubject(subject);
		pb.setContent(content);
		pb.setArea(area);
		pb.setCity(city);
		pb.setSarea(sarea);
		pb.setCost(cost);
		pb.setStock(stock);
		pb.setSerial(Integer.parseInt(serial));
		
		// upload 폴더에 올라가는 파일이름		
		if(file1 == null){
			pb.setFile1(multi.getParameter("file1"));
		}else{
			pb.setFile1(file1);
		}
		
		if(file2 == null){
			pb.setFile2(multi.getParameter("file2"));
		}else{
			pb.setFile2(multi.getFilesystemName("file2"));
		}
		
		if(file3 == null){
			pb.setFile3(multi.getParameter("file3"));
		}else{
			pb.setFile3(multi.getFilesystemName("file3"));
		}
		
		if(file4 == null){
			pb.setFile4(multi.getParameter("file4"));
		}else{
			pb.setFile4(multi.getFilesystemName("file4"));
		}
		
		if(file5 == null){
			pb.setFile5(multi.getParameter("file5"));
		}else{
			pb.setFile5(multi.getFilesystemName("file5"));
		}
				
		pdao.updatePackcontent(pb, num);
		
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('글이 수정되었습니다');");
		out.println("location.href='./PackList.po';");
		out.println("</script>");
		out.close();
	
		
		return null;
		
	}

}
