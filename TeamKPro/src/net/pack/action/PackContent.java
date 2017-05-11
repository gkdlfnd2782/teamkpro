package net.pack.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.pack.db.PackBean;
import net.pack.db.PackDAO;

public class PackContent implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		PackDAO pdao = new PackDAO();
		PackBean pb = new PackBean();
		
		System.out.println("PackContent num >> " + num);
		System.out.println("PackContent pagenum >> " + pageNum);
		
		pb = pdao.getPack(num);
		pdao.updateReadcount(num);
		
		System.out.println("area >> " + pb.getArea());
		System.out.println("Sarea >> " + pb.getSarea());
		
		session.setAttribute("PackBean", pb);
		
		
		
		//ActoinForward 이동정보 담아서 로그인 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./pack/Package_content.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
